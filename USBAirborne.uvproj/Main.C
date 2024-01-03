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
������������ڿ������֣���ô˵������Լ�����USBAirborne�Ĺ̼���
��Ȼ��ˣ��һ���Ƽ����޸����������ִ��BadUSB��
������ȡFlash�е������ļ����ڴ�ִ�е�Ч�ʻ���ߣ����ҿ���ģ���������İ�����
ͬʱ��ͨ����USB�Ĳ�ͬUFI�����н�ExecBadUSB��1������ʵ�������ڵ���U��(STA_STO_UNIT)ʱִ��BadUSB
*******************************************************************************/
void BadUSBDemo()
{
	UINT8 Payload[]="https://www.bilibili.com/video/BV1uT4y1P7CX\n";
	
	mDelaymS(1000);
	SendKey(KB_LeftShift, KB_NULL);	//�л����뷨
	mDelaymS(500);
	SendKey(KB_LeftGUI, KB_R);
	mDelaymS(500);
	SendString(Payload,sizeof(Payload)/sizeof(Payload[0]));
	mDelaymS(500);
}


void main(void)
{
	CfgFsys();			// CH552ʱ��ѡ������
	mDelaymS(100);	// �ϵ���ʱ,�ȴ��ڲ������ȶ�
	InitFlash();
	
	if (P1_1 == 0)   AttackEnabled = 0;	// ������1^1���ͣ��رչ���ģʽ
	mDelaymS(500);
	if(CheckFilesystem() == 0)	FormatFlash();	//���Flash��0x41000����FATĿ¼��Ϣ����ʽ��Flash
	InitUSB();
	while(!USBReady);	// �ȴ�USB��ʼ��
	
	mDelaymS(2000);
	if(AttackEnabled == 1)	ExecBadUSBPayload();
	while(1)
	{
		// ��ExecBadUSBΪ1ʱ��ִ��BadUSB����
		if(ExecBadUSB == 1 && AttackEnabled == 1)
		{
			ExecBadUSB=0;
			BadUSBDemo();
		}
		mDelaymS(100);
	}
}