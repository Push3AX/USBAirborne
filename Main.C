/************************************** INFO ***********************************
* File Name          : Main.C
* Author             : PushEAX
* Version            : V2.1
* Date               : 2022-3-24 23:10:12
* Description        : USBAirborne Firmware
*											 USB Mass Storage Device & HID Device on CH552
*******************************************************************************/
#include <stdio.h>
#include <string.h>
#include "CH554.H"
#include "Debug.H"
#include "keyboard.h"
#pragma  NOAREGS

#define THIS_ENDP0_SIZE     DEFAULT_ENDP0_SIZE
#define UsbSetupBuf     ((PUSB_SETUP_REQ)Ep0Buffer)
UINT8X  Ep0Buffer[THIS_ENDP0_SIZE+2]		_at_ 0x0000;    																	//Endpoint 0
UINT8X  Ep1Buffer[2 * MAX_PACKET_SIZE]	_at_ THIS_ENDP0_SIZE + 2 + MAX_PACKET_SIZE;  			//Endpoint 1 USB Mass Storage Device
UINT8X  Ep2Buffer[2 * MAX_PACKET_SIZE]	_at_ THIS_ENDP0_SIZE + 2 + 4 * MAX_PACKET_SIZE;  	//Endpoint 2 HID Keyboard

UINT8   UsbConfig = 0;
UINT8   UsbReady  = 0;
UINT8   IsHIDDataSent   = 0;
UINT8		IsHIDSendExploit	=	0;
sbit Key_ModeSelect = P1^1;     //存储设备模式选择按钮

UINT8 HIDData[] = {0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00}; //按键数据报文
UINT8C HIDReportDescriptor[] =  //HID描述符
{
    0x05, 0x01, 0x09, 0x06, 0xa1, 0x01, 0x05, 0x07,
    0x19, 0xe0, 0x29, 0xe7, 0x15, 0x00, 0x25, 0x01,
    0x75, 0x01, 0x95, 0x08, 0x81, 0x02, 0x95, 0x01,
    0x75, 0x08, 0x81, 0x01, 0x95, 0x03, 0x75, 0x01,
    0x05, 0x08, 0x19, 0x01, 0x29, 0x03, 0x91, 0x02,
    0x95, 0x05, 0x75, 0x01, 0x91, 0x01, 0x95, 0x06,
    0x75, 0x08, 0x15, 0x00, 0x25, 0x65, 0x05, 0x07,
    0x19, 0x00, 0x29, 0x65, 0x81, 0x00, 0xc0     
};

UINT8C  MyDevDescr[] =      // 设备描述符
{
    0x12, 0x01, 0x10, 0x01,
    0x00, 0x00, 0x00, THIS_ENDP0_SIZE,
    0x44, 0x33, 0x33, 0x35,                                 // 厂商ID和产品ID
    0x00, 0x01, 0x01, 0x02,
    0x00, 0x01
};

UINT8C  MyCfgDescr[] =      // 配置描述符, 接口描述符, 端点描述符
{
    0x09, 0x02, 0x39, 0x00, 0x02, 0x01, 0x00, 0x80, 0x64,   // 配置描述符
	
    0x09, 0x04, 0x00, 0x00, 0x02, 0x08, 0x06, 0x50, 0x00,   // U盘接口描述符
		0x07, 0x05, 0x01, 0x02, 0x40, 0x00, 0x00,               // 批量下传端点
    0x07, 0x05, 0x81, 0x02, 0x40, 0x00, 0x00,               // 批量上传端点
	 
		0x09, 0x04, 0x01, 0x00, 0x01, 0x03, 0x01, 0x01, 0x00, 												//键盘接口描述符
		0x09, 0x21, 0x11, 0x01, 0x00, 0x01, 0x22, sizeof(HIDReportDescriptor), 0x00, 	//HID类描述符
		0x07, 0x05, 0x82, 0x03, sizeof(HIDData), 0x00, 0x00 													//端点描述符
};

UINT8C  MyLangDescr[] =     // 语言描述符
{
    4, 0x03, 0x09, 0x04
};

UINT8C  MyManuInfo[] =      // 厂家信息
{
    14, 0x03, 'U', 0, 'S', 0, 'B', 0, '2', 0, '.', 0, '0', 0
};

UINT8C  MyProdInfo[] =      // 产品信息
{
    12, 0x03, 'U', 0, 'S', 0, 'B', 0, ' ', 0, ' ', 0
};

// Mass Storage
UINT8C  MAX_LUN[] = { 0 };

UINT8C  DBINQUITY_CD_ROM[] =       //CD-ROM INQUIRY inform
  {
    0x05,          /* 05:CD-ROM Device*/
    0x00,          /* 00:DRIVE_FIXED*/
    0x04,          /* Version: No conformance claim to standard 04 02*/
    0x02,

    0x1f,          /* Additional Length */
    0x00,          /* SCCS = 1: Storage Controller Component */
    0x00,
    0x00,
    /* Vendor Identification */
    ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',				/* Manufacturer: 8 bytes */
    /* Product Identification */
    'U', 'l', 't', 'r', 'a', ' ', 'U', 'S',				/* Product : 16 Bytes */
		'B', '2', '.', '0', ' ', ' ', ' ', ' ',
    /* Product Revision Level */
    '2', '.', '0', ' '														/* Version : 4 Bytes */
  };

UINT8C  DBINQUITY_USB_Drive[] =       //USB Drive INQUIRY inform
  {
    0x00,          /* 00:Direct Access Device*/
    0x80,          /* 80:DRIVE_REMOVABLE*/
    0x04,          /* Version: No conformance claim to standard 04 02*/
    0x02,

    0x1f,          /* Additional Length */
    0x00,          /* SCCS = 1: Storage Controller Component */
    0x00,
    0x00,
    /* Vendor Identification */
    ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',				/* Manufacturer: 8 bytes */
    /* Product Identification */
    'U', 'l', 't', 'r', 'a', ' ', 'U', 'S',				/* Product : 16 Bytes */
		'B', '2', '.', '0', ' ', ' ', ' ', ' ',
    /* Product Revision Level */
    '2', '.', '0', ' '														/* Version : 4 Bytes */
  };


// 修改恒定义的时候注意修改擦除函数，当前为擦除4k函数。需要相应修改这个函数即可。
#define DISK_SEC_LEN    (UINT32)(4096UL)                               	// 扇区大小 4KB
#define DISK_SEC_NUM    (UINT32)(1024UL)   															// 总扇区数
#define DISK_SEC_LAST   (UINT32)(2047999UL)                        			// 伪装成8G的U盘 1919999UL DISK_SEC_NUM-1


UINT8C  DBCAPACITY[] =      // 伪装的容量报文
{
    (DISK_SEC_LAST >> 24) & 0xFF, (DISK_SEC_LAST >> 16) & 0xFF, (DISK_SEC_LAST >> 8) & 0xFF, DISK_SEC_LAST & 0xFF, (DISK_SEC_LEN >> 24) & 0xFF, (DISK_SEC_LEN >> 16) & 0xFF, (DISK_SEC_LEN >> 8) & 0xFF, DISK_SEC_LEN & 0xFF
};

UINT8C  modesense3F[] =     // 物理扇区数
{
    0x0b, 0x00, 0x00, 0x08, (DISK_SEC_NUM >> 24) & 0xFF, (DISK_SEC_NUM >> 16) & 0xFF, (DISK_SEC_NUM >> 8) & 0xFF, DISK_SEC_NUM & 0xFF, 00, 00, 02, 00
};

UINT8C  mode5sense3F[] =    // 物理扇区数
{
    0x00, 0x06, 0x00, 0x00, 0x08, 0x00, 0x00, 0x08, (DISK_SEC_NUM >> 24) & 0xFF, (DISK_SEC_NUM >> 16) & 0xFF, (DISK_SEC_NUM >> 8) & 0xFF, DISK_SEC_NUM & 0xFF, 00, 00, 02, 00
};

typedef union _CBWCB
{
    unsigned char buf1[16];
} CBWCB;

typedef  union _MASS_PARA
{
    unsigned char buf[64];
    struct  _SENSE
    {
        unsigned char ErrorCode;
        unsigned char Reserved1;
        unsigned char SenseKey;
        unsigned char Information[4];
        unsigned char AddSenseLength;
        unsigned char Reserved2[4];
        unsigned char AddSenseCode;
        unsigned char AddSenseCodeQua;
        unsigned char Reserved3[4];
    } Sense;
    struct  _CBW
    {
        unsigned char dCBWsig[4];
        unsigned char dCBWTag[4];
        unsigned long dCBWDatL;
        unsigned char bmCBWFlags;
        unsigned char bCBWLUN;
        unsigned char bCBWCBLength;
        CBWCB        cbwcb;
    } cbw;
} MASS_PARA;

enum _HOST_DEV_DISAGREE
{
    CASEOK = 0,
    CASE1,
    CASE2,
    CASE3,
    CASE4,
    CASE5,
    CASE6,
    CASE7,
    CASE8,
    CASE9,
    CASE10,
    CASE11,
    CASE12,
    CASE13,
    CASECBW,
    CASECMDFAIL
};

#define FORMAT_UNIT             0x04
#define INQUIRY                 0x12
#define MODE_SELECT             0x15
#define MODE_SENSE5             0x5A
#define MODE_SENSE              0x1A
#define PER_RES_IN              0x5E
#define PER_RES_OUT             0x5F
#define PRE_OR_MED              0x1E
#define READ                    0x28
#define READ_CAPACITY           0x25
#define RELEASE                 0x17
#define REQUEST_SENSE           0x03
#define RESERVE                 0x16
#define STA_STO_UNIT            0x1B
#define SYN_CACHE               0x35
#define TES_UNIT                0x00
#define VERIFY                  0x2F
#define WRITE                   0x2A
#define WRITE_BUFFER            0x3B
#define FORMATCAP 							0x23
#define READTOC 								0x43
#define GET_EVE_STA_NOT 	  		0x4A
#define GET_CONF				 	  		0x46
#define PROFILE_LIST				 	  		0x46


union
{
    unsigned long mDataLength;                      // 数据长度
    unsigned char mdataLen[4];
} LEN;

MASS_PARA idata MassPara;
unsigned char mdCBWTag[4];                          // dCBWTag
bit CH375BULKUP;                                    // 数据上传
bit CH375BULKDOWN;                                  // 数据下传
bit CH375CSW;                                       // CSW上传标志
unsigned char BcswStatus;                           // CSW状态
unsigned char mSenseKey;
unsigned char mASC;
bit FSTALL;                                         // 数据错误标志
bit lastFSTALL;
bit pBuf_ReSelect = 0;
UINT32 Locate_Addr;
unsigned char *pBuf;


/*******************************************************************************
* Function Name  : USBDeviceCfg()
* Description    : USB设备模式配置
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void    InitUSB_Device(void)                                    // 初始化USB设备
{
    USB_CTRL = 0x00;                                            // 清空USB控制寄存器
    USB_CTRL &= ~bUC_HOST_MODE;                                 // 该位为选择设备模式
    USB_CTRL |=  bUC_DEV_PU_EN | bUC_INT_BUSY | bUC_DMA_EN;     // USB设备和内部上拉使能,在中断期间中断标志未清除前自动返回NAK
    USB_DEV_AD = 0x00;                                          // 设备地址初始化
    USB_CTRL &= ~bUC_LOW_SPEED;
    UDEV_CTRL &= ~bUD_LOW_SPEED;                                // 选择全速12M模式，默认方式
    UDEV_CTRL = bUD_PD_DIS;                                     // 禁止DP/DM下拉电阻
    UDEV_CTRL |= bUD_PORT_EN;                                   // 使能物理端口
	
	UEP1_DMA = Ep1Buffer;                                       	// 端点1 数据传输地址（U盘）
    UEP4_1_MOD = 0xC0;                                          // 端点1上下传缓冲区；端点0单64字节收发缓冲区
    UEP1_CTRL = bUEP_AUTO_TOG | UEP_T_RES_NAK | UEP_R_RES_ACK;  // 端点1自动翻转同步标志位，IN事务返回NAK，OUT返回ACK
	UEP0_DMA = Ep0Buffer;                                       	// 端点0数据传输地址
    UEP0_CTRL = UEP_R_RES_ACK | UEP_T_RES_NAK;                  // 手动翻转，OUT事务返回ACK，IN事务返回NAK
	UEP0_T_LEN = 0;
    UEP1_T_LEN = 0;                                             // 预使用发送长度一定要清空
	UEP2_DMA = Ep2Buffer;  																				// 端点2 数据传输地址（键盘）
		UEP2_3_MOD = bUEP2_TX_EN;
		UEP2_CTRL = bUEP_AUTO_TOG | UEP_T_RES_NAK;
		UEP2_T_LEN = 0;


    USB_INT_EN |= bUIE_SUSPEND;                                 // 使能设备挂起中断
    USB_INT_EN |= bUIE_TRANSFER;                                // 使能USB传输完成中断
    USB_INT_EN |= bUIE_BUS_RST;                                 // 使能设备模式USB总线复位中断
    USB_INT_FG |= 0x1F;                                         // 清中断标志
    IE_USB = 1;                                                 // 使能USB中断
    EA = 1;                                                     // 允许单片机中断
}


sbit SPI_CS = P1 ^ 4;																						//SPI FLASH 片选，视PCB布线修改
#define SPI_Tx( d )    { SPI0_DATA = d; while(S0_FREE == 0); }
#define SPI_Rx( d )    { SPI0_DATA = 0xFF; while(S0_FREE == 0); d = SPI0_DATA; }

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
/*******************************************************************************
* Function Name  : HIDSendData
* Description    : 端点2发送数据，即HID数据
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void HIDSendData()
{
	memcpy( Ep2Buffer, HIDData, sizeof(HIDData));
	UEP2_T_LEN = sizeof(HIDData);
	UEP2_CTRL = UEP2_CTRL & ~ MASK_UEP_T_RES | UEP_T_RES_ACK;
}

/*******************************************************************************
* Function Name  : SendKey
* Description    : 模拟键盘按下某键
* Input          : FunctionKey  功能键
									 Key          普通按键
										
* Output         : None
* Return         : None
*******************************************************************************/
void SendKey(UINT8 FunctionKey, UINT8 Key)
{
	IsHIDDataSent = 0;
	HIDData[0] = FunctionKey;
	HIDData[2] = Key;
	HIDSendData();
	while(!IsHIDDataSent);
	mDelaymS(5);
	
	IsHIDDataSent = 0;
	HIDData[0] = KB_NULL;
	HIDData[2] = KB_NULL;	
	HIDSendData();
	while(!IsHIDDataSent);
	mDelaymS(5);
}


/*******************************************************************************
* Function Name  : SendString
* Description    : 模拟键盘按下一串字符串
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void SendString(UINT8 *s,UINT8 num)
{
	UINT8 i;
	for(i=0;i<num;i++)
	{
		if((s[i]>='a')&&(s[i]<='z')){
			SendKey(KB_NULL,s[i]-'a'+KB_A);
		}else if((s[i]>='A')&&(s[i]<='Z')){
			SendKey(KB_LeftShift,s[i]-'A'+KB_A);
		}else if((s[i]>='1')&&(s[i]<='9')){
			SendKey(KB_NULL,s[i]-'1'+KB_1);
		}else{
			switch(s[i]){
				case '0':
					SendKey(KB_NULL,KB_0);
					break;
				case ' ':
					SendKey(KB_NULL,KB_SPACE);
					break;
				case '!':
					SendKey(KB_LeftShift,KB_1);
					break;
				case '@':
					SendKey(KB_LeftShift,KB_2);
					break;
				case '#':
					SendKey(KB_LeftShift,KB_3);
					break;
				case '$':
					SendKey(KB_LeftShift,KB_4);
					break;
				case '%':
					SendKey(KB_LeftShift,KB_5);
					break;
				case '^':
					SendKey(KB_LeftShift,KB_6);
					break;
				case '&':
					SendKey(KB_LeftShift,KB_7);
					break;
				case '*':
					SendKey(KB_LeftShift,KB_8);
					break;
				case '(':
					SendKey(KB_LeftShift,KB_9);
					break;
				case ')':
					SendKey(KB_LeftShift,KB_0);
					break;
				case '-':
					SendKey(KB_NULL,KB_SUB);
					break;
				case '_':
					SendKey(KB_LeftShift,KB_SUB);
					break;
				case '=':
					SendKey(KB_NULL,KB_EQUAL);
					break;
				case '+':
					SendKey(KB_LeftShift,KB_EQUAL);
					break;
				case '[':
					SendKey(KB_NULL,KB_LEFT_BRACKET);
					break;
				case '{':
					SendKey(KB_LeftShift,KB_LEFT_BRACKET);
					break;
				case ']':
					SendKey(KB_NULL,KB_RIGHT_BRACKET);
					break;
				case '}':
					SendKey(KB_LeftShift,KB_RIGHT_BRACKET);
					break;
				case '\\':
					SendKey(KB_NULL,KB_VERTICAL_LINE);
					break;
				case '|':
					SendKey(KB_LeftShift,KB_VERTICAL_LINE);
					break;
				case ';':
					SendKey(KB_NULL,KB_SEMICOLON);
					break;
				case ':':
					SendKey(KB_LeftShift,KB_SEMICOLON);
					break;
				case '`':
					SendKey(KB_NULL,KB_WAVE);
					break;
				case '~':
					SendKey(KB_LeftShift,KB_WAVE);
					break;
				case '\'':
					SendKey(KB_NULL,KB_QUOTE);
					break;
				case '"':
					SendKey(KB_LeftShift,KB_QUOTE);
					break;
				case ',':
					SendKey(KB_NULL,KB_COMMA);
					break;
				case '<':
					SendKey(KB_LeftShift,KB_COMMA);
					break;
				case '.':
					SendKey(KB_NULL,KB_DOT);
					break;
				case '>':
					SendKey(KB_LeftShift,KB_DOT);
					break;
				case '/':
					SendKey(KB_NULL,KB_QUESTION);
					break;
				case '?':
					SendKey(KB_LeftShift,KB_QUESTION);
					break;
				case '\t':
					SendKey(KB_NULL,KB_TAB);
					break;
				case '\n':
					SendKey(KB_NULL,KB_ENTER);
					break;
			}
		}
	}
}

void HIDSendExploit()
{
		mDelaymS(2000);
		SendKey(KB_LeftGUI,KB_R);
		mDelaymS(1000);
		SendString("chrome https://www.bilibili.com/video/BV1uT4y1P7CX\n",52);
		mDelaymS(1000);
}

// BLOCK ONLY  The Thirteen Cases
void  BulkThirteen(unsigned char Case)
{
    switch(Case)
    {
        case CASEOK:
        case CASE1:                                         /* Hn=Dn*/
        case CASE6:                                         /* Hi=Di*/
            BcswStatus = 0;
            break;
        case CASE12:                                        /* Ho=Do*/
            BcswStatus = 0;
            break;
        case CASE2:                                         /* Hn<Di*/
        case CASE3:                                         /* Hn<Do*/
            UEP1_CTRL = UEP1_CTRL | MASK_UEP_T_RES ;
            FSTALL = 1;
            // 这里上传端点设置一个STALL，待主机清掉 // may or may-not
            BcswStatus = 2;
            break;
        case CASE4:                                         /* Hi>Dn*/
        case CASE5:                                         /* Hi>Di*/
            UEP1_CTRL = UEP1_CTRL | MASK_UEP_T_RES ;
            FSTALL = 1;
            // 这里上传端点设置一个STALL，待主机清掉
            BcswStatus = 1;                                 // CSW_GOOD or CSW_FAIL
            break;
        case CASE7:                                         /* Hi<Di*/
        case CASE8:                                         /* Hi<>Do */
            UEP1_CTRL = UEP1_CTRL | MASK_UEP_T_RES ;
            FSTALL = 1;
            // 这里上传端点设置一个STALL，待主机清掉
            BcswStatus = 2;
            break;
        case CASE9:                                         /* Ho>Dn*/
        case CASE11:                                        /* Ho>Do*/
            UEP1_CTRL = UEP1_CTRL | MASK_UEP_R_RES ;
            FSTALL = 1;
            // 这里上传端点设置一个STALL，待主机清掉
            BcswStatus = 1;                                 // CSW_GOOD or CSW_FAIL
            break;
        case CASE10:                                        /* Ho<>Di */
        case CASE13:                                        /* Ho<Do*/
            UEP1_CTRL = UEP1_CTRL | MASK_UEP_T_RES ;
            FSTALL = 1;
            // 这里上传端点设置一个STALL，待主机清掉
            UEP1_CTRL = UEP1_CTRL | MASK_UEP_R_RES ;
            // 这里上传端点设置一个STALL，待主机清掉
            BcswStatus = 2;
            break;
        case CASECBW:                                       /* invalid CBW */
            UEP1_CTRL = UEP1_CTRL | MASK_UEP_T_RES ;
            FSTALL = 1;
            UEP1_CTRL = UEP1_CTRL | MASK_UEP_R_RES ;
            // 这里端点设置一个STALL，待主机清掉
            BcswStatus = 2;
            break;
        case CASECMDFAIL:
            UEP1_CTRL = UEP1_CTRL | MASK_UEP_T_RES ;
            FSTALL = 1;
            // 这里上传端点设置一个STALL，待主机清掉
            BcswStatus = 1;
            break;
        default:
            break;
    }
}

// 查询U盘容量
void  UFI_readCapacity(void)
{
    pBuf = DBCAPACITY;
    if(LEN.mDataLength > sizeof(DBCAPACITY))
        LEN.mDataLength = sizeof(DBCAPACITY);
    BcswStatus  = 0;
    mSenseKey   = 0;
    mASC        = 0;
}

// 查询U盘信息
void  UFI_inquiry(void)
{
    if (Key_ModeSelect == 0) //如果模式选择按钮被按下，则为U盘模式
    {  
        pBuf = DBINQUITY_USB_Drive;
        if(LEN.mDataLength > sizeof(DBINQUITY_USB_Drive))
            LEN.mDataLength = sizeof(DBINQUITY_USB_Drive);
        BcswStatus  = 0;
        mSenseKey   = 0;
        mASC        = 0;
    }
    else //默认为CD-ROM模式
    {
        pBuf = DBINQUITY_CD_ROM;
        if(LEN.mDataLength > sizeof(DBINQUITY_CD_ROM))
            LEN.mDataLength = sizeof(DBINQUITY_CD_ROM);
        BcswStatus  = 0;
        mSenseKey   = 0;
        mASC        = 0;
    } 
}

// 读取数据
void  UFI_read10(void)
{
    LEN.mDataLength = (((UINT32)MassPara.cbw.cbwcb.buf1[7] << 8) | (UINT32)MassPara.cbw.cbwcb.buf1[8]) * DISK_SEC_LEN;
    Locate_Addr = ((UINT32)MassPara.cbw.cbwcb.buf1[2] << 24) | ((UINT32)MassPara.cbw.cbwcb.buf1[3] << 16) | ((UINT32)MassPara.cbw.cbwcb.buf1[4] << 8) | (UINT32)MassPara.cbw.cbwcb.buf1[5];
    Locate_Addr = Locate_Addr * DISK_SEC_LEN;
    BcswStatus = 0;
    mSenseKey = 0;
    mASC = 0;
    pBuf_ReSelect = 1;
}

// 模式认识
void  UFI_modeSense(void)
{
    if(MassPara.cbw.cbwcb.buf1[2] == 0x3F)
    {
        if(LEN.mDataLength > sizeof(modesense3F)) LEN.mDataLength = sizeof(modesense3F);
        pBuf = modesense3F;
        BcswStatus = 0;
        mSenseKey = 0;
        mASC = 0;
    }
    else
    {
        CH375BULKUP = 0;
        mSenseKey = 5;
        mASC = 0x20;
        BcswStatus = 1;
        BulkThirteen(CASECMDFAIL);
    }
}

// 请求认识
void  UFI_requestSense(void)
{
    if(FSTALL | lastFSTALL)
    {
        lastFSTALL = FSTALL;
        FSTALL = 0;
        MassPara.Sense.ErrorCode = 0x70;
        MassPara.Sense.Reserved1 = 0;
        MassPara.Sense.SenseKey = mSenseKey;
        MassPara.Sense.Information[0] = 0;
        MassPara.Sense.Information[1] = 0;
        MassPara.Sense.Information[2] = 0;
        MassPara.Sense.Information[3] = 0;
        MassPara.Sense.AddSenseLength = 0x0a;
        MassPara.Sense.Reserved2[0] = 0;
        MassPara.Sense.Reserved2[1] = 0;
        MassPara.Sense.Reserved2[2] = 0;
        MassPara.Sense.Reserved2[3] = 0;
        MassPara.Sense.AddSenseCode = mASC;
        MassPara.Sense.AddSenseCodeQua = 00;
        MassPara.Sense.Reserved3[0] = 0;
        MassPara.Sense.Reserved3[1] = 0;
        MassPara.Sense.Reserved3[2] = 0;
        MassPara.Sense.Reserved3[3] = 0;
        pBuf = MassPara.buf;
        BcswStatus = 0;
    }
    else
    {
        lastFSTALL = FSTALL;
        FSTALL = 0;
        MassPara.Sense.ErrorCode = 0x70;
        MassPara.Sense.Reserved1 = 0;
        MassPara.Sense.SenseKey = 0x00;
        MassPara.Sense.Information[0] = 0;
        MassPara.Sense.Information[1] = 0;
        MassPara.Sense.Information[2] = 0;
        MassPara.Sense.Information[3] = 0;
        MassPara.Sense.AddSenseLength = 0x0a;
        MassPara.Sense.Reserved2[0] = 0;
        MassPara.Sense.Reserved2[1] = 0;
        MassPara.Sense.Reserved2[2] = 0;
        MassPara.Sense.Reserved2[3] = 0;
        MassPara.Sense.AddSenseCode = 0x00;
        MassPara.Sense.AddSenseCodeQua = 00;
        MassPara.Sense.Reserved3[0] = 0;
        MassPara.Sense.Reserved3[1] = 0;
        MassPara.Sense.Reserved3[2] = 0;
        MassPara.Sense.Reserved3[3] = 0;
        pBuf = MassPara.buf;
        BcswStatus = 0;
    }
}

// 测试U盘是否准备好
void  UFI_testUnit(void)
{
    CH375BULKDOWN = 0;
    CH375BULKUP = 0;
    BcswStatus = 0;
    mSenseKey = 0;
    mASC = 0;
}

// 允许移出磁盘
void  UFI_perOrMed(void)
{
		BcswStatus = 0;
    mSenseKey = 0;
    mASC = 0;
}

// 写入数据
void  UFI_write(void)
{
    UINT8 i, num;

    LEN.mDataLength = (((UINT32)MassPara.cbw.cbwcb.buf1[7] << 8) | (UINT32)MassPara.cbw.cbwcb.buf1[8]) * DISK_SEC_LEN;      // 写数据长度
    Locate_Addr = ((UINT32)MassPara.cbw.cbwcb.buf1[2] << 24) | ((UINT32)MassPara.cbw.cbwcb.buf1[3] << 16) | ((UINT32)MassPara.cbw.cbwcb.buf1[4] << 8) | (UINT32)MassPara.cbw.cbwcb.buf1[5];
    Locate_Addr = Locate_Addr * DISK_SEC_LEN;       // 写数据地址
		if (Locate_Addr<(UINT32)(5000000UL))
		{
			num = MassPara.cbw.cbwcb.buf1[8];               // 待写扇区数
			for(i = 0; i < num; i++)
					EraseFlash(Locate_Addr + i * DISK_SEC_LEN); // 擦除扇区
		}
		BcswStatus = 0;
		mSenseKey = 0;
		mASC = 0;
}

// 请求装载卸载设备
void  UFI_staStoUnit(void)
{
		CH375BULKDOWN = 0;
    CH375BULKUP = 0;
    BcswStatus = 0;
    mSenseKey = 0;
    mASC = 0;
}

// 校验存储器空间
void  UFI_verify(void)
{
    BcswStatus = 0;
    mSenseKey = 0;
    mASC = 0;
    // 这里这里只是作为演示所以没有真正检测物理存储器
    // 但实际上这一步一定要处理
}

void  UFI_modeSense5(void)
{
    if(MassPara.cbw.cbwcb.buf1[2] == 0x3F)
    {
        if(LEN.mDataLength > sizeof(mode5sense3F))
            LEN.mDataLength = sizeof(mode5sense3F);
        pBuf = mode5sense3F;
        BcswStatus = 0;
        mSenseKey = 0;
        mASC = 0;
    }
    else
    {
        CH375BULKUP = 0;
        mSenseKey = 5;
        mASC = 0x20;
        BcswStatus = 1;
        BulkThirteen(CASECMDFAIL);
    }
}

void  UFI_readTOC(void)
{
		UINT8C  TOC[] = {
			0x00,0x12,0x01,0x01,0x00,0x14,0x01,0x00,0x00,0x00,0x00,0x00,0x00,
			0x14,0xAA,0x00,0x00,0x00,0x0c,0x6c
		};
		pBuf = TOC;
    if(LEN.mDataLength > sizeof(TOC))
        LEN.mDataLength = sizeof(TOC);
    BcswStatus  = 0;
    mSenseKey   = 0;
    mASC        = 0;
}

void  UFI_GET_EVE_STA_NOT(void)
{
		UINT8C  TOC[] = {
						0x06,
						0x01,
						0x00,
						0x5E,
						0x00,
						0x00,
						0x00,
						0x00
						};
		pBuf = TOC;
    if(LEN.mDataLength > sizeof(TOC))
        LEN.mDataLength = sizeof(TOC);
    BcswStatus  = 0;
    mSenseKey   = 0;
    mASC        = 0;
}

// UFI CMD
void UFI_Hunding(void)
{
    switch(MassPara.cbw.cbwcb.buf1[0])
    {
        case INQUIRY:
            UFI_inquiry();
            break;
        case WRITE:
            UFI_write();
            break;
        case TES_UNIT:
            UFI_testUnit();
            break;
        case READ:
            UFI_read10();
            break;
        case REQUEST_SENSE:
            UFI_requestSense();
            break;
        case READ_CAPACITY:
            UFI_readCapacity();
            break;
        case VERIFY:
            UFI_verify();
            break;
				case FORMATCAP:
//						pBuf = DBFORMATCAP;
//						if(LEN.mDataLength > sizeof(DBFORMATCAP)) 
//								LEN.mDataLength = sizeof(DBFORMATCAP);		
						BcswStatus=0;
						mSenseKey=0;
						mASC=0;			
						break;
//      case MODE_SELECT:
//          UFI_modeSlect();
//          break;
        case MODE_SENSE:
            UFI_modeSense();
            break;
        case MODE_SENSE5:
            UFI_modeSense5();
            break;
//      case WRITE_BUFFER:
//          UFI_writeBuf();
//          break;
//      case PREVENT:
//          break;
//      case FORMAT_UNIT:
//          UFI_format();
//          break;
//      case RELEASE:
//          break;
        case STA_STO_UNIT:
            UFI_staStoUnit();
						IsHIDSendExploit=1;
            break;
        case PRE_OR_MED:
            UFI_perOrMed();
            break;
				case READTOC:
						UFI_readTOC();
						break;
				case GET_EVE_STA_NOT:
						UFI_GET_EVE_STA_NOT();
						break;
        default:
            mSenseKey = 5;
            mASC = 0x20;
            BcswStatus = 1;
            CH375BULKUP = 0;
            BulkThirteen(CASECBW);
            break;
    }
}

void mCH375BulkOnly()
{
    if(MassPara.buf[0] == 0x55)
    {
        if(MassPara.buf[1] == 0x53)
        {
            if(MassPara.buf[2] == 0x42)
            {
                if(MassPara.buf[3] == 0x43)
                {
//                  LEN.mDataLength = BIG_ENDIAN(MassPara.cbw.dCBWDatL);            // 做BO协议处理
                    LEN.mdataLen[3] = *(unsigned char *)(&MassPara.cbw.dCBWDatL);   /* 将PC机的低字节在前的16位字数据转换为C51的高字节在前的数据 */
                    LEN.mdataLen[2] = *((unsigned char *)(&MassPara.cbw.dCBWDatL) + 1);
                    LEN.mdataLen[1] = *((unsigned char *)(&MassPara.cbw.dCBWDatL) + 2);
                    LEN.mdataLen[0] = *((unsigned char *)(&MassPara.cbw.dCBWDatL) + 3);
                    mdCBWTag[0] = MassPara.buf[4];
                    mdCBWTag[1] = MassPara.buf[5];
                    mdCBWTag[2] = MassPara.buf[6];
                    mdCBWTag[3] = MassPara.buf[7];             
                                      // 取出数据长度
                    if(LEN.mDataLength)
                    {
                        CH375BULKDOWN   = (MassPara.cbw.bmCBWFlags & 0x80) ? 0 : 1; // 下传数据(OUT)
                        CH375BULKUP     = (MassPara.cbw.bmCBWFlags & 0x80) ? 1 : 0; // 上传数据(IN)
                    }
                    CH375CSW = 1;
                    UFI_Hunding();  // 调用UFI协议处理
                }
                else
                    UEP1_CTRL = UEP1_CTRL | MASK_UEP_T_RES ;
            }
            else
                UEP1_CTRL = UEP1_CTRL | MASK_UEP_T_RES ;
        }
        else
            UEP1_CTRL = UEP1_CTRL | MASK_UEP_T_RES ;
    }
    else
        UEP1_CTRL = UEP1_CTRL | MASK_UEP_T_RES ;
}

// 上传CSW
void mCH375UpCsw()
{
    unsigned char i;
    
    pBuf = &MassPara.buf[0];
    CH375CSW = 0;
    CH375BULKUP = 0;            // 取消数据上传
    MassPara.buf[0] = 0x55;     // dCSWSignature
    MassPara.buf[1] = 0x53;
    MassPara.buf[2] = 0x42;
    MassPara.buf[3] = 0x53;
    MassPara.buf[4] = mdCBWTag[0];
    MassPara.buf[5] = mdCBWTag[1];
    MassPara.buf[6] = mdCBWTag[2];
    MassPara.buf[7] = mdCBWTag[3];
    MassPara.buf[8] = 0;
    MassPara.buf[9] = 0;
    MassPara.buf[10] = LEN.mdataLen[1];
    MassPara.buf[11] = LEN.mdataLen[0];
    MassPara.buf[12] = BcswStatus;
    for(i = 0; i < 13; i++)
    {
        Ep1Buffer[MAX_PACKET_SIZE + i] = *pBuf;
        pBuf++;
    }
    UEP1_T_LEN = 13;
    UEP1_CTRL = UEP1_CTRL & ~ MASK_UEP_T_RES | UEP_T_RES_ACK;  // 允许上传
}

// 端点1上传数据(IN)
void mCH375bulkUpData()
{
    unsigned char len, i;
    
    if(LEN.mDataLength > 0x40)
    {
        len = 0x40;
        LEN.mDataLength -= 0x40;
    }
    else
    {
        len = (unsigned char) LEN.mDataLength;
        LEN.mDataLength = 0;
        CH375BULKUP = 0;
    }
    if(pBuf_ReSelect)
    {
        BulkReadFlash(Locate_Addr, len, &Ep1Buffer[MAX_PACKET_SIZE]);
        Locate_Addr += len;
        if(LEN.mDataLength == 0)
            pBuf_ReSelect = 0;
    }
    else
    {
        for(i = 0; i < len; i++)
        {
            Ep1Buffer[MAX_PACKET_SIZE + i] = *pBuf;
            pBuf++;
        }
    }
    UEP1_T_LEN = len;
    UEP1_CTRL = UEP1_CTRL & ~ MASK_UEP_T_RES | UEP_T_RES_ACK;  // 允许上传
}

UINT8I buffer[64];
// 端点1下传数据(OUT)
void mCH375BulkDownData()
{
    unsigned char len, i;

    len = USB_RX_LEN;
    for(i = 0; i != len; i++)
        buffer[i] = Ep1Buffer[i];   // 将数据读入到缓冲区
    BulkWriteFlash(Locate_Addr, len, &buffer[0]);
    Locate_Addr += len;
    LEN.mDataLength -= len;         // 全局数据长度减掉当前获得的长度
    if(LEN.mDataLength == 0)        // 如果数据为0, 则传送CSW
    {
        CH375BULKDOWN = 0;          // 下传完成
        mCH375UpCsw();              // 上传CSW
    }
}

/*******************************************************************************
* Function Name  : USB_DeviceInterrupt()
* Description    : CH554 USB模拟设置中断处理函数
*******************************************************************************/
void    USB_DeviceInterrupt(void) interrupt INT_NO_USB using 1                  // USB中断服务程序, 使用寄存器组1
{
    UINT8   len, i;
    static  UINT8   SetupReqCode, SetupLen;
    static  PUINT8  pDescr;

    if(UIF_TRANSFER)                                                            // USB传输完成
    {
        switch(USB_INT_ST & (MASK_UIS_TOKEN | MASK_UIS_ENDP))                   // 分析操作令牌和端点号
        {
            case UIS_TOKEN_IN | 1:                                              // endpoint 1# 端点上传
            {
                if(CH375BULKUP) mCH375bulkUpData();                             // 调用数据上传
                else if(CH375CSW) mCH375UpCsw();                                // 上传CSW
                else
                    UEP1_CTRL = UEP1_CTRL & ~ MASK_UEP_T_RES | UEP_T_RES_NAK;   // 暂停上传
                break;
            }
            case UIS_TOKEN_OUT | 1:                                             // endpoint 1# 端点下传
            {
                if(U_TOG_OK)                                                    // 不同步的数据包将丢弃
                {
                    if(CH375BULKDOWN)  mCH375BulkDownData();                    // 如果上传数据阶段则调用数据上传
                    else                                                        // 不是数据下传则判断是否
                    {
                        len = USB_RX_LEN;
                        if(!len)break;                                          // 数据包长度为零则跳出
                        for(i = 0; i != len; i++)
                            MassPara.buf[i] = Ep1Buffer[i];                     // 将数据读入到缓冲区
                        mCH375BulkOnly();
                        if(!CH375BULKDOWN)
                        {
                            if(CH375BULKUP) mCH375bulkUpData();                 // 调用批量数据上传
                            else if(!FSTALL) mCH375UpCsw();                     // 没有数据上传调用CSW上传
                            // 在这里做上传数据调用
                        }
                    }
                }
                break;
            }
						case UIS_TOKEN_IN | 2:                                              // endpoint 2# 端点上传
            {
								UEP2_T_LEN = 0;
                UEP2_CTRL = UEP2_CTRL & ~ MASK_UEP_T_RES | UEP_T_RES_NAK;   
								IsHIDDataSent = 1;   
								break;
            }
            case UIS_TOKEN_SETUP | 0:                                           // endpoint 0# SETUP
            {
                len = USB_RX_LEN;
                if(len == sizeof(USB_SETUP_REQ))                                // SETUP包长度
                {
                    SetupLen = UsbSetupBuf->wLengthL;
                    if(UsbSetupBuf->wLengthH || SetupLen > 0x7F)
                    {
                        SetupLen = 0x7F;                                        // 限制总长度
                    }
                    len = 0;                                                    // 默认为成功并且上传0长度
                    if((UsbSetupBuf->bRequestType & USB_REQ_TYP_MASK) != USB_REQ_TYP_STANDARD)  // 类请求
                    {
                        SetupReqCode = UsbSetupBuf->bRequest;
                        if(SetupReqCode == 0xFE)                                // GET MAX LUN
                        {
                            pDescr = (PUINT8)(&MAX_LUN[0]);
                            len = 1;
                            if(SetupLen > len)
                            {
                                SetupLen = len;                                 // 限制总长度
                            }
                            len = SetupLen >= THIS_ENDP0_SIZE ? THIS_ENDP0_SIZE : SetupLen;  // 本次传输长度
                            memcpy(Ep0Buffer, pDescr, len);                     // 加载上传数据
                            SetupLen -= len;
                            pDescr += len;
                            UsbReady = 1;
                        }
                    }
                    else                                                        // 标准请求
                    {
                        SetupReqCode = UsbSetupBuf->bRequest;
                        switch(SetupReqCode)                                    // 请求码
                        {
                            case USB_GET_DESCRIPTOR:
                                switch(UsbSetupBuf->wValueH)
                                {
                                    case USB_DESCR_TYP_DEVICE:                  // 设备描述符
                                        pDescr = MyDevDescr;
                                        len = sizeof(MyDevDescr);
                                        break;
                                    case USB_DESCR_TYP_CONFIG:                  // 配置描述符
                                        pDescr = MyCfgDescr;
                                        len = sizeof(MyCfgDescr);
                                        break;
                                    case USB_DESCR_TYP_STRING:                  // 字符串描述符
                                        switch(UsbSetupBuf->wValueL)
                                        {
                                            case 0:
                                                pDescr = MyLangDescr;
                                                len = sizeof(MyLangDescr);
                                                break;
                                            case 1:
                                                pDescr = MyManuInfo;
                                                len = sizeof(MyManuInfo);
                                                break;
                                            case 2:
                                                pDescr = MyProdInfo;
                                                len = sizeof(MyProdInfo);
                                                break;
                                            default:
                                                len = 0xFF;                     // 不支持的字符串描述符
                                                break;
                                        }
                                        break;
                                    case USB_DESCR_TYP_REPORT:
                                        switch(UsbSetupBuf->wValueL)
                                        {
                                            case 0:
                                                pDescr = HIDReportDescriptor;		// HID描述符
                                                len = sizeof(HIDReportDescriptor);
                                                break;
                                            default:
                                                len = 0xFF;                     // 不支持的字符串描述符
                                                break;
                                        }
                                        break;
                                    default:
                                        len = 0xFF;                             // 不支持的描述符类型
                                        break;
                                }
                                if(SetupLen > len)
                                {
                                    SetupLen = len;                             // 限制总长度
                                }
                                len = SetupLen >= THIS_ENDP0_SIZE ? THIS_ENDP0_SIZE : SetupLen; // 本次传输长度
                                memcpy(Ep0Buffer, pDescr, len);                 // 加载上传数据
                                SetupLen -= len;
                                pDescr += len;
                                break;
                            case USB_SET_ADDRESS:
                                SetupLen = UsbSetupBuf->wValueL;                // 暂存USB设备地址
                                break;
                            case USB_GET_CONFIGURATION:
                                Ep0Buffer[0] = UsbConfig;
                                if(SetupLen >= 1)
                                {
                                    len = 1;
                                }
                                break;
                            case USB_SET_CONFIGURATION:
                                UsbConfig = UsbSetupBuf->wValueL;
                                printf("Config\n");
                                break;
                            case USB_CLEAR_FEATURE:
                                if((UsbSetupBuf->bRequestType & USB_REQ_RECIP_MASK) == USB_REQ_RECIP_ENDP)  // 端点
                                {
                                    switch(UsbSetupBuf->wIndexL)
                                    {
                                        case 0x82:
                                            UEP2_CTRL = UEP2_CTRL & ~(bUEP_T_TOG | MASK_UEP_T_RES) | UEP_T_RES_NAK;
                                            break;
                                        case 0x02:
                                            UEP2_CTRL = UEP2_CTRL & ~(bUEP_R_TOG | MASK_UEP_R_RES) | UEP_R_RES_ACK;
                                            break;
                                        case 0x81:
                                            UEP1_CTRL = UEP1_CTRL & ~(bUEP_T_TOG | MASK_UEP_T_RES) | UEP_T_RES_NAK;
                                            if(CH375CSW) mCH375UpCsw();
                                            lastFSTALL = FSTALL;
                                            FSTALL = 0;
                                            break;
                                        case 0x01:
                                            UEP1_CTRL = UEP1_CTRL & ~(bUEP_R_TOG | MASK_UEP_R_RES) | UEP_R_RES_ACK;
                                            if(CH375CSW) mCH375UpCsw();
                                            lastFSTALL = FSTALL;
                                            FSTALL = 0;
                                            break;
                                        default:
                                            len = 0xFF;                         // 不支持的端点
                                            break;
                                    }
                                }
                                else
                                {
                                    len = 0xFF;                                 // 不是端点不支持
                                }
                                break;
                            case USB_GET_INTERFACE:
                                Ep0Buffer[0] = 0x00;
                                if(SetupLen >= 1)
                                {
                                    len = 1;
                                }
                                break;
                            case USB_GET_STATUS:
                                Ep0Buffer[0] = 0x00;
                                Ep0Buffer[1] = 0x00;
                                if(SetupLen >= 2)
                                {
                                    len = 2;
                                }
                                else
                                {
                                    len = SetupLen;
                                }
                                break;
                            default:
                                len = 0xFF;                                     // 操作失败
                                break;
                        }
                    }
                }
                else
                {
                    len = 0xFF;                                                 // SETUP包长度错误
                }
                
                if(len == 0xFF)                                                 // 操作失败
                {
                    SetupReqCode = 0xFF;
                    UEP0_CTRL = bUEP_R_TOG | bUEP_T_TOG | UEP_R_RES_STALL | UEP_T_RES_STALL;// STALL
                }
                else if(len <= THIS_ENDP0_SIZE)                                 // 上传数据或者状态阶段返回0长度包
                {
                    UEP0_T_LEN = len;
                    UEP0_CTRL = bUEP_R_TOG | bUEP_T_TOG | UEP_R_RES_ACK | UEP_T_RES_ACK;    // 默认数据包是DATA1
                }
                else                                                            // 下传数据或其它
                {
                    UEP0_T_LEN = 0;                                             // 虽然尚未到状态阶段，但是提前预置上传0长度数据包以防主机提前进入状态阶段
                    UEP0_CTRL = bUEP_R_TOG | bUEP_T_TOG | UEP_R_RES_ACK | UEP_T_RES_ACK;    // 默认数据包是DATA1
                }
                break;
            }
            case UIS_TOKEN_IN | 0:                                              // endpoint 0# IN
            {
                switch(SetupReqCode)
                {
                    case USB_GET_DESCRIPTOR:
                        len = SetupLen >= THIS_ENDP0_SIZE ? THIS_ENDP0_SIZE : SetupLen; // 本次传输长度
                        memcpy(Ep0Buffer, pDescr, len);                         // 加载上传数据
                        SetupLen -= len;
                        pDescr += len;
                        UEP0_T_LEN = len;
                        UEP0_CTRL ^= bUEP_T_TOG;                                // 翻转
                        break;
                    case USB_SET_ADDRESS:
                        USB_DEV_AD = USB_DEV_AD & bUDA_GP_BIT | SetupLen;
                        UEP0_CTRL = UEP_R_RES_ACK | UEP_T_RES_NAK;
                        break;
                    default:
                        UEP0_T_LEN = 0;                                         // 状态阶段完成中断或者是强制上传0长度数据包结束控制传输
                        UEP0_CTRL = UEP_R_RES_ACK | UEP_T_RES_NAK;
                        break;
                }
                break;
            }
            case UIS_TOKEN_OUT | 0:                                             // endpoint 0# OUT
            {
                UEP0_T_LEN = 0;
                UEP0_CTRL ^= bUEP_R_TOG;
                break;
            }
            default:
                break;
        }
        UIF_TRANSFER = 0;                                                       // 清中断标志
    }
    else if(UIF_BUS_RST)                                                        // USB总线复位
    {
        printf("Reset\n");
        UEP0_CTRL = UEP_R_RES_ACK | UEP_T_RES_NAK;
        UEP1_CTRL = bUEP_AUTO_TOG | UEP_R_RES_ACK | UEP_T_RES_NAK;
				UEP2_CTRL = bUEP_AUTO_TOG | UEP_R_RES_ACK | UEP_T_RES_NAK;
        USB_DEV_AD = 0x00;
        UIF_SUSPEND = 0;
        UIF_TRANSFER = 0;
        UIF_BUS_RST = 0;                                                        // 清中断标志
        UsbReady = 0;
    }
    else if(UIF_SUSPEND)                                                        // USB总线挂起/唤醒完成
    {
        UIF_SUSPEND = 0;
        if(USB_MIS_ST & bUMS_SUSPEND)                                           // 挂起
        {
            printf("Suspend\n");                                                // 睡眠状态
        }
        else                                                                    // 唤醒
        {
            printf("Awake\n");
        }
    }
    else
    {
        // 意外的中断,不可能发生的情况
        USB_INT_FG = 0xFF;                                                      // 清中断标志
    }
}


void main(void)
{
    CfgFsys();                                      // CH552时钟选择配置
    mDelaymS(100);                                   // 上电延时,等待内部晶振稳定,必加
    mInitSTDIO();

    InitHostSPI0();
    WriteFlashEnable();                             // FLASH写使能
    WriteFlashStatus(0x00);                         // 设置芯片为无保护
    
    InitUSB_Device();
    while(!UsbReady);
	
		//mDelaymS(2000);
		//SendKey(KB_LeftGUI,KB_R);
		//mDelaymS(1000);
		//SendString("cmd /k systeminfo\n ",20);
		//mDelaymS(1000);
	
    while(1)
    {
			//if(IsHIDSendExploit)
			//{
				//HIDSendExploit();
				//IsHIDSendExploit=0;
			//}
			mDelaymS(100);
    }
}
