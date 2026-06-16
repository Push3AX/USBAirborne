#include "CH554.H"
#include "DEBUG.H"
#include "USB.h"
#include "keyValue.h"
#include "flash.h"
#include "fat.h"
#include <stdio.h>
#include <string.h>

#pragma  NOAREGS

sbit SPI_CS = P1 ^ 4;	//SPI FLASH 片选引脚，视PCB布线修改

#define SPI_Tx( d )    { SPI0_DATA = d; while(S0_FREE == 0); }
#define SPI_Rx( d )    { SPI0_DATA = 0xFF; while(S0_FREE == 0); d = SPI0_DATA; }

UINT32 FlashSize = DISK_SEC_NUM * DISK_SEC_LEN;
UINT32 AutoRunInfSize = 0;

#define FAT_ROOT_DIR_ADDR       (UINT32)(0x41000UL)
#define FAT_DATA_START_ADDR     (UINT32)(0x45000UL)
#define FAT_CLUSTER_SIZE        (UINT32)(16UL * DISK_SEC_LEN)
#define BADUSB_READ_CHUNK       64

UINT8X BadUsbReadBuffer[BADUSB_READ_CHUNK];

UINT32 DetectFlashSize(void)
{
    UINT8 manufacturer, memoryType, capacity;

    SPI_CS = 0;
    SPI_Tx(0x9F);
    SPI_Rx(manufacturer);
    SPI_Rx(memoryType);
    SPI_Rx(capacity);
    SPI_CS = 1;

    if(capacity >= 0x15 && capacity <= 0x20)
    {
        if(capacity > 0x18)
            capacity = 0x18;
        return (UINT32)1 << capacity;
    }

    return DISK_SEC_NUM * DISK_SEC_LEN;
}

UINT32 FatClusterToAddr(UINT16 cluster)
{
    if(cluster < 2)
        cluster = 2;
    return FAT_DATA_START_ADDR + ((UINT32)cluster - 2) * FAT_CLUSTER_SIZE;
}

UINT8 MatchAutoRunChar(UINT8 dat, UINT8 pattern)
{
    if(dat >= 'A' && dat <= 'Z')
        dat += 'a' - 'A';
    if(pattern >= 'A' && pattern <= 'Z')
        pattern += 'a' - 'A';
    return dat == pattern;
}

UINT32 FindAutorunInfAddr(void)
{
    UINT8 FATDirEntry[128];
    UINT32 ReadFlashAddr = FAT_ROOT_DIR_ADDR;
    UINT32 FileFlashAddr = 0;
    UINT16 MaxRound = 32;
    UINT16 cluster = 0;
    UINT8 i = 0;

    AutoRunInfSize = 0;

    while(MaxRound--) {
        BulkReadFlash(ReadFlashAddr, 128, FATDirEntry);

        for(i = 0; i < 128; i += 32) {
            if(FATDirEntry[i] == 0x00)
                return 0;
            if(FATDirEntry[i] == 0xE5 || FATDirEntry[i + 11] == 0x0F)
                continue;

            if(MatchAutoRunChar(FATDirEntry[i], 'A') &&
               MatchAutoRunChar(FATDirEntry[i + 1], 'U') &&
               MatchAutoRunChar(FATDirEntry[i + 2], 'T') &&
               MatchAutoRunChar(FATDirEntry[i + 3], 'O') &&
               MatchAutoRunChar(FATDirEntry[i + 4], 'R') &&
               MatchAutoRunChar(FATDirEntry[i + 5], 'U') &&
               MatchAutoRunChar(FATDirEntry[i + 6], 'N') &&
               FATDirEntry[i + 7] == ' ' &&
               MatchAutoRunChar(FATDirEntry[i + 8], 'I') &&
               MatchAutoRunChar(FATDirEntry[i + 9], 'N') &&
               MatchAutoRunChar(FATDirEntry[i + 10], 'F')) {
                cluster = (UINT16)FATDirEntry[i + 26] | ((UINT16)FATDirEntry[i + 27] << 8);
                FileFlashAddr = FatClusterToAddr(cluster);
                AutoRunInfSize = (UINT32)FATDirEntry[i + 28] |
                                 ((UINT32)FATDirEntry[i + 29] << 8) |
                                 ((UINT32)FATDirEntry[i + 30] << 16) |
                                 ((UINT32)FATDirEntry[i + 31] << 24);

                if(FileFlashAddr >= FlashSize) {
                    AutoRunInfSize = 0;
                    return 0;
                }
                if(AutoRunInfSize > FlashSize - FileFlashAddr)
                    AutoRunInfSize = FlashSize - FileFlashAddr;

                return FileFlashAddr;
            }
        }

        ReadFlashAddr += 128;
    }

    return 0;
}

BOOL CheckAutoRunPayload()
{
    UINT32 ReadFlashAddr = FindAutorunInfAddr();
    UINT32 bytesLeft = AutoRunInfSize;
    UINT16 blockLen = 0;
    UINT16 chunkLen = 0;
    UINT16 MaxRound = 32;
    UINT8 dat = 0;
    UINT8 i = 0;

    UINT8 *patterns[] = {
        "[autorun]",
        "open=",
        "run=",
        "shellexecute=",
        "shell\\open\\command=",
        "action=",
        "icon=",
        "label="
    };
    UINT16 patternIndex[] = {0, 0, 0, 0, 0, 0, 0, 0};
    UINT16 patternCount = 8;
    UINT16 foundAutoRunSection = 0;

    if(ReadFlashAddr == 0 || bytesLeft == 0)
        return 0;

    while(bytesLeft && MaxRound--) {
        chunkLen = (bytesLeft > 65535UL) ? 65535 : (UINT16)bytesLeft;
        blockLen = chunkLen;

        SPI_CS = 0;
        SPI_Tx(0x0b);
        SPI_Tx(((ReadFlashAddr & 0xFFFFFF) >> 16));
        SPI_Tx(((ReadFlashAddr & 0xFFFF) >> 8));
        SPI_Tx(ReadFlashAddr & 0xFF);
        SPI_Tx(0xFF);

        while(blockLen--) {
            SPI_Rx(dat);

            for(i = 0; i < patternCount; i++) {
                if(MatchAutoRunChar(dat, patterns[i][patternIndex[i]])) {
                    patternIndex[i]++;
                    if(patterns[i][patternIndex[i]] == '\0') {
                        patternIndex[i] = 0;
                        if(i == 0)
                            foundAutoRunSection = 1;
                        else if(foundAutoRunSection) {
                            SPI_CS = 1;
                            return 1;
                        }
                    }
                } else {
                    patternIndex[i] = 0;
                }
            }
        }

        SPI_CS = 1;
        ReadFlashAddr += chunkLen;
        bytesLeft -= chunkLen;
    }

    return 0;
}
BOOL CheckFilesystem() {
    UINT8 i;

    for(i = 0; i < 16; i++) {
        if(ByteReadFlash(i) != ADDR_0x00[i]) return 0;
    }

    for(i = 0; i < 4; i++) {
        if(ByteReadFlash(0x1000 + i) != ADDR_0x1000_0x21000[i]) return 0;
    }

    return 1;
}

void WriteDataToFlash(UINT32 StartAddr, UINT8C* Data, UINT16 DataLen) {
    UINT32 BlockSize = 4096;
    UINT32 EndAddr = StartAddr + BlockSize;
    UINT32 CurrentAddr = StartAddr;
    UINT16 BytesToWrite;

    EraseFlash(StartAddr);

    while (CurrentAddr < StartAddr + DataLen) {
        if (DataLen - (CurrentAddr - StartAddr) < 64) {
            BytesToWrite = DataLen - (CurrentAddr - StartAddr);
        } else {
            BytesToWrite = 64;
        }
        BulkWriteFlash(CurrentAddr, BytesToWrite, Data + (CurrentAddr - StartAddr));
        CurrentAddr += BytesToWrite;
    }

    while (CurrentAddr < EndAddr) {
        BytesToWrite = (EndAddr - CurrentAddr < 64) ? (EndAddr - CurrentAddr) : 64;
        BulkWriteFlash(CurrentAddr, BytesToWrite, ZERO);
        CurrentAddr += BytesToWrite;
    }
}

void FormatFlash() {
    WriteDataToFlash(0x00, ADDR_0x00, sizeof(ADDR_0x00));
    WriteDataToFlash(0x1000, ADDR_0x1000_0x21000, sizeof(ADDR_0x1000_0x21000));
    WriteDataToFlash(0x21000, ADDR_0x1000_0x21000, sizeof(ADDR_0x1000_0x21000));
    WriteDataToFlash(0x41000, ZERO, sizeof(ZERO));
}

UINT8 BypassChineseIMEChar(UINT8 c)
{
    if((c >= 'a') && (c <= 'z')) return c - 'a' + 'A';
    if((c >= 'A') && (c <= 'Z')) return c - 'A' + 'a';
    return c;
}

void StopBypassChineseIME(UINT8 bypassChineseIME, UINT8 restoreCapsLock)
{
    if(bypassChineseIME)
    {
        RestoreCapsLockForBypass(restoreCapsLock);
    }
}

/*******************************************************************************
* Function Name  : ExecBadUSBPayload( void )
* Description    : 从SPI Flash芯片中读取配置文件，解析和执行BadUSB Payload
                                     别看了，没人能看懂。我自己都不知道是怎么写出来的。
*******************************************************************************/
void ExecBadUSBPayload()
{
    UINT32 ReadFlashAddr;
    UINT32 bytesLeft;
    UINT16 blockLen = 0;
    UINT16 chunkLen = 0;
    UINT8 dat = 0;
    UINT16 foundBadUSB = 0;
    UINT16 MaxRound = 1024;
    UINT16 i = 0;
    UINT8 bypassChineseIME = 0;
    UINT8 restoreCapsLock = 0;

    UINT8 *patterns[] = {
        "[BadUSB]",
        "[Enter]",
        "[Shift]",
        "[Capslock]",
        "[Win]",
        "[Win+R]",
        "[Alt+F4]",
        "[Win+D]",
        "[Win+L]",
        "[Win+E]",
        "[Ctrl+Alt+Del]",
        "[Delay]",
        "[Format]",
        "[BypassChineseIME]"
    };
    UINT16 patternIndex[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    UINT16 patternIndexFlag = 0;
    UINT16 patternFound[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    UINT16 patternCount = 14;

    SetMassStorageLocked(1);
    ReadFlashAddr = FindAutorunInfAddr();
    bytesLeft = AutoRunInfSize;

    if(ReadFlashAddr == 0 || bytesLeft == 0)
    {
        SetMassStorageLocked(0);
        return;
    }

    while(bytesLeft && MaxRound--)
    {
        chunkLen = (bytesLeft > BADUSB_READ_CHUNK) ? BADUSB_READ_CHUNK : (UINT16)bytesLeft;
        BulkReadFlash(ReadFlashAddr, chunkLen, BadUsbReadBuffer);

        for(blockLen = 0; blockLen < chunkLen; blockLen++)
        {
            dat = BadUsbReadBuffer[blockLen];

            for(i = 0; i < patternCount; i++)
            {
                if(dat == patterns[i][patternIndex[i]])
                {
                    patternIndex[i]++;
                    if(patterns[i][patternIndex[i]] == '\0')
                    {
                        patternFound[i] = 1;
                        patternIndex[i] = 0;

                        if(i == 0)
                        {
                            if(!foundBadUSB)
                            {
                                foundBadUSB = 1;
                            }
                            else
                            {
                                StopBypassChineseIME(bypassChineseIME, restoreCapsLock);
                                SetMassStorageLocked(0);
                                return;
                            }
                        }
                    }
                }
                else
                {
                    patternIndex[i] = 0;
                }
            }

            patternIndexFlag = 0;
            for(i = 0; i < patternCount; i++) patternIndexFlag += patternIndex[i];
            for(i = 0; i < patternCount; i++) patternIndexFlag += patternFound[i];
            if(foundBadUSB && patternIndexFlag == 0 && dat != '\n' && dat != '\r' && dat != '\0')
            {
                if(bypassChineseIME) dat = BypassChineseIMEChar(dat);
                SendChar(dat);
            }

            for(i = 0; i < patternCount; i++)
            {
                if(patternFound[i])
                {
                    switch(i)
                    {
                        case 1: SendChar('\n'); break;
                        case 2: SendKey(KB_LeftShift, KB_NULL); break;
                        case 3: SendKey(KB_NULL, KB_CAPS_LOCK); break;
                        case 4: SendKey(KB_LeftGUI, KB_NULL); break;
                        case 5: SendKey(KB_LeftGUI, KB_R); break;
                        case 6: SendKey(KB_LeftALT, KB_F4); break;
                        case 7: SendKey(KB_LeftGUI, KB_D); break;
                        case 8: SendKey(KB_LeftGUI, KB_L); break;
                        case 9: SendKey(KB_LeftGUI, KB_E); break;
                        case 10: SendKey(KB_LeftControl | KB_LeftALT, KB_DEL); break;
                        case 11: mDelaymS(500); break;
                        case 12:
                            StopBypassChineseIME(bypassChineseIME, restoreCapsLock);
                            WriteDataToFlash(0x00, ZERO, sizeof(ZERO));
                            SetMassStorageLocked(0);
                            CH554SoftReset();
                            break;
                        case 13:
                            if(bypassChineseIME)
                            {
                                StopBypassChineseIME(bypassChineseIME, restoreCapsLock);
                                bypassChineseIME = 0;
                                restoreCapsLock = 0;
                            }
                            else
                            {
                                restoreCapsLock = EnableCapsLockForBypass();
                                bypassChineseIME = 1;
                            }
                            break;
                    }
                    patternIndex[i] = 0;
                    patternFound[i] = 0;
                }
            }
        }

        ReadFlashAddr += chunkLen;
        bytesLeft -= chunkLen;
    }

    StopBypassChineseIME(bypassChineseIME, restoreCapsLock);
    SetMassStorageLocked(0);
    return;
}
/*******************************************************************************
* Function Name  : InitFlash( void )
* Description    : Flash闪存初始化
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void InitFlash(void)
{
    mInitSTDIO();
    InitHostSPI0();
    FlashSize = DetectFlashSize();
    WriteFlashEnable();
    WriteFlashStatus(0x00);
}

/*******************************************************************************
* Function Name  : InitHostSPI0( void )
* Description    : SPI0 init
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void InitHostSPI0(void)
{
    SPI0_SETUP &= ~(bS0_MODE_SLV | bS0_BIT_ORDER);              // Master模式, 高位在前
    SPI0_CTRL = bS0_SCK_OE | bS0_MOSI_OE;                       // 模式0
    SPI0_CK_SE = 0x02;                                          // 2分频
    P1_MOD_OC |= (bMOSI | bMISO | bSCK | bSCS);
    P1_DIR_PU |= (bMOSI | bMISO | bSCK | bSCS);
}

/*******************************************************************************
* Function Name  : ReadFlashStatus
* Description    : 用来读取状态寄存器,并返回状态寄存器的值
* Input          : None
* Output         : None
* Return         : ExFlashRegStatus
*******************************************************************************/
UINT8 ReadFlashStatus(void)
{
    UINT8 FlashStatus;

    SPI_CS = 0;
    SPI_Tx(0x05);                                       // Read Status Register
    SPI_Rx(FlashStatus);                                // 读取状态寄存器
    SPI_CS = 1;

    return FlashStatus;
}

/*******************************************************************************
* Function Name  : WaitFlashBusy
* Description    : 等待芯片空闲(在执行Byte-Program, Sector-Erase, Block-Erase, Chip-Erase操作后)
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void WaitFlashBusy(void)
{
    while((ReadFlashStatus()) & 0x01 == 0x01);          // 等待直到Flash空闲
}

/*******************************************************************************
* Function Name  : WriteFlashStatus
* Description    : 往状态寄存器里写一个字节
* Input          : status -写入的数据
* Output         : None
* Return         : None
*******************************************************************************/
void WriteFlashStatus(UINT8 status)
{
    SPI_CS = 0;
    SPI_Tx(0x01);                                       // Write Status Register
    SPI_Tx(status);                                     // 改变寄存器里BPx或者BPL(只有2,3,4,5,7位可以改写)
    SPI_CS = 1;
}

/*******************************************************************************
* Function Name  : WriteFlashForbidden
* Description    : 写禁止
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void WriteFlashForbidden(void)
{
    SPI_CS = 0;
    SPI_Tx(0x04);
    SPI_CS = 1;
}

/*******************************************************************************
* Function Name  : WriteFlashEnable
* Description    : 写使能, 同样可以用于使能写状态寄存器
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void WriteFlashEnable(void)
{
    SPI_CS = 0;
    SPI_Tx(0x06);                                       // Write Enable
    SPI_CS = 1;
}

/*******************************************************************************
* Function Name  : CheckFlashWriteEnable
* Description    : 检查擦写操作前WEL位是否为1
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void CheckFlashWriteEnable(void)
{
    UINT8 WRENStatus;

    WRENStatus = ReadFlashStatus();
    if((WRENStatus & 0x02) != 0x02)
    {
        WriteFlashEnable();
    }
}
/*******************************************************************************
* Function Name  : EraseFlash
* Description    : 擦除4K Flash  擦除一个扇区
* Input          : Dst_Addr 0-1 ffff ffff ,清除任意地址所在的扇区。
* Output         : None
* Return         : None
*******************************************************************************/
void EraseFlash(UINT32 Dst_Addr) reentrant
{
    CheckFlashWriteEnable();
    SPI_CS = 0;
    SPI_Tx(0x20);                                       // 扇区擦除命令
    SPI_Tx(((Dst_Addr & 0xFFFFFF) >> 16));              // send 3 address bytes
    SPI_Tx(((Dst_Addr & 0xFFFF) >> 8));
    SPI_Tx(Dst_Addr & 0xFF);
    SPI_CS = 1;
    WaitFlashBusy();
}

/*******************************************************************************
* Function Name  : ByteReadFlash
* Description    : 读取一个地址内一个字节的数据.返回读取的数据
* Input          : UINT32 StarAddr -Destination Address 000000H - 1FFFFFH
* Output         : None
* Return         : byte -读取的数据
*******************************************************************************/
UINT8 ByteReadFlash(UINT32 StarAddr)
{
    UINT8 dat = 0;

    SPI_CS = 0;
    SPI_Tx(0x03);                                       // read command
    SPI_Tx(((StarAddr & 0xFFFFFF) >> 16));              // send 3 address bytes
    SPI_Tx(((StarAddr & 0xFFFF) >> 8));
    SPI_Tx(StarAddr & 0xFF);
    SPI_Rx(dat);
    SPI_CS = 1;

    return dat;                                         // return one byte read
}

/*******************************************************************************
* Function Name  : ByteWriteFlash
* Description    : 写数据
* Input          : StarAddr  -Destination Address 000000H - 1FFFFFH
*                  dat -要写入的数据
* Output         : None
* Return         : None
*******************************************************************************/
void ByteWriteFlash(UINT32 StarAddr, UINT8 dat)
{
    WriteFlashEnable();
    SPI_CS = 0;
    SPI_Tx(0x02);                                       // Page Program
    SPI_Tx(((StarAddr & 0xFFFFFF) >> 16));              // 发送3字节地址
    SPI_Tx(((StarAddr & 0xFFFF) >> 8));
    SPI_Tx(StarAddr & 0xFF);
    SPI_Tx(dat);                                        // 发送要写的数据
    SPI_CS = 1;
    WaitFlashBusy();
}

/*******************************************************************************
* Function Name  : BulkReadFlash
* Description    : 读取起始地址(StarAddr)内多个字节(Len)的数据.存入缓冲区RcvBuffer中
* Input          : StarAddr -Destination Address 000000H - 1FFFFFH
                   Len 读取数据长度
                   RcvBuffer 接收缓冲区起始地址
* Output         : None
* Return         : None
*******************************************************************************/
void BulkReadFlash(UINT32 StarAddr, UINT16 Len, PUINT8 RcvBuffer) reentrant
{
    UINT16 i;

    SPI_CS = 0;
    SPI_Tx(0x0b);                                       // fast read command
    SPI_Tx(((StarAddr & 0xFFFFFF) >> 16));              // send 3 address bytes
    SPI_Tx(((StarAddr & 0xFFFF) >> 8));
    SPI_Tx(StarAddr & 0xFF);
    SPI_Tx(0x00);
    for(i = 0; i < Len; i++)
    {
        SPI_Rx(RcvBuffer[i]);                           // 接收数据
    }
    SPI_CS = 1;
}

/*******************************************************************************
* Function Name  : BulkWriteFlash
* Description    : 将数据写入外部Flash
* Input          : StarAddr  -Destination Address 000000H - 1FFFFFH
                   Len 发送数据长度
*                  SendBuffer -发送数据缓冲区
* Output         : None
* Return         : None
*******************************************************************************/
void BulkWriteFlash(UINT32 StarAddr, UINT16 Len, PUINT8 SendBuffer) reentrant
{
    UINT16 i;

    WaitFlashBusy();
    WriteFlashStatus(0x00);
    WriteFlashEnable();
    SPI_CS = 0;
    SPI_Tx(0x02);
    SPI_Tx(((StarAddr & 0xFFFFFF) >> 16));
    SPI_Tx(((StarAddr & 0xFFFF) >> 8));
    SPI_Tx(StarAddr & 0xFF);
    for(i = 0; i < Len; i++)
    {
        SPI_Tx(SendBuffer[i]);
    }
    SPI_CS = 1;
    WriteFlashForbidden();
    WaitFlashBusy();
}
