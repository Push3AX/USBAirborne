/************************************** INFO ***********************************
* File Name          : Main.C
* Author             : PushEAX
* Version            : V2.1
* Date               : 2022-3-24 23:10:12
* Last Modified      : 2023-12-17 15:51:42
* Description        : USBAirborne Firmware: USB Mass Storage Device & HID Device on CH552
*******************************************************************************/
#include <stdio.h>
#include <string.h>
#include "lib\CH554.H"
#include "lib\Debug.H"
#include "lib\USB.h"
#include "lib\flash.h"
#include "lib\keyValue.h"
#pragma  NOAREGS

UINT8   USBReady = 0;
UINT8   ExecBadUSB =	0;
UINT8   AttackEnabled = 1;

/*******************************************************************************
如果你现在正在看这行字，那么说明你会自己编译USBAirborne的固件。
既然如此，我会更推荐你修改这个函数来执行BadUSB。
相比起读取Flash中的配置文件，在此执行的效率会更高，而且可以模拟更多种类的按键。
同时，通过在USB的不同UFI命令中将ExecBadUSB置1，可以实现例如在弹出U盘(STA_STO_UNIT)时执行BadUSB
*******************************************************************************/
void BadUSBDemo()
{
	UINT8 Payload[]="https://www.bilibili.com/video/BV1uT4y1P7CX\n";
	
	mDelaymS(1000);
	SendKey(KB_LeftShift, KB_NULL);	//切换输入法
	mDelaymS(500);
	SendKey(KB_LeftGUI, KB_R);
	mDelaymS(500);
	SendString(Payload,sizeof(Payload)/sizeof(Payload[0]));
	mDelaymS(500);
}


void main(void)
{
	CfgFsys();			// CH552时钟选择配置
	mDelaymS(100);	// 上电延时,等待内部晶振稳定
	InitFlash();
	
	if (P1_1 == 0)   AttackEnabled = 0;	// 如果针脚1^1拉低，关闭攻击模式
	mDelaymS(500);
	if(CheckFilesystem() == 0)	FormatFlash();	//如果Flash的0x41000不是FAT目录信息，格式化Flash
	InitUSB();
	while(!USBReady);	// 等待USB初始化
	
	mDelaymS(2000);
	if(AttackEnabled == 1)	ExecBadUSBPayload();
	while(1)
	{
		// 当ExecBadUSB为1时，执行BadUSB代码
		if(ExecBadUSB == 1 && AttackEnabled == 1)
		{
			ExecBadUSB=0;
			BadUSBDemo();
		}
		mDelaymS(100);
	}
}
