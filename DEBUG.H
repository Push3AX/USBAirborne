/* ���� */
/* �ṩprintf�ӳ������ʱ���� */

#ifndef	__DEBUG_H__
#define __DEBUG_H__


// ���庯������ֵ
#ifndef  SUCCESS
#define  SUCCESS    0
#endif

#ifndef  FAIL
#define  FAIL       0xFF
#endif

// ���嶨ʱ����ʼ
#ifndef  START
#define  START      1
#endif

#ifndef  STOP
#define  STOP       0
#endif

#define	 FREQ_SYS	    16000000	    // ϵͳ��Ƶ(24MHz/16MHz/12MHz/6MHz/3MHz/750KHz/187.5KHz)
#define  OSC_EN_XT      0               // �ⲿ����ʹ��, Ĭ�Ͽ����ڲ�����

#ifndef  UART0_BUAD
#define  UART0_BUAD     1000000			// ����0 ������
#define  UART1_BUAD     38400			// ����1 ������
#define  UART0_BPS      (unsigned char)(256 - (((FREQ_SYS / UART0_BUAD / 16) * 10 + 5) / 10))
#define  UART1_BPS      (unsigned char)(256 - (((FREQ_SYS / UART1_BUAD / 16) * 10 + 5) / 10))
#endif

#ifndef  DE_PRINTF
#define  DE_PRINTF     1				// ����printf���
#endif

// ��������
void CfgFsys();                         // CH554 ʱ��ѡ�������
void mDelayuS(UINT16 n);                // ��ʱ��uSΪ��λ
void mDelaymS(UINT16 n);                // ��ʱ��mSΪ��λ
void CH554UART0Alter();                 // CH554 ����0����ӳ�䵽P1.2/P1.3
void mInitSTDIO();                      // T1��Ϊ�����ʷ�����
UINT8 CH554UART0RcvByte();              // CH554 UART0��ѯ��ʽ����һ���ֽ�
void CH554UART0SendByte(UINT8 SendDat); // CH554 UART0����һ���ֽ�

void UART1Setup();
UINT8 CH554UART1RcvByte();              // CH554 UART1����һ���ֽ�(��ѯ��ʽ)
void CH554UART1SendByte(UINT8 SendDat); // CH554 UART1����һ���ֽ�(��ѯ��ʽ)

void CH554WDTModeSelect(UINT8 mode);    // CH554 ���Ź�ģʽ����
void CH554WDTFeed(UINT8 tim);           // CH554 ���Ź�ι��

void CH554SoftReset();                  // CH554 ����λ
void CH554USBDevWakeup();               // CH554 ��USB�豸��������

#endif

