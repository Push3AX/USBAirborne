/********************************** (C) COPYRIGHT *******************************
* File Name          : Debug.C
* Author             : WCH
* Version            : V1.3
* Date               : 2018-11-07 14:49:47
* Description        : CH554 DEBUG Interface
                       CH554��Ƶ�޸ġ���ʱ��������
                       ����0�ʹ���1��ʼ��
                       ����0�ʹ���1���շ��Ӻ���
                       ���Ź���ʼ��
*******************************************************************************/
#include "CH554.H"
#include "Debug.H"


/*******************************************************************************
* Function Name  : CfgFsys( )
* Description    : CH554ʱ��ѡ������ú���,Ĭ��ʹ��Fsys 6MHz��
                   FREQ_SYS����ͨ��CLOCK_CFG���õõ�����ʽ���£�
                   Fsys = (Fosc * 4/(CLOCK_CFG & MASK_SYS_CK_SEL);
                   ����ʱ����Ҫ�Լ�����
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void CfgFsys()
{
#if OSC_EN_XT
    SAFE_MOD = 0x55;
    SAFE_MOD = 0xAA;
    CLOCK_CFG |=  bOSC_EN_XT;   // ʹ���ⲿ����
    CLOCK_CFG &= ~bOSC_EN_INT;  // �ر��ڲ�����
#endif
    SAFE_MOD = 0x55;
    SAFE_MOD = 0xAA;
#if FREQ_SYS == 24000000
    CLOCK_CFG = CLOCK_CFG & ~ MASK_SYS_CK_SEL | 0x06;  // 24MHz
#elif FREQ_SYS == 16000000
    CLOCK_CFG = CLOCK_CFG & ~ MASK_SYS_CK_SEL | 0x05;  // 16MHz
#elif FREQ_SYS == 12000000
    CLOCK_CFG = CLOCK_CFG & ~ MASK_SYS_CK_SEL | 0x04;  // 12MHz
#elif FREQ_SYS == 6000000
    CLOCK_CFG = CLOCK_CFG & ~ MASK_SYS_CK_SEL | 0x03;  // 6MHz
#elif FREQ_SYS == 3000000
    CLOCK_CFG = CLOCK_CFG & ~ MASK_SYS_CK_SEL | 0x02;  // 3MHz
#elif FREQ_SYS == 750000
    CLOCK_CFG = CLOCK_CFG & ~ MASK_SYS_CK_SEL | 0x01;  // 750KHz
#elif FREQ_SYS == 187500
    CLOCK_CFG = CLOCK_CFG & ~ MASK_SYS_CK_SEL | 0x00;  // 187.5KHz
#else
    #error "FREQ_SYS value is invalid!"
#endif
    SAFE_MOD = 0x00;
}


/*******************************************************************************
* Function Name  : mDelayus(UNIT16 n)
* Description    : us��ʱ����, ��λuS
* Input          : UNIT16 n
* Output         : None
* Return         : None
*******************************************************************************/
void mDelayuS(UINT16 n)
{
#ifdef	FREQ_SYS
#if		FREQ_SYS <= 6000000
    n >>= 2;
#endif
#if		FREQ_SYS <= 3000000
    n >>= 2;
#endif
#if		FREQ_SYS <= 750000
    n >>= 4;
#endif
#endif
    while(n)            // total = 12~13 Fsys cycles, 1uS @Fsys=12MHz
    {
        ++ SAFE_MOD;    // 2 Fsys cycles, for higher Fsys, add operation here
#ifdef	FREQ_SYS
#if		FREQ_SYS >= 14000000
        ++ SAFE_MOD;
#endif
#if		FREQ_SYS >= 16000000
        ++ SAFE_MOD;
#endif
#if		FREQ_SYS >= 18000000
        ++ SAFE_MOD;
#endif
#if		FREQ_SYS >= 20000000
        ++ SAFE_MOD;
#endif
#if		FREQ_SYS >= 22000000
        ++ SAFE_MOD;
#endif
#if		FREQ_SYS >= 24000000
        ++ SAFE_MOD;
#endif
#endif
        -- n;
    }
}


/*******************************************************************************
* Function Name  : mDelayms(UNIT16 n)
* Description    : ms��ʱ����, ��λmS
* Input          : UNIT16 n
* Output         : None
* Return         : None
*******************************************************************************/
void mDelaymS(UINT16 n)
{
    while(n)
    {
#ifdef	DELAY_MS_HW
        while((TKEY_CTRL & bTKC_IF) == 0);
        while(TKEY_CTRL & bTKC_IF);
#else
        mDelayuS(1000);
#endif
        -- n;
    }
}


/*******************************************************************************
* Function Name  : mInitSTDIO()
* Description    : CH554����0��ʼ��,Ĭ��ʹ��T1��UART0�Ĳ����ʷ�����,Ҳ����ʹ��T2
                   ��Ϊ�����ʷ�����
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void mInitSTDIO()
{
    SCON = 0x50;    // SERIAL MODE 1: SM0 = 0, SM1 = 1, SM2 = 0, REN = 1, TI = 0, RI = 0
    
    // ʹ��Timer1��Ϊ�����ʷ�����
    RCLK = 0;       // UART0����ʱ��
    TCLK = 0;       // UART0����ʱ��
    PCON |= SMOD;   // �����ʱ���
    TMOD = TMOD & ~ bT1_GATE & ~ bT1_CT & ~ MASK_T1_MOD | bT1_M1;   // 0x20, Timer1��Ϊ8λ�Զ����ض�ʱ��
    T2MOD = T2MOD | bTMR_CLK | bT1_CLK;                             // Timer1ʱ��ѡ��
    
    TL1 = UART0_BPS;
    TH1 = UART0_BPS;
    TR1 = 1;        // ������ʱ��1
    
    TI = 1;         // Ϊ�����printf����
}


/*******************************************************************************
* Function Name  : CH554UART0SendByte(UINT8 SendDat)
* Description    : CH554UART0����һ���ֽ�
* Input          : UINT8 SendDat��Ҫ���͵�����
* Output         : None
* Return         : None
*******************************************************************************/
void CH554UART0SendByte(UINT8 SendDat)
{
    while(TI == 0);     // �ȴ���һ�η������
    TI = 0;             // ���������ɱ�־λ
    SBUF = SendDat;     // ��ѯ����, �жϷ�ʽ�ɲ�������2�����, ������ǰ��TI = 0
}


/*******************************************************************************
* Function Name  : CH554UART0RcvByte()
* Description    : CH554UART0����һ���ֽ�
* Input          : None
* Output         : None
* Return         : SBUF
*******************************************************************************/
UINT8 CH554UART0RcvByte()
{
    while(RI == 0);     // ��ѯ����, �жϷ�ʽ�ɲ���
    RI = 0;
    return SBUF;
}


/*******************************************************************************
* Function Name  : CH554UART0Alter()
* Description    : CH554����0����ӳ��, ����ӳ�䵽P1.2��P1.3
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void CH554UART0Alter()
{
    PIN_FUNC |= bUART0_PIN_X;   // ����ӳ�䵽P1.2��P1.3
}


/*******************************************************************************
* Function Name  : UART1Setup()
* Description    : CH554����1��ʼ��
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void UART1Setup()
{
    U1SM0 = 0;          // UART1ѡ��8λ����λ
    U1SMOD = 1;         // ����ģʽ
    U1REN = 1;          // ʹ�ܽ���
    SBAUD1 = UART1_BPS; // ������
}


/*******************************************************************************
* Function Name  : CH554UART1RcvByte()
* Description    : CH554UART1����һ���ֽ�
* Input          : None
* Output         : None
* Return         : SBUF
*******************************************************************************/
UINT8 CH554UART1RcvByte()
{
    while(U1RI == 0);   // ��ѯ����, �жϷ�ʽ�ɲ���
    U1RI = 0;
    return SBUF1;
}


/*******************************************************************************
* Function Name  : CH554UART1SendByte(UINT8 SendDat)
* Description    : CH554UART1����һ���ֽ�
* Input          : UINT8 SendDat��Ҫ���͵�����
* Output         : None
* Return         : None
*******************************************************************************/
void CH554UART1SendByte(UINT8 SendDat)
{
    SBUF1 = SendDat;    // ��ѯ����, �жϷ�ʽ�ɲ�������2�����, ������ǰ��U1TI = 0
    while(U1TI == 0);
    U1TI = 0;
}


/*******************************************************************************
* Function Name  : CH554WDTModeSelect(UINT8 mode)
* Description    : CH554���Ź�ģʽѡ��
* Input          : UINT8 mode
                   0  timer
                   1  watchDog
* Output         : None
* Return         : None
*******************************************************************************/
void CH554WDTModeSelect(UINT8 mode)
{
    SAFE_MOD = 0x55;
    SAFE_MOD = 0xAA;                // ���밲ȫģʽ
    if(mode)
        GLOBAL_CFG |=  bWDOG_EN;    // �������Ź���λ
    else
        GLOBAL_CFG &= ~bWDOG_EN;    // �������Ź�, ����Ϊ��ʱ��
    SAFE_MOD = 0x00;                // �˳���ȫģʽ
    WDOG_COUNT = 0;                 // ���Ź�����ֵ
}


/*******************************************************************************
* Function Name  : CH554WDTFeed(UINT8 tim)
* Description    : CH554���Ź���ʱʱ������
* Input          : UINT8 tim ���Ź���λʱ������
                   00H(6MHz)=2.8s
                   80H(6MHz)=1.4s
                   T = (256 - tim) * 65536/Fsys uS
                   T = (256 - 0) * 65536/6 uS = 2796202uS = 2.8S
* Output         : None
* Return         : None
*******************************************************************************/
void CH554WDTFeed(UINT8 tim)
{
    WDOG_COUNT = tim;       // ���Ź���������ֵ
}


/*******************************************************************************
* Function Name  : CH554SoftReset()
* Description    : CH554����λ
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void CH554SoftReset()
{
    SAFE_MOD = 0x55;
    SAFE_MOD = 0xAA;
    GLOBAL_CFG |= bSW_RESET;
}


/*******************************************************************************
* Function Name  : CH554USBDevWakeup()
* Description    : CH554�豸ģʽ��������������K�ź�
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void CH554USBDevWakeup()
{
    UDEV_CTRL |=  bUD_LOW_SPEED;
    mDelaymS(2);
    UDEV_CTRL &= ~bUD_LOW_SPEED;
}
