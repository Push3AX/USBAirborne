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
	
BOOL CheckFilesystem() {
		UINT8 i;
		UINT32 ReadFlashAddr = 0x41000;
	

		for(i=0;i<16;i++){
				if(ByteReadFlash(ReadFlashAddr+i) != ADDR_0x41000[i]) return 0;
		}
		
		for(i=0;i<16;i++){
				if(ByteReadFlash(i) != ADDR_0x00[i]) return 0;
		}
		return 1;
}

void WriteDataToFlash(UINT32 StartAddr, UINT8C* Data, UINT16 DataLen) {
    UINT32 BlockSize = 4096;
    UINT32 EndAddr = StartAddr + BlockSize;
    UINT32 CurrentAddr = StartAddr;
    UINT16 BytesToWrite;

    // 擦除块
    EraseFlash(StartAddr);

    // 写入数据
    while (CurrentAddr < StartAddr + DataLen) {
        // 计算剩余要写入的字节数
        if (DataLen - (CurrentAddr - StartAddr) < 64) {
            BytesToWrite = DataLen - (CurrentAddr - StartAddr);
        } else {
            BytesToWrite = 64;
        }
        BulkWriteFlash(CurrentAddr, BytesToWrite, Data + (CurrentAddr - StartAddr));
        CurrentAddr += BytesToWrite;
    }

    // 填充剩余部分为0x00
    while (CurrentAddr < EndAddr) {
        BytesToWrite = (EndAddr - CurrentAddr < 64) ? (EndAddr - CurrentAddr) : 64;
        BulkWriteFlash(CurrentAddr, BytesToWrite, ZERO);
        CurrentAddr += BytesToWrite;
    }
}

void FormatFlash() {
	UINT32 i;	
	for (i=0;i<0x80000;i+=DISK_SEC_LEN)
	{
		EraseFlash(i);
	}
	for (i=0;i<0x80000;i+=128)
	{
		BulkWriteFlash(i,128,ZERO);
	}
	WriteDataToFlash(0x00, ADDR_0x00, sizeof(ADDR_0x00));
	WriteDataToFlash(0x1000, ADDR_0x1000_0x21000, sizeof(ADDR_0x1000_0x21000));
	WriteDataToFlash(0x21000, ADDR_0x1000_0x21000, sizeof(ADDR_0x1000_0x21000));
	WriteDataToFlash(0x41000, ADDR_0x41000, sizeof(ADDR_0x41000));
	WriteDataToFlash(0x45000, ADDR_0x45000, sizeof(ADDR_0x45000));
	WriteDataToFlash(0x55000, ADDR_0x55000, sizeof(ADDR_0x55000));
	WriteDataToFlash(0x5C000, ADDR_0x5C000, sizeof(ADDR_0x5C000));
	WriteDataToFlash(0x65000, ADDR_0x65000, sizeof(ADDR_0x65000));
}


/*******************************************************************************
* Function Name  : ExecBadUSBPayload( void )
* Description    : 从SPI Flash芯片中读取配置文件，解析和执行BadUSB Payload
									 别看了，没人能看懂。我自己都不知道是怎么写出来的。
*******************************************************************************/
void ExecBadUSBPayload() {
		//UINT8 DebugOutput[16];
	
		UINT8 FATDirEntry[128];
    UINT32 ReadFlashAddr = 0x41000;  // Flash中的起始地址
		UINT16 foundINF = 0;
	
	  UINT16 blockLen = 65535;		// SPI Flash每次最多读4K
    UINT8 dat = 0;
    UINT16 foundBadUSB = 0;
    UINT16 MaxRound = 32;				// 最多读32个4K
		UINT16 i = 0;
	
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
				"[Format]"
    };
    UINT16 patternIndex[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
		UINT16 patternIndexFlag = 0;
    UINT16 patternFound[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    UINT16 patternCount = 13;
	
		while (MaxRound-- && !foundINF) {
			BulkReadFlash(ReadFlashAddr, 128, FATDirEntry);

			// 遍历读取的数据，每个目录项32字节
			for (i = 0; i < 128; i += 32) {
					// 检查是否为AUTORUN.INF文件
					if (FATDirEntry[i] == 'A' && FATDirEntry[i + 1] == 'U' && FATDirEntry[i + 2] == 'T' &&
							FATDirEntry[i + 3] == 'O' && FATDirEntry[i + 4] == 'R' && FATDirEntry[i + 5] == 'U' &&
							FATDirEntry[i + 6] == 'N' && FATDirEntry[i + 8] == 'I' && FATDirEntry[i + 9] == 'N' &&
							FATDirEntry[i + 10] == 'F') 
					{
							// 提取起始簇号
							ReadFlashAddr =(UINT32) ((FATDirEntry[i + 26] + (FATDirEntry[i + 27] << 8))+2)*64*1024;
							foundINF=1;
							//sprintf(DebugOutput,"addr:%ld\n",ReadFlashAddr);
							//SendString(DebugOutput,strlen(DebugOutput));
							break;
					}
			}
			ReadFlashAddr += 128;
		}


		MaxRound = 32;
		if(!foundINF) ReadFlashAddr=0x60000;
    while (MaxRound--) {
        SPI_CS = 0;
        SPI_Tx(0x0b);  // fast read command
        SPI_Tx(((ReadFlashAddr & 0xFFFFFF) >> 16));  // send 3 address bytes
        SPI_Tx(((ReadFlashAddr & 0xFFFF) >> 8));
        SPI_Tx(ReadFlashAddr & 0xFF);
        SPI_Tx(0xFF);

        while (blockLen--) {
            SPI_Rx(dat);

            // Check for patterns
            for (i = 0; i < patternCount; i++) {
                if (dat == patterns[i][patternIndex[i]]) {
                    patternIndex[i]++;
                    if (patterns[i][patternIndex[i]] == '\0') {
                        patternFound[i] = 1;
                        patternIndex[i] = 0;
												//SPI_Rx(dat);

                        if (i == 0) {  // [BadUSB] pattern found
													if (!foundBadUSB)
													{
                            foundBadUSB = 1;
													} else {
														SPI_CS = 1;
														return;
													}
                        }
                    }
                } else {
                    patternIndex[i] = 0;
                }
            }
						
						// Send character if [BadUSB] found and this character is not in pattern
						patternIndexFlag = 0;
						for (i = 0; i < patternCount; i++) patternIndexFlag+=patternIndex[i];
						for (i = 0; i < patternCount; i++) patternIndexFlag+=patternFound[i];
            if (foundBadUSB && patternIndexFlag == 0 && dat != '\n' && dat != '\r' && dat != '\0') {
                SendChar(dat);
            }

            // Send key or perform action if special patterns found
            for (i = 0; i < patternCount; i++) {
                if (patternFound[i]) {
                    switch (i) {
                        case 1: SendChar('\n'); break;  // [Enter] pattern found
                        case 2: SendKey(KB_LeftShift, KB_NULL); break;  // [Shift]
                        case 3: SendKey(KB_NULL, KB_CAPS_LOCK); break;  // [Capslock]
                        case 4: SendKey(KB_LeftGUI, KB_NULL); break;  // [Win]
                        case 5: SendKey(KB_LeftGUI, KB_R); break;  // [Win+R]
                        case 6: SendKey(KB_LeftALT, KB_F4); break;  // [Alt+F4]
                        case 7: SendKey(KB_LeftGUI, KB_D); break;  // [Win+D]
                        case 8: SendKey(KB_LeftGUI, KB_L); break;  // [Win+L]
                        case 9: SendKey(KB_LeftGUI, KB_E); break;  // [Win+E]
                        case 10: SendKey(KB_LeftControl | KB_LeftALT, KB_DEL); break;  // [Ctrl+Alt+Del]
                        case 11: mDelaymS(500); break;  // [Delay]
                        case 12: WriteDataToFlash(0x00, ZERO, sizeof(ZERO));CH554SoftReset(); break;  // [Format]
                    }
										patternIndex[i] = 0;
                    patternFound[i] = 0;  // Reset flag
                }
            }
        }

        ReadFlashAddr += 65535;
        SPI_Tx(0xFF);
        SPI_CS = 1;
    }
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
    WriteFlashEnable();                             // FLASH写使能
    WriteFlashStatus(0x00);                         // 设置芯片为无保护
}

/*******************************************************************************
* Function Name  : InitHostSPI0( void )
* Description    : SPI0主机模式初始化
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
    
    WRENStatus = ReadFlashStatus();                     // 读取状态register
    if((WRENStatus & 0x02) != 0x02)                     // 检查WEL位置位
    {
        WriteFlashEnable();                             // 如果未置1进行相应处理,如对其进行写使能操作
    }
}

/*******************************************************************************
* Function Name  : EraseFlash
* Description    : 擦除4K Flash  擦除一个扇区
* Input          : Dst_Addr 0-1 ffff ffff ,清除任意地址所在的扇区。
* Output         : None
* Return         : None
*******************************************************************************/
void EraseFlash(UINT32 Dst_Addr)
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
void BulkReadFlash(UINT32 StarAddr, UINT16 Len, PUINT8 RcvBuffer)
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
void BulkWriteFlash(UINT32 StarAddr, UINT16 Len, PUINT8 SendBuffer)
{
    UINT16 i;

    WaitFlashBusy();                                // 等待Flash忙结束
    WriteFlashStatus(0x00);                         // 设置芯片为无保护
    WriteFlashEnable();                             // 写使能

    SPI_CS = 0;
    SPI_Tx(0x02);                                   // Page Program
    SPI_Tx(((StarAddr & 0xFFFFFF) >> 16));          // 发送3字节地址
    SPI_Tx(((StarAddr & 0xFFFF) >> 8));
    SPI_Tx(StarAddr & 0xFF);
    for(i = 0; i < Len; i++)
    {
        SPI_Tx(SendBuffer[i]);
    }
    SPI_CS = 1;
    WriteFlashForbidden();                          // 写禁止
    WaitFlashBusy();                                // 等待Flash忙结束
}
