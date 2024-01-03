
#line 1 "lib\USB.c" /0




 
  
#line 1 "C:\Keil\C51\Inc\stdio.h" /0






 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 typedef unsigned int size_t;
 
 
 #pragma SAVE
 #pragma REGPARMS
 extern char _getkey (void);
 extern char getchar (void);
 extern char ungetchar (char);
 extern char putchar (char);
 extern int printf   (const char *, ...);
 extern int sprintf  (char *, const char *, ...);
 extern int vprintf  (const char *, char *);
 extern int vsprintf (char *, const char *, char *);
 extern char *gets (char *, int n);
 extern int scanf (const char *, ...);
 extern int sscanf (char *, const char *, ...);
 extern int puts (const char *);
 
 #pragma RESTORE
 
 
 
#line 6 "lib\USB.c" /0
 
  
#line 1 "lib\CH554.H" /0







 
 
 
 
 
 
 
 
#line 16 "lib\CH554.H" /1
 
 
#line 18 "lib\CH554.H" /0
 
 
 
 
 
 
 
 
#line 26 "lib\CH554.H" /1
  
 
#line 28 "lib\CH554.H" /0
 
 
 typedef bit                             BOOL;
 
 
 typedef unsigned char                   UINT8;
 
 
 typedef unsigned short                  UINT16;
 
 
 typedef unsigned long                   UINT32;
 
 
 typedef unsigned char  data             UINT8D;
 
 
 typedef unsigned short data             UINT16D;
 
 
 typedef unsigned long  data             UINT32D;
 
 
 typedef unsigned char  idata            UINT8I;
 
 
 typedef unsigned short idata            UINT16I;
 
 
 typedef unsigned long  idata            UINT32I;
 
 
 typedef unsigned char  xdata            UINT8X;
 
 
 typedef unsigned short xdata            UINT16X;
 
 
 typedef unsigned long  xdata            UINT32X;
 
 
 typedef unsigned char volatile          UINT8V;
 
 
 typedef unsigned char volatile data     UINT8DV;
 
 
 typedef unsigned char volatile xdata    UINT8XV;
 
 
 typedef unsigned char volatile pdata    UINT8PV;
 
 
 typedef const unsigned char code        UINT8C;
 
 
 typedef unsigned char                 *PUINT8;
 
 
 typedef unsigned short                *PUINT16;
 
 
 typedef unsigned long                 *PUINT32;
 
 
 typedef unsigned char  idata          *PUINT8I;
 
 
 typedef unsigned short idata          *PUINT16I;
 
 
 typedef unsigned long  idata          *PUINT32I;
 
 
 typedef unsigned char  xdata          *PUINT8X;
 
 
 typedef unsigned short xdata          *PUINT16X;
 
 
 typedef unsigned long  xdata          *PUINT32X;
 
 
 typedef unsigned char volatile        *PUINT8V;
 
 
 typedef unsigned char volatile data   *PUINT8DV;
 
 
 typedef unsigned char volatile xdata  *PUINT8XV;
 
 
 typedef unsigned char volatile pdata  *PUINT8PV;
 
 
 typedef const unsigned char code      *PUINT8C;
 
 
 
 
 
 
 
#line 131 "lib\CH554.H" /1
 
 
#line 133 "lib\CH554.H" /0
 
 
 
 
 
 
 
#line 140 "lib\CH554.H" /1
 
 
#line 142 "lib\CH554.H" /0
 
 
 
 
 
 sfr PSW             = 0xD0;          
 sbit CY            = PSW^7;         
 sbit AC            = PSW^6;         
 sbit F0            = PSW^5;         
 sbit RS1           = PSW^4;         
 sbit RS0           = PSW^3;         
 
 
 
 
 
 
 sbit OV            = PSW^2;         
 sbit F1            = PSW^1;         
 sbit P             = PSW^0;         
 sfr ACC             = 0xE0;          
 sfr B               = 0xF0;          
 sfr SP              = 0x81;          
 
 sfr DPL             = 0x82;          
 sfr DPH             = 0x83;          
 sfr SAFE_MOD        = 0xA1;          
 
 
 sfr GLOBAL_CFG      = 0xB1;          
 
 
 
 
 
 
 
 
 sfr PCON            = 0x87;          
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 sfr CLOCK_CFG       = 0xB9;          
 
 
 
 
 
 
 
 














 
 sfr WAKE_CTRL       = 0xA9;          
 
 
 
 
 
 
 
 
 sfr RESET_KEEP      = 0xFE;          
 sfr WDOG_COUNT      = 0xFF;          
 
 
 sfr IE              = 0xA8;          
 sbit EA            = IE^7;          
 sbit E_DIS         = IE^6;          
 sbit ET2           = IE^5;          
 sbit ES            = IE^4;          
 sbit ET1           = IE^3;          
 sbit EX1           = IE^2;          
 sbit ET0           = IE^1;          
 sbit EX0           = IE^0;          
 sfr IP              = 0xB8;          
 sbit PH_FLAG       = IP^7;          
 sbit PL_FLAG       = IP^6;          
 
 
 
 
 
 sbit PT2           = IP^5;          
 sbit PS            = IP^4;          
 sbit PT1           = IP^3;          
 sbit PX1           = IP^2;          
 sbit PT0           = IP^1;          
 sbit PX0           = IP^0;          
 sfr IE_EX           = 0xE8;          
 sbit IE_WDOG       = IE_EX^7;       
 sbit IE_GPIO       = IE_EX^6;       
 sbit IE_PWMX       = IE_EX^5;       
 sbit IE_UART1      = IE_EX^4;       
 sbit IE_ADC        = IE_EX^3;       
 sbit IE_USB        = IE_EX^2;       
 sbit IE_TKEY       = IE_EX^1;       
 sbit IE_SPI0       = IE_EX^0;       
 sfr IP_EX           = 0xE9;          
 
 
 
 
 
 
 
 
 sfr GPIO_IE         = 0xC7;          
 
 
 
 
 
 
 
 
 
 
 sfr16 ROM_ADDR      = 0x84;          
 sfr ROM_ADDR_L      = 0x84;          
 sfr ROM_ADDR_H      = 0x85;          
 sfr16 ROM_DATA      = 0x8E;          
 sfr ROM_DATA_L      = 0x8E;          
 sfr ROM_DATA_H      = 0x8F;          
 sfr ROM_CTRL        = 0x86;          
 
 
 
 
 
 
 
 
 sfr P1              = 0x90;          
 sbit P1_0          = P1^0;          
 sbit P1_1          = P1^1;          
 sbit P1_2          = P1^2;          
 sbit P1_3          = P1^3;          
 sbit P1_4          = P1^4;          
 sbit P1_5          = P1^5;          
 sbit P1_6          = P1^6;          
 sbit P1_7          = P1^7;          
 
 sbit SCK           = P1^7;          
 sbit TXD1          = P1^7;          
 sbit TIN5          = P1^7;          
 sbit MISO          = P1^6;          
 sbit RXD1          = P1^6;          
 sbit TIN4          = P1^6;          
 sbit MOSI          = P1^5;          
 sbit PWM1          = P1^5;          
 sbit TIN3          = P1^5;          
 sbit UCC2          = P1^5;          
 sbit AIN2          = P1^5;          
 sbit T2_           = P1^4;          
 sbit CAP1_         = P1^4;          
 sbit SCS           = P1^4;          
 sbit TIN2          = P1^4;          
 sbit UCC1          = P1^4;          
 sbit AIN1          = P1^4;          
 sbit TXD_          = P1^3;          
 sbit RXD_          = P1^2;          
 sbit T2EX          = P1^1;          
 sbit CAP2          = P1^1;          
 sbit TIN1          = P1^1;          
 sbit VBUS2         = P1^1;          
 sbit AIN0          = P1^1;          
 sbit T2            = P1^0;          
 sbit CAP1          = P1^0;          
 sbit TIN0          = P1^0;          
 sfr P1_MOD_OC       = 0x92;          
 sfr P1_DIR_PU       = 0x93;          
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 sfr P2              = 0xA0;          
 sfr P3              = 0xB0;          
 sbit P3_0          = P3^0;          
 sbit P3_1          = P3^1;          
 sbit P3_2          = P3^2;          
 sbit P3_3          = P3^3;          
 sbit P3_4          = P3^4;          
 sbit P3_5          = P3^5;          
 sbit P3_6          = P3^6;          
 sbit P3_7          = P3^7;          
 
 sbit UDM           = P3^7;          
 sbit UDP           = P3^6;          
 sbit T1            = P3^5;          
 sbit PWM2          = P3^4;          
 sbit RXD1_         = P3^4;          
 sbit T0            = P3^4;          
 sbit INT1          = P3^3;          
 sbit TXD1_         = P3^2;          
 sbit INT0          = P3^2;          
 sbit VBUS1         = P3^2;          
 sbit AIN3          = P3^2;          
 sbit PWM2_         = P3^1;          
 sbit TXD           = P3^1;          
 sbit PWM1_         = P3^0;          
 sbit RXD           = P3^0;          
 sfr P3_MOD_OC       = 0x96;          
 sfr P3_DIR_PU       = 0x97;          
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 sfr PIN_FUNC        = 0xC6;          
 
 
 
 
 
 
 
 
 sfr XBUS_AUX        = 0xA2;          
 
 
 
 
 
 
 
 
 sfr TCON            = 0x88;          
 sbit TF1           = TCON^7;        
 sbit TR1           = TCON^6;        
 sbit TF0           = TCON^5;        
 sbit TR0           = TCON^4;        
 sbit IE1           = TCON^3;        
 sbit IT1           = TCON^2;        
 sbit IE0           = TCON^1;        
 sbit IT0           = TCON^0;        
 sfr TMOD            = 0x89;          
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 sfr TL0             = 0x8A;          
 sfr TL1             = 0x8B;          
 sfr TH0             = 0x8C;          
 sfr TH1             = 0x8D;          
 
 
 sfr SCON            = 0x98;          
 sbit SM0           = SCON^7;        
 sbit SM1           = SCON^6;        
 
 
 
 
 
 sbit SM2           = SCON^5;        
 
 sbit REN           = SCON^4;        
 sbit TB8           = SCON^3;        
 sbit RB8           = SCON^2;        
 sbit TI            = SCON^1;        
 sbit RI            = SCON^0;        
 sfr SBUF            = 0x99;          
 
 
 sfr T2CON           = 0xC8;          
 sbit TF2           = T2CON^7;       
 sbit CAP1F         = T2CON^7;       
 sbit EXF2          = T2CON^6;       
 sbit RCLK          = T2CON^5;       
 sbit TCLK          = T2CON^4;       
 sbit EXEN2         = T2CON^3;       
 sbit TR2           = T2CON^2;       
 sbit C_T2          = T2CON^1;       
 sbit CP_RL2        = T2CON^0;       
 sfr T2MOD           = 0xC9;          
 
 
 
 
 
 
 
 
 
 
 
 
 
 sfr16 RCAP2         = 0xCA;          
 sfr RCAP2L          = 0xCA;          
 sfr RCAP2H          = 0xCB;          
 sfr16 T2COUNT       = 0xCC;          
 sfr TL2             = 0xCC;          
 sfr TH2             = 0xCD;          
 sfr16 T2CAP1        = 0xCE;          
 sfr T2CAP1L         = 0xCE;          
 sfr T2CAP1H         = 0xCF;          
 
 
 sfr PWM_DATA2       = 0x9B;          
 sfr PWM_DATA1       = 0x9C;          
 sfr PWM_CTRL        = 0x9D;          
 
 
 
 
 
 
 
 sfr PWM_CK_SE       = 0x9E;          
 
 
 sfr SPI0_STAT       = 0xF8;          
 sbit S0_FST_ACT    = SPI0_STAT^7;   
 sbit S0_IF_OV      = SPI0_STAT^6;   
 sbit S0_IF_FIRST   = SPI0_STAT^5;   
 sbit S0_IF_BYTE    = SPI0_STAT^4;   
 sbit S0_FREE       = SPI0_STAT^3;   
 sbit S0_T_FIFO     = SPI0_STAT^2;   
 sbit S0_R_FIFO     = SPI0_STAT^0;   
 sfr SPI0_DATA       = 0xF9;          
 sfr SPI0_CTRL       = 0xFA;          
 
 
 
 
 
 
 
 
 sfr SPI0_CK_SE      = 0xFB;          
 
 
 sfr SPI0_SETUP      = 0xFC;          
 
 
 
 
 
 
 
 
 
 sfr SCON1           = 0xC0;          
 sbit U1SM0         = SCON1^7;       
 sbit U1SMOD        = SCON1^5;       
 sbit U1REN         = SCON1^4;       
 sbit U1TB8         = SCON1^3;       
 sbit U1RB8         = SCON1^2;       
 sbit U1TI          = SCON1^1;       
 sbit U1RI          = SCON1^0;       
 sfr SBUF1           = 0xC1;          
 sfr SBAUD1          = 0xC2;          
 
 
 sfr ADC_CTRL        = 0x80;          
 sbit CMPO          = ADC_CTRL^7;    
 sbit CMP_IF        = ADC_CTRL^6;    
 sbit ADC_IF        = ADC_CTRL^5;    
 sbit ADC_START     = ADC_CTRL^4;    
 sbit CMP_CHAN      = ADC_CTRL^3;    
 sbit ADC_CHAN1     = ADC_CTRL^1;    
 sbit ADC_CHAN0     = ADC_CTRL^0;    
 
 
 
 
 
 sfr ADC_CFG         = 0x9A;          
 
 
 
 sfr ADC_DATA        = 0x9F;          
 
 
 sfr TKEY_CTRL       = 0xC3;          
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 sfr16 TKEY_DAT      = 0xC4;          
 sfr TKEY_DATL       = 0xC4;          
 sfr TKEY_DATH       = 0xC5;          
 
 
 
 sfr USB_C_CTRL      = 0x91;          
 
 
 
 
 
 
 
 
 
 
 
 
 
 sfr UDEV_CTRL       = 0xD1;          
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 sfr UEP1_CTRL       = 0xD2;          
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 sfr UEP1_T_LEN      = 0xD3;          
 sfr UEP2_CTRL       = 0xD4;          
 sfr UEP2_T_LEN      = 0xD5;          
 sfr UEP3_CTRL       = 0xD6;          
 sfr UEP3_T_LEN      = 0xD7;          
 sfr USB_INT_FG      = 0xD8;          
 sbit U_IS_NAK      = USB_INT_FG^7;  
 sbit U_TOG_OK      = USB_INT_FG^6;  
 sbit U_SIE_FREE    = USB_INT_FG^5;  
 sbit UIF_FIFO_OV   = USB_INT_FG^4;  
 sbit UIF_HST_SOF   = USB_INT_FG^3;  
 sbit UIF_SUSPEND   = USB_INT_FG^2;  
 sbit UIF_TRANSFER  = USB_INT_FG^1;  
 sbit UIF_DETECT    = USB_INT_FG^0;  
 sbit UIF_BUS_RST   = USB_INT_FG^0;  
 sfr USB_INT_ST      = 0xD9;          
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 sfr USB_MIS_ST      = 0xDA;          
 
 
 
 
 
 
 
 
 sfr USB_RX_LEN      = 0xDB;          
 sfr UEP0_CTRL       = 0xDC;          
 sfr UEP0_T_LEN      = 0xDD;          
 sfr UEP4_CTRL       = 0xDE;          
 sfr UEP4_T_LEN      = 0xDF;          
 sfr USB_INT_EN      = 0xE1;          
 
 
 
 
 
 
 
 
 sfr USB_CTRL        = 0xE2;          
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 sfr USB_DEV_AD      = 0xE3;          
 
 
 sfr16 UEP2_DMA      = 0xE4;          
 sfr UEP2_DMA_L      = 0xE4;          
 sfr UEP2_DMA_H      = 0xE5;          
 sfr16 UEP3_DMA      = 0xE6;          
 sfr UEP3_DMA_L      = 0xE6;          
 sfr UEP3_DMA_H      = 0xE7;          
 sfr UEP4_1_MOD      = 0xEA;          
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 sfr UEP2_3_MOD      = 0xEB;          
 
 
 
 
 
 
 sfr16 UEP0_DMA      = 0xEC;          
 sfr UEP0_DMA_L      = 0xEC;          
 sfr UEP0_DMA_H      = 0xED;          
 sfr16 UEP1_DMA      = 0xEE;          
 sfr UEP1_DMA_L      = 0xEE;          
 sfr UEP1_DMA_H      = 0xEF;          
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

















 
 
 
#line 899 "lib\CH554.H" /1
 
 
#line 901 "lib\CH554.H" /0
 
 
 
 
 
 
 
#line 908 "lib\CH554.H" /1
 
 
#line 910 "lib\CH554.H" /0
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 typedef struct _USB_SETUP_REQ {
 UINT8 bRequestType;
 UINT8 bRequest;
 UINT8 wValueL;
 UINT8 wValueH;
 UINT8 wIndexL;
 UINT8 wIndexH;
 UINT8 wLengthL;
 UINT8 wLengthH;
 } USB_SETUP_REQ, *PUSB_SETUP_REQ;
 
 typedef USB_SETUP_REQ xdata *PXUSB_SETUP_REQ;
 
 typedef struct _USB_DEVICE_DESCR {
 UINT8 bLength;
 UINT8 bDescriptorType;
 UINT8 bcdUSBL;
 UINT8 bcdUSBH;
 UINT8 bDeviceClass;
 UINT8 bDeviceSubClass;
 UINT8 bDeviceProtocol;
 UINT8 bMaxPacketSize0;
 UINT8 idVendorL;
 UINT8 idVendorH;
 UINT8 idProductL;
 UINT8 idProductH;
 UINT8 bcdDeviceL;
 UINT8 bcdDeviceH;
 UINT8 iManufacturer;
 UINT8 iProduct;
 UINT8 iSerialNumber;
 UINT8 bNumConfigurations;
 } USB_DEV_DESCR, *PUSB_DEV_DESCR;
 
 typedef USB_DEV_DESCR xdata *PXUSB_DEV_DESCR;
 
 typedef struct _USB_CONFIG_DESCR {
 UINT8 bLength;
 UINT8 bDescriptorType;
 UINT8 wTotalLengthL;
 UINT8 wTotalLengthH;
 UINT8 bNumInterfaces;
 UINT8 bConfigurationValue;
 UINT8 iConfiguration;
 UINT8 bmAttributes;
 UINT8 MaxPower;
 } USB_CFG_DESCR, *PUSB_CFG_DESCR;
 
 typedef USB_CFG_DESCR xdata *PXUSB_CFG_DESCR;
 
 typedef struct _USB_INTERF_DESCR {
 UINT8 bLength;
 UINT8 bDescriptorType;
 UINT8 bInterfaceNumber;
 UINT8 bAlternateSetting;
 UINT8 bNumEndpoints;
 UINT8 bInterfaceClass;
 UINT8 bInterfaceSubClass;
 UINT8 bInterfaceProtocol;
 UINT8 iInterface;
 } USB_ITF_DESCR, *PUSB_ITF_DESCR;
 
 typedef USB_ITF_DESCR xdata *PXUSB_ITF_DESCR;
 
 typedef struct _USB_ENDPOINT_DESCR {
 UINT8 bLength;
 UINT8 bDescriptorType;
 UINT8 bEndpointAddress;
 UINT8 bmAttributes;
 UINT8 wMaxPacketSizeL;
 UINT8 wMaxPacketSizeH;
 UINT8 bInterval;
 } USB_ENDP_DESCR, *PUSB_ENDP_DESCR;
 
 typedef USB_ENDP_DESCR xdata *PXUSB_ENDP_DESCR;
 
 typedef struct _USB_CONFIG_DESCR_LONG {
 USB_CFG_DESCR   cfg_descr;
 USB_ITF_DESCR   itf_descr;
 USB_ENDP_DESCR  endp_descr[1];
 } USB_CFG_DESCR_LONG, *PUSB_CFG_DESCR_LONG;
 
 typedef USB_CFG_DESCR_LONG xdata *PXUSB_CFG_DESCR_LONG;
 
 typedef struct _USB_HUB_DESCR {
 UINT8 bDescLength;
 UINT8 bDescriptorType;
 UINT8 bNbrPorts;
 UINT8 wHubCharacteristicsL;
 UINT8 wHubCharacteristicsH;
 UINT8 bPwrOn2PwrGood;
 UINT8 bHubContrCurrent;
 UINT8 DeviceRemovable;
 UINT8 PortPwrCtrlMask;
 } USB_HUB_DESCR, *PUSB_HUB_DESCR;
 
 typedef USB_HUB_DESCR xdata *PXUSB_HUB_DESCR;
 
 typedef struct _USB_HID_DESCR {
 UINT8 bLength;
 UINT8 bDescriptorType;
 UINT8 bcdHIDL;
 UINT8 bcdHIDH;
 UINT8 bCountryCode;
 UINT8 bNumDescriptors;
 UINT8 bDescriptorTypeX;
 UINT8 wDescriptorLengthL;
 UINT8 wDescriptorLengthH;
 } USB_HID_DESCR, *PUSB_HID_DESCR;
 
 typedef USB_HID_DESCR xdata *PXUSB_HID_DESCR;
 
 typedef struct _UDISK_BOC_CBW {          
 UINT8 mCBW_Sig0;
 UINT8 mCBW_Sig1;
 UINT8 mCBW_Sig2;
 UINT8 mCBW_Sig3;
 UINT8 mCBW_Tag0;
 UINT8 mCBW_Tag1;
 UINT8 mCBW_Tag2;
 UINT8 mCBW_Tag3;
 UINT8 mCBW_DataLen0;
 UINT8 mCBW_DataLen1;
 UINT8 mCBW_DataLen2;
 UINT8 mCBW_DataLen3;                 
 UINT8 mCBW_Flag;                     
 UINT8 mCBW_LUN;
 UINT8 mCBW_CB_Len;                   
 UINT8 mCBW_CB_Buf[16];               
 } UDISK_BOC_CBW, *PUDISK_BOC_CBW;
 
 typedef UDISK_BOC_CBW xdata *PXUDISK_BOC_CBW;
 
 typedef struct _UDISK_BOC_CSW {          
 UINT8 mCSW_Sig0;
 UINT8 mCSW_Sig1;
 UINT8 mCSW_Sig2;
 UINT8 mCSW_Sig3;
 UINT8 mCSW_Tag0;
 UINT8 mCSW_Tag1;
 UINT8 mCSW_Tag2;
 UINT8 mCSW_Tag3;
 UINT8 mCSW_Residue0;                 
 UINT8 mCSW_Residue1;
 UINT8 mCSW_Residue2;
 UINT8 mCSW_Residue3;                 
 UINT8 mCSW_Status;                   
 } UDISK_BOC_CSW, *PUDISK_BOC_CSW;
 
 typedef UDISK_BOC_CSW xdata *PXUDISK_BOC_CSW;
 
 
#line 1232 "lib\CH554.H" /1
 
 
#line 1234 "lib\CH554.H" /0
 
 
#line 7 "lib\USB.c" /0
 
  
#line 1 "lib\DEBUG.H" /0
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 void CfgFsys();                          
 void mDelayuS(UINT16 n);                 
 void mDelaymS(UINT16 n);                 
 void CH554UART0Alter();                  
 void mInitSTDIO();                       
 UINT8 CH554UART0RcvByte();               
 void CH554UART0SendByte(UINT8 SendDat);  
 
 void UART1Setup();
 UINT8 CH554UART1RcvByte();               
 void CH554UART1SendByte(UINT8 SendDat);  
 
 void CH554WDTModeSelect(UINT8 mode);     
 void CH554WDTFeed(UINT8 tim);            
 
 void CH554SoftReset();                   
 void CH554USBDevWakeup();                
 
 
 
 
#line 8 "lib\USB.c" /0
 
  
#line 1 "lib\USB.h" /0
 
 
 
 
 
 
 
 void InitUSB(void);
 void SendKey(UINT8 FunctionKey, UINT8 Key);
 void SendChar(UINT8 c);
 void SendString(UINT8 *s,UINT8 length);
 
 
#line 9 "lib\USB.c" /0
 
  
#line 1 "lib\flash.h" /0
 
 
 
 void ExecBadUSBPayload();
 BOOL CheckFilesystem();
 void FormatFlash();
 
 void InitFlash(void);
 void InitHostSPI0(void);
 UINT8 ReadFlashStatus(void);
 void WaitFlashBusy(void);
 void WriteFlashStatus(UINT8 status);
 void WriteFlashForbidden(void);
 void WriteFlashEnable(void);
 void CheckFlashWriteEnable(void);
 void EraseFlash(UINT32 Dst_Addr);
 UINT8 ByteReadFlash(UINT32 StarAddr);
 void ByteWriteFlash(UINT32 StarAddr, UINT8 dat);
 void BulkReadFlash(UINT32 StarAddr, UINT16 Len, PUINT8 RcvBuffer);
 void BulkWriteFlash(UINT32 StarAddr, UINT16 Len, PUINT8 SendBuffer);
 
 
#line 10 "lib\USB.c" /0
 
  
#line 1 "lib\keyValue.h" /0
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
#line 11 "lib\USB.c" /0
 
  
#line 1 "C:\Keil\C51\Inc\string.h" /0







 
 
 
 
 
 
#line 14 "C:\Keil\C51\Inc\string.h" /1
  
 
 
#line 17 "C:\Keil\C51\Inc\string.h" /0
 
 
#line 19 "C:\Keil\C51\Inc\string.h" /1
  
 
#line 21 "C:\Keil\C51\Inc\string.h" /0
 
 #pragma SAVE
 #pragma REGPARMS
 extern char  *strcat  (char *s1, const char *s2);
 extern char  *strncat (char *s1, const char *s2, size_t n);
 
 extern char   strcmp  (const char *s1, const char *s2);
 extern char   strncmp (const char *s1, const char *s2, size_t n);
 
 extern char  *strcpy  (char *s1, const char *s2);
 extern char  *strncpy (char *s1, const char *s2, size_t n);
 
 extern size_t strlen  (const char *);
 
 extern char  *strchr  (const char *s, char c);
 extern int    strpos  (const char *s, char c);
 extern char  *strrchr (const char *s, char c);
 extern int    strrpos (const char *s, char c);
 
 extern size_t strspn  (const char *s, const char *set);
 extern size_t strcspn (const char *s, const char *set);
 extern char  *strpbrk (const char *s, const char *set);
 extern char  *strrpbrk(const char *s, const char *set);
 extern char  *strstr  (const char *s, const char *sub);
 extern char  *strtok  (char *str, const char *set);
 
 extern char   memcmp  (const void *s1, const void *s2, size_t n);
 extern void  *memcpy  (void *s1, const void *s2, size_t n);
 extern void  *memchr  (const void *s, char val, size_t n);
 extern void  *memccpy (void *s1, const void *s2, char val, size_t n);
 extern void  *memmove (void *s1, const void *s2, size_t n);
 extern void  *memset  (void *s, char val, size_t n);
 #pragma RESTORE
 
 
#line 12 "lib\USB.c" /0
 
 #pragma NOAREGS
 
 
 
 
 
 
 UINT8X  Ep0Buffer[8+2]		_at_ 0x0000;    																	 
 UINT8X  Ep1Buffer[2 * 64]	_at_ 8 + 2 + 64;  			 
 UINT8X  Ep2Buffer[2 * 64]	_at_ 8 + 2 + 4 * 64;  	 
 
 UINT8   UsbConfig = 0;
 UINT8   IsHIDDataSent   = 0;
 
 extern UINT8 USBReady,ExecBadUSB,AttackEnabled;
 
 UINT8 HIDData[] = {0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00};  
 UINT8C HIDReportDescriptor[] =   
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
 
 UINT8C  MyDevDescr[] =       
 {
 0x12, 0x01, 0x10, 0x01,
 0x00, 0x00, 0x00, 8,
 0x44, 0x33, 0x33, 0x35,                                  
 0x00, 0x01, 0x01, 0x02,
 0x00, 0x01
 };
 
 UINT8C  MyCfgDescr[] =       
 {
 0x09, 0x02, 0x39, 0x00, 0x02, 0x01, 0x00, 0x80, 0x64,    
 
 0x09, 0x04, 0x00, 0x00, 0x02, 0x08, 0x06, 0x50, 0x00,    
 0x07, 0x05, 0x01, 0x02, 0x40, 0x00, 0x00,                
 0x07, 0x05, 0x81, 0x02, 0x40, 0x00, 0x00,                
 
 0x09, 0x04, 0x01, 0x00, 0x01, 0x03, 0x01, 0x01, 0x00, 												 
 0x09, 0x21, 0x11, 0x01, 0x00, 0x01, 0x22, sizeof(HIDReportDescriptor), 0x00, 	 
 0x07, 0x05, 0x82, 0x03, sizeof(HIDData), 0x00, 0x00 													 
 };
 
 UINT8C  MyLangDescr[] =      
 {
 4, 0x03, 0x09, 0x04
 };
 
 UINT8C  MyManuInfo[] =       
 {
 14, 0x03, 'U', 0, 'S', 0, 'B', 0, '2', 0, '.', 0, '0', 0
 };
 
 UINT8C  MyProdInfo[] =       
 {
 12, 0x03, 'U', 0, 'S', 0, 'B', 0, ' ', 0, ' ', 0
 };
 
 
 UINT8C  MAX_LUN[] = { 0 };
 
 UINT8C  DBINQUITY_CD_ROM[] =        
 {
 0x05,           
 0x00,           
 0x04,           
 0x02,
 
 0x1f,           
 0x00,           
 0x00,
 0x00,
 
 ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',				 
 
 'U', 'l', 't', 'r', 'a', ' ', 'U', 'S',				 
 'B', '2', '.', '0', ' ', ' ', ' ', ' ',
 
 '2', '.', '0', ' '														 
 };
 
 UINT8C  DBINQUITY_USB_Drive[] =        
 {
 0x00,           
 0x80,           
 0x04,           
 0x02,
 
 0x1f,           
 0x00,           
 0x00,
 0x00,
 
 ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',				 
 
 'U', 'l', 't', 'r', 'a', ' ', 'U', 'S',				 
 'B', '2', '.', '0', ' ', ' ', ' ', ' ',
 
 '2', '.', '0', ' '														 
 };
 
 
 
 
 
 UINT8C  DBCAPACITY[] =       
 {
 ((UINT32)(1023999UL) >> 24) & 0xFF, ((UINT32)(1023999UL) >> 16) & 0xFF, ((UINT32)(1023999UL) >> 8) & 0xFF, (UINT32)(1023999UL) & 0xFF, ((UINT32)(4096UL) >> 24) & 0xFF, ((UINT32)(4096UL) >> 16) & 0xFF, ((UINT32)(4096UL) >> 8) & 0xFF, (UINT32)(4096UL) & 0xFF
 };
 
 UINT8C  modesense3F[] =      
 {
 0x0b, 0x00, 0x00, 0x08, ((UINT32)(1024UL) >> 24) & 0xFF, ((UINT32)(1024UL) >> 16) & 0xFF, ((UINT32)(1024UL) >> 8) & 0xFF, (UINT32)(1024UL) & 0xFF, 00, 00, 02, 00
 };
 
 UINT8C  mode5sense3F[] =     
 {
 0x00, 0x06, 0x00, 0x00, 0x08, 0x00, 0x00, 0x08, ((UINT32)(1024UL) >> 24) & 0xFF, ((UINT32)(1024UL) >> 16) & 0xFF, ((UINT32)(1024UL) >> 8) & 0xFF, (UINT32)(1024UL) & 0xFF, 00, 00, 02, 00
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
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 union
 {
 unsigned long mDataLength;                       
 unsigned char mdataLen[4];
 } LEN;
 
 MASS_PARA idata MassPara;
 unsigned char mdCBWTag[4];                           
 bit CH375BULKUP;                                     
 bit CH375BULKDOWN;                                   
 bit CH375CSW;                                        
 unsigned char BcswStatus;                            
 unsigned char mSenseKey;
 unsigned char mASC;
 bit FSTALL;                                          
 bit lastFSTALL;
 bit pBuf_ReSelect = 0;
 UINT32 Locate_Addr;
 unsigned char *pBuf;
 






 
 void    InitUSB(void)                                     
 {
 USB_CTRL = 0x00;                                             
 USB_CTRL &= ~0x80;                                  
 USB_CTRL |=  0x20 | 0x08 | 0x01;      
 USB_DEV_AD = 0x00;                                           
 USB_CTRL &= ~0x40;
 UDEV_CTRL &= ~0x04;                                 
 UDEV_CTRL = 0x80;                                      
 UDEV_CTRL |= 0x01;                                    
 
 UEP1_DMA = Ep1Buffer;                                       	 
 UEP4_1_MOD = 0xC0;                                           
 UEP1_CTRL = 0x10 | 0x02 | 0x00;   
 UEP0_DMA = Ep0Buffer;                                       	 
 UEP0_CTRL = 0x00 | 0x02;                   
 UEP0_T_LEN = 0;
 UEP1_T_LEN = 0;                                              
 UEP2_DMA = Ep2Buffer;  																				 
 UEP2_3_MOD = 0x04;
 UEP2_CTRL = 0x10 | 0x02;
 UEP2_T_LEN = 0;
 
 
 USB_INT_EN |= 0x04;                                  
 USB_INT_EN |= 0x02;                                 
 USB_INT_EN |= 0x01;                                  
 USB_INT_FG |= 0x1F;                                          
 IE_USB = 1;                                                  
 EA = 1;                                                      
 }
 
 






 
 void HIDSendData()
 {
 memcpy( Ep2Buffer, HIDData, sizeof(HIDData));
 UEP2_T_LEN = sizeof(HIDData);
 UEP2_CTRL = UEP2_CTRL & ~ 0x03 | 0x00;
 }
 








 
 void SendKey(UINT8 FunctionKey, UINT8 Key)
 {
 IsHIDDataSent = 0;
 HIDData[0] = FunctionKey;
 HIDData[2] = Key;
 HIDSendData();
 while(!IsHIDDataSent);
 mDelaymS(5);
 
 IsHIDDataSent = 0;
 HIDData[0] = 0x00;
 HIDData[2] = 0x00;	
 HIDSendData();
 while(!IsHIDDataSent);
 mDelaymS(5);
 }
 






 
 void SendChar(UINT8 c)
 {
 if((c>='a')&&(c<='z')){
 SendKey(0x00,c-'a'+0x04);
 }else if((c>='A')&&(c<='Z')){
 SendKey(0x02,c-'A'+0x04);
 }else if((c>='1')&&(c<='9')){
 SendKey(0x00,c-'1'+0x1E);
 }else{
 switch(c){
 case '0':
 SendKey(0x00,0x27);
 break;
 case ' ':
 SendKey(0x00,0x2C);
 break;
 case '!':
 SendKey(0x02,0x1E);
 break;
 case '@':
 SendKey(0x02,0x1F);
 break;
 case '#':
 SendKey(0x02,0x20);
 break;
 case '$':
 SendKey(0x02,0x21);
 break;
 case '%':
 SendKey(0x02,0x22);
 break;
 case '^':
 SendKey(0x02,0x23);
 break;
 case '&':
 SendKey(0x02,0x24);
 break;
 case '*':
 SendKey(0x02,0x25);
 break;
 case '(':
 SendKey(0x02,0x26);
 break;
 case ')':
 SendKey(0x02,0x27);
 break;
 case '-':
 SendKey(0x00,0x2D);
 break;
 case '_':
 SendKey(0x02,0x2D);
 break;
 case '=':
 SendKey(0x00,0x2E);
 break;
 case '+':
 SendKey(0x02,0x2E);
 break;
 case '[':
 SendKey(0x00,0x2F);
 break;
 case '{':
 SendKey(0x02,0x2F);
 break;
 case ']':
 SendKey(0x00,0x30);
 break;
 case '}':
 SendKey(0x02,0x30);
 break;
 case '\\':
 SendKey(0x00,0x31);
 break;
 case '|':
 SendKey(0x02,0x31);
 break;
 case ';':
 SendKey(0x00,0x33);
 break;
 case ':':
 SendKey(0x02,0x33);
 break;
 case '`':
 SendKey(0x00,0x32);
 break;
 case '~':
 SendKey(0x02,0x32);
 break;
 case '\'':
 SendKey(0x00,0x34);
 break;
 case '"':
 SendKey(0x02,0x34);
 break;
 case ',':
 SendKey(0x00,0x36);
 break;
 case '<':
 SendKey(0x02,0x36);
 break;
 case '.':
 SendKey(0x00,0x37);
 break;
 case '>':
 SendKey(0x02,0x37);
 break;
 case '/':
 SendKey(0x00,0x38);
 break;
 case '?':
 SendKey(0x02,0x38);
 break;
 case '\t':
 SendKey(0x00,0x2B);
 break;
 case '\n':
 SendKey(0x00,0x28);
 break;
 }
 }
 }
 







 
 void SendString(UINT8 *s,UINT8 length){
 UINT8 i;
 for(i=0;i<length;i++){
 SendChar(s[i]);
 }
 }
 
 
 
 void  BulkThirteen(unsigned char Case)
 {
 switch(Case)
 {
 case CASEOK:
 case CASE1:                                          
 case CASE6:                                          
 BcswStatus = 0;
 break;
 case CASE12:                                         
 BcswStatus = 0;
 break;
 case CASE2:                                          
 case CASE3:                                          
 UEP1_CTRL = UEP1_CTRL | 0x03 ;
 FSTALL = 1;
 
 BcswStatus = 2;
 break;
 case CASE4:                                          
 case CASE5:                                          
 UEP1_CTRL = UEP1_CTRL | 0x03 ;
 FSTALL = 1;
 
 BcswStatus = 1;                                  
 break;
 case CASE7:                                          
 case CASE8:                                          
 UEP1_CTRL = UEP1_CTRL | 0x03 ;
 FSTALL = 1;
 
 BcswStatus = 2;
 break;
 case CASE9:                                          
 case CASE11:                                         
 UEP1_CTRL = UEP1_CTRL | 0x0C ;
 FSTALL = 1;
 
 BcswStatus = 1;                                  
 break;
 case CASE10:                                         
 case CASE13:                                         
 UEP1_CTRL = UEP1_CTRL | 0x03 ;
 FSTALL = 1;
 
 UEP1_CTRL = UEP1_CTRL | 0x0C ;
 
 BcswStatus = 2;
 break;
 case CASECBW:                                        
 UEP1_CTRL = UEP1_CTRL | 0x03 ;
 FSTALL = 1;
 UEP1_CTRL = UEP1_CTRL | 0x0C ;
 
 BcswStatus = 2;
 break;
 case CASECMDFAIL:
 UEP1_CTRL = UEP1_CTRL | 0x03 ;
 FSTALL = 1;
 
 BcswStatus = 1;
 break;
 default:
 break;
 }
 }
 
 
 void  UFI_readCapacity(void)
 {
 pBuf = DBCAPACITY;
 if(LEN.mDataLength > sizeof(DBCAPACITY))
 LEN.mDataLength = sizeof(DBCAPACITY);
 BcswStatus  = 0;
 mSenseKey   = 0;
 mASC        = 0;
 }
 
 
 void  UFI_inquiry(void)
 {
 if (AttackEnabled == 0)  
 {  
 pBuf = DBINQUITY_USB_Drive;
 if(LEN.mDataLength > sizeof(DBINQUITY_USB_Drive))
 LEN.mDataLength = sizeof(DBINQUITY_USB_Drive);
 BcswStatus  = 0;
 mSenseKey   = 0;
 mASC        = 0;
 }
 else  
 {
 pBuf = DBINQUITY_CD_ROM;
 if(LEN.mDataLength > sizeof(DBINQUITY_CD_ROM))
 LEN.mDataLength = sizeof(DBINQUITY_CD_ROM);
 BcswStatus  = 0;
 mSenseKey   = 0;
 mASC        = 0;
 } 
 }
 
 
 void  UFI_read10(void)
 {
 LEN.mDataLength = (((UINT32)MassPara.cbw.cbwcb.buf1[7] << 8) | (UINT32)MassPara.cbw.cbwcb.buf1[8]) * (UINT32)(4096UL);
 Locate_Addr = ((UINT32)MassPara.cbw.cbwcb.buf1[2] << 24) | ((UINT32)MassPara.cbw.cbwcb.buf1[3] << 16) | ((UINT32)MassPara.cbw.cbwcb.buf1[4] << 8) | (UINT32)MassPara.cbw.cbwcb.buf1[5];
 Locate_Addr = Locate_Addr * (UINT32)(4096UL);
 BcswStatus = 0;
 mSenseKey = 0;
 mASC = 0;
 pBuf_ReSelect = 1;
 }
 
 
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
 
 
 void  UFI_testUnit(void)
 {
 CH375BULKDOWN = 0;
 CH375BULKUP = 0;
 BcswStatus = 0;
 mSenseKey = 0;
 mASC = 0;
 }
 
 
 void  UFI_perOrMed(void)
 {
 BcswStatus = 0;
 mSenseKey = 0;
 mASC = 0;
 }
 
 
 void  UFI_write(void)
 {
 UINT8 i, num;
 
 LEN.mDataLength = (((UINT32)MassPara.cbw.cbwcb.buf1[7] << 8) | (UINT32)MassPara.cbw.cbwcb.buf1[8]) * (UINT32)(4096UL);       
 Locate_Addr = ((UINT32)MassPara.cbw.cbwcb.buf1[2] << 24) | ((UINT32)MassPara.cbw.cbwcb.buf1[3] << 16) | ((UINT32)MassPara.cbw.cbwcb.buf1[4] << 8) | (UINT32)MassPara.cbw.cbwcb.buf1[5];
 Locate_Addr = Locate_Addr * (UINT32)(4096UL);        
 if (Locate_Addr<(UINT32)(5000000UL))
 {
 num = MassPara.cbw.cbwcb.buf1[8];                
 for(i = 0; i < num; i++)
 EraseFlash(Locate_Addr + i * (UINT32)(4096UL));  
 }
 BcswStatus = 0;
 mSenseKey = 0;
 mASC = 0;
 }
 
 
 void  UFI_staStoUnit(void)
 {
 CH375BULKDOWN = 0;
 CH375BULKUP = 0;
 BcswStatus = 0;
 mSenseKey = 0;
 mASC = 0;
 }
 
 
 void  UFI_verify(void)
 {
 BcswStatus = 0;
 mSenseKey = 0;
 mASC = 0;
 
 
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
 
 
 void UFI_Hunding(void)
 {
 switch(MassPara.cbw.cbwcb.buf1[0])
 {
 case 0x12:
 UFI_inquiry();
 break;
 case 0x2A:
 UFI_write();
 break;
 case 0x00:
 UFI_testUnit();
 break;
 case 0x28:
 UFI_read10();
 break;
 case 0x03:
 UFI_requestSense();
 break;
 case 0x25:
 UFI_readCapacity();
 break;
 case 0x2F:
 UFI_verify();
 break;
 case 0x23:
 
 
 
 BcswStatus=0;
 mSenseKey=0;
 mASC=0;			
 break;
 
 
 
 case 0x1A:
 UFI_modeSense();
 break;
 case 0x5A:
 UFI_modeSense5();
 break;
 
 
 
 
 
 
 
 
 
 
 case 0x1B:
 UFI_staStoUnit();
 ExecBadUSB=1;
 break;
 case 0x1E:
 UFI_perOrMed();
 break;
 case 0x43:
 UFI_readTOC();
 break;
 case 0x4A:
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
 
 LEN.mdataLen[3] = *(unsigned char *)(&MassPara.cbw.dCBWDatL);    
 LEN.mdataLen[2] = *((unsigned char *)(&MassPara.cbw.dCBWDatL) + 1);
 LEN.mdataLen[1] = *((unsigned char *)(&MassPara.cbw.dCBWDatL) + 2);
 LEN.mdataLen[0] = *((unsigned char *)(&MassPara.cbw.dCBWDatL) + 3);
 mdCBWTag[0] = MassPara.buf[4];
 mdCBWTag[1] = MassPara.buf[5];
 mdCBWTag[2] = MassPara.buf[6];
 mdCBWTag[3] = MassPara.buf[7];             
 
 if(LEN.mDataLength)
 {
 CH375BULKDOWN   = (MassPara.cbw.bmCBWFlags & 0x80) ? 0 : 1;  
 CH375BULKUP     = (MassPara.cbw.bmCBWFlags & 0x80) ? 1 : 0;  
 }
 CH375CSW = 1;
 UFI_Hunding();   
 }
 else
 UEP1_CTRL = UEP1_CTRL | 0x03 ;
 }
 else
 UEP1_CTRL = UEP1_CTRL | 0x03 ;
 }
 else
 UEP1_CTRL = UEP1_CTRL | 0x03 ;
 }
 else
 UEP1_CTRL = UEP1_CTRL | 0x03 ;
 }
 
 
 void mCH375UpCsw()
 {
 unsigned char i;
 
 pBuf = &MassPara.buf[0];
 CH375CSW = 0;
 CH375BULKUP = 0;             
 MassPara.buf[0] = 0x55;      
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
 Ep1Buffer[64 + i] = *pBuf;
 pBuf++;
 }
 UEP1_T_LEN = 13;
 UEP1_CTRL = UEP1_CTRL & ~ 0x03 | 0x00;   
 }
 
 
 
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
 BulkReadFlash(Locate_Addr, len, &Ep1Buffer[64]);
 Locate_Addr += len;
 if(LEN.mDataLength == 0)
 pBuf_ReSelect = 0;
 }
 else
 {
 for(i = 0; i < len; i++)
 {
 Ep1Buffer[64 + i] = *pBuf;
 pBuf++;
 }
 }
 UEP1_T_LEN = len;
 UEP1_CTRL = UEP1_CTRL & ~ 0x03 | 0x00;   
 }
 
 UINT8I buffer[64];
 
 void mCH375BulkDownData()
 {
 unsigned char len, i;
 
 len = USB_RX_LEN;
 for(i = 0; i != len; i++)
 buffer[i] = Ep1Buffer[i];    
 BulkWriteFlash(Locate_Addr, len, &buffer[0]);
 Locate_Addr += len;
 LEN.mDataLength -= len;          
 if(LEN.mDataLength == 0)         
 {
 CH375BULKDOWN = 0;           
 mCH375UpCsw();               
 }
 }
 



 
 void    USB_DeviceInterrupt(void) interrupt 8 using 1                   
 {
 UINT8   len, i;
 static  UINT8   SetupReqCode, SetupLen;
 static  PUINT8  pDescr;
 
 if(UIF_TRANSFER)                                                             
 {
 switch(USB_INT_ST & (0x30 | 0x0F))                    
 {
 case 0x20 | 1:                                               
 {
 if(CH375BULKUP) mCH375bulkUpData();                              
 else if(CH375CSW) mCH375UpCsw();                                 
 else
 UEP1_CTRL = UEP1_CTRL & ~ 0x03 | 0x02;    
 break;
 }
 case 0x00 | 1:                                              
 {
 if(U_TOG_OK)                                                     
 {
 if(CH375BULKDOWN)  mCH375BulkDownData();                     
 else                                                         
 {
 len = USB_RX_LEN;
 if(!len)break;                                           
 for(i = 0; i != len; i++)
 MassPara.buf[i] = Ep1Buffer[i];                      
 mCH375BulkOnly();
 if(!CH375BULKDOWN)
 {
 if(CH375BULKUP) mCH375bulkUpData();                  
 else if(!FSTALL) mCH375UpCsw();                      
 
 }
 }
 }
 break;
 }
 case 0x20 | 2:                                               
 {
 UEP2_T_LEN = 0;
 UEP2_CTRL = UEP2_CTRL & ~ 0x03 | 0x02;   
 IsHIDDataSent = 1;   
 break;
 }
 case 0x30 | 0:                                            
 {
 len = USB_RX_LEN;
 if(len == sizeof(USB_SETUP_REQ))                                 
 {
 SetupLen = ((PUSB_SETUP_REQ)Ep0Buffer)->wLengthL;
 if(((PUSB_SETUP_REQ)Ep0Buffer)->wLengthH || SetupLen > 0x7F)
 {
 SetupLen = 0x7F;                                         
 }
 len = 0;                                                     
 if((((PUSB_SETUP_REQ)Ep0Buffer)->bRequestType & 0x60) != 0x00)   
 {
 SetupReqCode = ((PUSB_SETUP_REQ)Ep0Buffer)->bRequest;
 if(SetupReqCode == 0xFE)                                 
 {
 pDescr = (PUINT8)(&MAX_LUN[0]);
 len = 1;
 if(SetupLen > len)
 {
 SetupLen = len;                                  
 }
 len = SetupLen >= 8 ? 8 : SetupLen;   
 memcpy(Ep0Buffer, pDescr, len);                      
 SetupLen -= len;
 pDescr += len;
 USBReady = 1;
 }
 }
 else                                                         
 {
 SetupReqCode = ((PUSB_SETUP_REQ)Ep0Buffer)->bRequest;
 switch(SetupReqCode)                                     
 {
 case 0x06:
 switch(((PUSB_SETUP_REQ)Ep0Buffer)->wValueH)
 {
 case 0x01:                   
 pDescr = MyDevDescr;
 len = sizeof(MyDevDescr);
 break;
 case 0x02:                   
 pDescr = MyCfgDescr;
 len = sizeof(MyCfgDescr);
 break;
 case 0x03:                   
 switch(((PUSB_SETUP_REQ)Ep0Buffer)->wValueL)
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
 len = 0xFF;                      
 break;
 }
 break;
 case 0x22:
 switch(((PUSB_SETUP_REQ)Ep0Buffer)->wValueL)
 {
 case 0:
 pDescr = HIDReportDescriptor;		 
 len = sizeof(HIDReportDescriptor);
 break;
 default:
 len = 0xFF;                      
 break;
 }
 break;
 default:
 len = 0xFF;                              
 break;
 }
 if(SetupLen > len)
 {
 SetupLen = len;                              
 }
 len = SetupLen >= 8 ? 8 : SetupLen;  
 memcpy(Ep0Buffer, pDescr, len);                  
 SetupLen -= len;
 pDescr += len;
 break;
 case 0x05:
 SetupLen = ((PUSB_SETUP_REQ)Ep0Buffer)->wValueL;                 
 break;
 case 0x08:
 Ep0Buffer[0] = UsbConfig;
 if(SetupLen >= 1)
 {
 len = 1;
 }
 break;
 case 0x09:
 UsbConfig = ((PUSB_SETUP_REQ)Ep0Buffer)->wValueL;
 printf("Config\n");
 break;
 case 0x01:
 if((((PUSB_SETUP_REQ)Ep0Buffer)->bRequestType & 0x1F) == 0x02)   
 {
 switch(((PUSB_SETUP_REQ)Ep0Buffer)->wIndexL)
 {
 case 0x82:
 UEP2_CTRL = UEP2_CTRL & ~(0x40 | 0x03) | 0x02;
 break;
 case 0x02:
 UEP2_CTRL = UEP2_CTRL & ~(0x80 | 0x0C) | 0x00;
 break;
 case 0x81:
 UEP1_CTRL = UEP1_CTRL & ~(0x40 | 0x03) | 0x02;
 if(CH375CSW) mCH375UpCsw();
 lastFSTALL = FSTALL;
 FSTALL = 0;
 break;
 case 0x01:
 UEP1_CTRL = UEP1_CTRL & ~(0x80 | 0x0C) | 0x00;
 if(CH375CSW) mCH375UpCsw();
 lastFSTALL = FSTALL;
 FSTALL = 0;
 break;
 default:
 len = 0xFF;                          
 break;
 }
 }
 else
 {
 len = 0xFF;                                  
 }
 break;
 case 0x0A:
 Ep0Buffer[0] = 0x00;
 if(SetupLen >= 1)
 {
 len = 1;
 }
 break;
 case 0x00:
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
 len = 0xFF;                                      
 break;
 }
 }
 }
 else
 {
 len = 0xFF;                                                  
 }
 
 if(len == 0xFF)                                                  
 {
 SetupReqCode = 0xFF;
 UEP0_CTRL = 0x80 | 0x40 | 0x0C | 0x03; 
 }
 else if(len <= 8)                                  
 {
 UEP0_T_LEN = len;
 UEP0_CTRL = 0x80 | 0x40 | 0x00 | 0x00;     
 }
 else                                                             
 {
 UEP0_T_LEN = 0;                                              
 UEP0_CTRL = 0x80 | 0x40 | 0x00 | 0x00;     
 }
 break;
 }
 case 0x20 | 0:                                               
 {
 switch(SetupReqCode)
 {
 case 0x06:
 len = SetupLen >= 8 ? 8 : SetupLen;  
 memcpy(Ep0Buffer, pDescr, len);                          
 SetupLen -= len;
 pDescr += len;
 UEP0_T_LEN = len;
 UEP0_CTRL ^= 0x40;                                 
 break;
 case 0x05:
 USB_DEV_AD = USB_DEV_AD & 0x80 | SetupLen;
 UEP0_CTRL = 0x00 | 0x02;
 break;
 default:
 UEP0_T_LEN = 0;                                          
 UEP0_CTRL = 0x00 | 0x02;
 break;
 }
 break;
 }
 case 0x00 | 0:                                              
 {
 UEP0_T_LEN = 0;
 UEP0_CTRL ^= 0x80;
 break;
 }
 default:
 break;
 }
 UIF_TRANSFER = 0;                                                        
 }
 else if(UIF_BUS_RST)                                                         
 {
 printf("Reset\n");
 UEP0_CTRL = 0x00 | 0x02;
 UEP1_CTRL = 0x10 | 0x00 | 0x02;
 UEP2_CTRL = 0x10 | 0x00 | 0x02;
 USB_DEV_AD = 0x00;
 UIF_SUSPEND = 0;
 UIF_TRANSFER = 0;
 UIF_BUS_RST = 0;                                                         
 USBReady = 0;
 }
 else if(UIF_SUSPEND)                                                         
 {
 UIF_SUSPEND = 0;
 if(USB_MIS_ST & 0x04)                                            
 {
 printf("Suspend\n");                                                 
 }
 else                                                                     
 {
 printf("Awake\n");
 }
 }
 else
 {
 
 USB_INT_FG = 0xFF;                                                       
 }
 }
 
