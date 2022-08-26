/* 调试 */
/* 提供printf子程序和延时函数 */

#ifndef	__DEBUG_H__
#define __DEBUG_H__


// 定义函数返回值
#ifndef  SUCCESS
#define  SUCCESS    0
#endif

#ifndef  FAIL
#define  FAIL       0xFF
#endif

// 定义定时器起始
#ifndef  START
#define  START      1
#endif

#ifndef  STOP
#define  STOP       0
#endif

#define	 FREQ_SYS	    16000000	    // 系统主频(24MHz/16MHz/12MHz/6MHz/3MHz/750KHz/187.5KHz)
#define  OSC_EN_XT      0               // 外部晶振使能, 默认开启内部晶振

#ifndef  UART0_BUAD
#define  UART0_BUAD     1000000			// 串口0 波特率
#define  UART1_BUAD     38400			// 串口1 波特率
#define  UART0_BPS      (unsigned char)(256 - (((FREQ_SYS / UART0_BUAD / 16) * 10 + 5) / 10))
#define  UART1_BPS      (unsigned char)(256 - (((FREQ_SYS / UART1_BUAD / 16) * 10 + 5) / 10))
#endif

#ifndef  DE_PRINTF
#define  DE_PRINTF     1				// 开启printf输出
#endif

// 函数声明
void CfgFsys();                         // CH554 时钟选择和配置
void mDelayuS(UINT16 n);                // 延时以uS为单位
void mDelaymS(UINT16 n);                // 延时以mS为单位
void CH554UART0Alter();                 // CH554 串口0引脚映射到P1.2/P1.3
void mInitSTDIO();                      // T1作为波特率发生器
UINT8 CH554UART0RcvByte();              // CH554 UART0查询方式接收一个字节
void CH554UART0SendByte(UINT8 SendDat); // CH554 UART0发送一个字节

void UART1Setup();
UINT8 CH554UART1RcvByte();              // CH554 UART1接收一个字节(查询方式)
void CH554UART1SendByte(UINT8 SendDat); // CH554 UART1发送一个字节(查询方式)

void CH554WDTModeSelect(UINT8 mode);    // CH554 看门狗模式设置
void CH554WDTFeed(UINT8 tim);           // CH554 看门狗喂狗

void CH554SoftReset();                  // CH554 软复位
void CH554USBDevWakeup();               // CH554 做USB设备唤醒主机

#endif


