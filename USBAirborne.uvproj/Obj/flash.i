
#line 1 "lib\flash.c" /0
  
#line 1 "lib\CH554.H" /0







 
 
 
 
 
 
 
 
#line 16 "lib\CH554.H" /1
 
 
#line 18 "lib\CH554.H" /0
 
 
 
 
 
 
 
 
 
 
 
 
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
 
 
#line 1 "lib\flash.c" /0
 
  
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
 
 
 
 
#line 2 "lib\flash.c" /0
 
  
#line 1 "lib\USB.h" /0
 
 
 
 
 
 
 
 void InitUSB(void);
 void SendKey(UINT8 FunctionKey, UINT8 Key);
 void SendChar(UINT8 c);
 void SendString(UINT8 *s,UINT8 length);
 
 
#line 3 "lib\flash.c" /0
 
  
#line 1 "lib\keyValue.h" /0
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
#line 4 "lib\flash.c" /0
 
  
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
 
 
#line 5 "lib\flash.c" /0
 
  
#line 1 "lib\fat.h" /0
 
 
 
  
#line 1 "lib\CH554.H" /0







 
 
 
 
 
#line 13 "lib\CH554.H" /1
  
 
 
 
 
 
 
 
 
  
  
 
 
  
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  
 
 
 
 
 
 
 
#line 135 "lib\CH554.H" /0
 
 
#line 137 "lib\CH554.H" /1
  
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  
 
  
  
  
  
  
  
 
 
 
  
 
  
  
  
  
  
  
  
 
 
 
 
 
  
  
  
 
  
  
  
  
  
  
  
  














 
 
  
  
  
  
  
  
  
  
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  
  
  
  
  
  
  
  
 
  
  
  
  
  
  
  
  
 
 
 
 
 
 
 
 
 
  
  
 
  
  
  
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
 
  
  
  
  
  
  
  
  
 
  
  
  
  
  
  
 
 
 
 
 
 
 
 
 
 
 
 
  
  
  
  
  
 
 
 
 
 
  
  
  
  
  
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  
  
 
  
  
  
  
 
 
 
 
  
  
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  
  
  
  
  
  
  
 
 
 
 
 
 
 
 
 
 
 
 
 
  
  
  
  
  
  
  
  
 
 
  
 
  
  
  
  
  
  
  
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  
  
  
 
 
 
 
  
  
  
  
  
 
 
 
 
 
 
 
 
 
 
 
 
  
 
 
 
  
  
  
  
  
  
  
  
 
 
 
 
 
 
  
  
  
  
  
  
 
  
  
  
  
  
  
  
 
  
  
  
  
  
  
  
  
  
  
 
 
 
 
 
  
  
  
  
  
  
  
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  
  
  
  
  
  
  
  
  
 
 
 
 
 
  
  
 
  
  
  
  
  
  
  
  
 
 
 
 
 
 
  
  
  
  
  
  
  
  
 
  
  
  
  
  
  
 
 
 
 
 
 
 
 
  
  
  
  
 
  
  
 
 
 
 
 
 
 
  
  
  
 
 
 
 
 
 
 
 
  
  
 
 
 
 
 
 
 
  
  
  
  
  
  
 
 
 
 
 
 
 
  
  
  
 
  
  
  
  
 
  
  
  
 
  
  
  
  
 
  
 
  
  
  
 
 
 
 
  
  
 
 
 
 
 
  
 
  
 
  
 
  
 
  
 
  
 
 
 
  
 
 
  
 
 
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
 
 
  
  
  
  
  
  
 

















 
 
 
 
 
 
 
#line 903 "lib\CH554.H" /0
 
 
#line 905 "lib\CH554.H" /1
  
 
 
 
 
 
 
 
 
 
  
  
  
  
  
  
  
  
  
  
  
 
 
 
 
  
  
  
  
  
  
  
  
  
  
  
 
 
 
 
  
  
  
  
  
  
 
 
 
 
  
  
  
  
  
  
 
 
 
 
  
  
  
  
  
  
  
  
  
  
  
  
  
  
 
 
 
 
  
  
  
  
  
  
  
  
  
 
 
 
 
  
  
  
  
  
  
  
  
  
  
  
  
  
  
 
 
 
 
  
  
  
  
  
  
  
  
  
  
  
  
  
  
 
 
 
 
  
  
  
  
  
  
  
  
  
  
  
 
 
 
 
  
  
  
  
  
  
  
 
 
 
  
 
 
  
 
 
  
 
 
  
  
 
 
  
  
  
  
  
  
  
  
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
#line 4 "lib\fat.h" /0
#line 4 "lib\fat.h" /0
 
 
 UINT8C ADDR_0x00[512]={
 0xEB, 0x3C, 0x90, 0x4D, 0x53, 0x44, 0x4F, 0x53, 0x35, 0x2E, 0x30, 0x00, 0x10, 0x10, 0x01, 0x00,		 
 0x02, 0x00, 0x02, 0x00, 0x00, 0xF8, 0x20, 0x00, 0x3F, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00,		 
 0x00, 0xA0, 0x0F, 0x00, 0x80, 0x00, 0x29, 0xEB, 0xCA, 0xF7, 0x02, 0x4E, 0x4F, 0x20, 0x4E, 0x41,		 
 0x4D, 0x45, 0x20, 0x20, 0x20, 0x20, 0x46, 0x41, 0x54, 0x31, 0x36, 0x20, 0x20, 0x20, 0x33, 0xC9,		 
 0x8E, 0xD1, 0xBC, 0xF0, 0x7B, 0x8E, 0xD9, 0xB8, 0x00, 0x20, 0x8E, 0xC0, 0xFC, 0xBD, 0x00, 0x7C,		 
 0x38, 0x4E, 0x24, 0x7D, 0x24, 0x8B, 0xC1, 0x99, 0xE8, 0x3C, 0x01, 0x72, 0x1C, 0x83, 0xEB, 0x3A,		 
 0x66, 0xA1, 0x1C, 0x7C, 0x26, 0x66, 0x3B, 0x07, 0x26, 0x8A, 0x57, 0xFC, 0x75, 0x06, 0x80, 0xCA,		 
 0x02, 0x88, 0x56, 0x02, 0x80, 0xC3, 0x10, 0x73, 0xEB, 0x33, 0xC9, 0x8A, 0x46, 0x10, 0x98, 0xF7,		 
 0x66, 0x16, 0x03, 0x46, 0x1C, 0x13, 0x56, 0x1E, 0x03, 0x46, 0x0E, 0x13, 0xD1, 0x8B, 0x76, 0x11,		 
 0x60, 0x89, 0x46, 0xFC, 0x89, 0x56, 0xFE, 0xB8, 0x20, 0x00, 0xF7, 0xE6, 0x8B, 0x5E, 0x0B, 0x03,		 
 0xC3, 0x48, 0xF7, 0xF3, 0x01, 0x46, 0xFC, 0x11, 0x4E, 0xFE, 0x61, 0xBF, 0x00, 0x00, 0xE8, 0xE6,		 
 0x00, 0x72, 0x39, 0x26, 0x38, 0x2D, 0x74, 0x17, 0x60, 0xB1, 0x0B, 0xBE, 0xA1, 0x7D, 0xF3, 0xA6,		 
 0x61, 0x74, 0x32, 0x4E, 0x74, 0x09, 0x83, 0xC7, 0x20, 0x3B, 0xFB, 0x72, 0xE6, 0xEB, 0xDC, 0xA0,		 
 0xFB, 0x7D, 0xB4, 0x7D, 0x8B, 0xF0, 0xAC, 0x98, 0x40, 0x74, 0x0C, 0x48, 0x74, 0x13, 0xB4, 0x0E,		 
 0xBB, 0x07, 0x00, 0xCD, 0x10, 0xEB, 0xEF, 0xA0, 0xFD, 0x7D, 0xEB, 0xE6, 0xA0, 0xFC, 0x7D, 0xEB,		 
 0xE1, 0xCD, 0x16, 0xCD, 0x19, 0x26, 0x8B, 0x55, 0x1A, 0x52, 0xB0, 0x01, 0xBB, 0x00, 0x00, 0xE8,		 
 0x3B, 0x00, 0x72, 0xE8, 0x5B, 0x8A, 0x56, 0x24, 0xBE, 0x0B, 0x7C, 0x8B, 0xFC, 0xC7, 0x46, 0xF0,		 
 0x3D, 0x7D, 0xC7, 0x46, 0xF4, 0x29, 0x7D, 0x8C, 0xD9, 0x89, 0x4E, 0xF2, 0x89, 0x4E, 0xF6, 0xC6,		 
 0x06, 0x96, 0x7D, 0xCB, 0xEA, 0x03, 0x00, 0x00, 0x20, 0x0F, 0xB6, 0xC8, 0x66, 0x8B, 0x46, 0xF8,		 
 0x66, 0x03, 0x46, 0x1C, 0x66, 0x8B, 0xD0, 0x66, 0xC1, 0xEA, 0x10, 0xEB, 0x5E, 0x0F, 0xB6, 0xC8,		 
 0x4A, 0x4A, 0x8A, 0x46, 0x0D, 0x32, 0xE4, 0xF7, 0xE2, 0x03, 0x46, 0xFC, 0x13, 0x56, 0xFE, 0xEB,		 
 0x4A, 0x52, 0x50, 0x06, 0x53, 0x6A, 0x01, 0x6A, 0x10, 0x91, 0x8B, 0x46, 0x18, 0x96, 0x92, 0x33,		 
 0xD2, 0xF7, 0xF6, 0x91, 0xF7, 0xF6, 0x42, 0x87, 0xCA, 0xF7, 0x76, 0x1A, 0x8A, 0xF2, 0x8A, 0xE8,		 
 0xC0, 0xCC, 0x02, 0x0A, 0xCC, 0xB8, 0x01, 0x02, 0x80, 0x7E, 0x02, 0x0E, 0x75, 0x04, 0xB4, 0x42,		 
 0x8B, 0xF4, 0x8A, 0x56, 0x24, 0xCD, 0x13, 0x61, 0x61, 0x72, 0x0B, 0x40, 0x75, 0x01, 0x42, 0x03,		 
 0x5E, 0x0B, 0x49, 0x75, 0x06, 0xF8, 0xC3, 0x41, 0xBB, 0x00, 0x00, 0x60, 0x66, 0x6A, 0x00, 0xEB,		 
 0xB0, 0x42, 0x4F, 0x4F, 0x54, 0x4D, 0x47, 0x52, 0x20, 0x20, 0x20, 0x20, 0x0D, 0x0A, 0x52, 0x65,		 
 0x6D, 0x6F, 0x76, 0x65, 0x20, 0x64, 0x69, 0x73, 0x6B, 0x73, 0x20, 0x6F, 0x72, 0x20, 0x6F, 0x74,		 
 0x68, 0x65, 0x72, 0x20, 0x6D, 0x65, 0x64, 0x69, 0x61, 0x2E, 0xFF, 0x0D, 0x0A, 0x44, 0x69, 0x73,		 
 0x6B, 0x20, 0x65, 0x72, 0x72, 0x6F, 0x72, 0xFF, 0x0D, 0x0A, 0x50, 0x72, 0x65, 0x73, 0x73, 0x20,		 
 0x61, 0x6E, 0x79, 0x20, 0x6B, 0x65, 0x79, 0x20, 0x74, 0x6F, 0x20, 0x72, 0x65, 0x73, 0x74, 0x61,		 
 0x72, 0x74, 0x0D, 0x0A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAC, 0xCB, 0xD8, 0x55, 0xAA 		 
 };
 
 
 UINT8C ADDR_0x1000_0x21000[64] = {
 0xF8, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,		 
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,		 
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,		 
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 		 
 };
 
 
 UINT8C ADDR_0x41000[128] = {
 0x42, 0x20, 0x00, 0x49, 0x00, 0x6E, 0x00, 0x66, 0x00, 0x6F, 0x00, 0x0F, 0x00, 0x72, 0x72, 0x00,		 
 0x6D, 0x00, 0x61, 0x00, 0x74, 0x00, 0x69, 0x00, 0x6F, 0x00, 0x00, 0x00, 0x6E, 0x00, 0x00, 0x00,		 
 0x01, 0x53, 0x00, 0x79, 0x00, 0x73, 0x00, 0x74, 0x00, 0x65, 0x00, 0x0F, 0x00, 0x72, 0x6D, 0x00,		 
 0x20, 0x00, 0x56, 0x00, 0x6F, 0x00, 0x6C, 0x00, 0x75, 0x00, 0x00, 0x00, 0x6D, 0x00, 0x65, 0x00,		 
 0x53, 0x59, 0x53, 0x54, 0x45, 0x4D, 0x7E, 0x31, 0x20, 0x20, 0x20, 0x16, 0x00, 0x51, 0x0B, 0x97,		 
 0x93, 0x57, 0x93, 0x57, 0x00, 0x00, 0x0C, 0x97, 0x93, 0x57, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00,		 
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,		 
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 		 
 };
 
 
 UINT8C ADDR_0x45000[256] = {
 0x2E, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x10, 0x00, 0x51, 0x0B, 0x97,		 
 0x93, 0x57, 0x93, 0x57, 0x00, 0x00, 0x0C, 0x97, 0x93, 0x57, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00,		 
 0x2E, 0x2E, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x10, 0x00, 0x51, 0x0B, 0x97,		 
 0x93, 0x57, 0x93, 0x57, 0x00, 0x00, 0x0C, 0x97, 0x93, 0x57, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,		 
 0x42, 0x74, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x0F, 0x00, 0xCE, 0xFF, 0xFF,		 
 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF,		 
 0x01, 0x57, 0x00, 0x50, 0x00, 0x53, 0x00, 0x65, 0x00, 0x74, 0x00, 0x0F, 0x00, 0xCE, 0x74, 0x00,		 
 0x69, 0x00, 0x6E, 0x00, 0x67, 0x00, 0x73, 0x00, 0x2E, 0x00, 0x00, 0x00, 0x64, 0x00, 0x61, 0x00,		 
 0x57, 0x50, 0x53, 0x45, 0x54, 0x54, 0x7E, 0x31, 0x44, 0x41, 0x54, 0x20, 0x00, 0x7B, 0x0D, 0x97,		 
 0x93, 0x57, 0x93, 0x57, 0x00, 0x00, 0x0F, 0x97, 0x93, 0x57, 0x03, 0x00, 0x0C, 0x00, 0x00, 0x00,		 
 0x42, 0x47, 0x00, 0x75, 0x00, 0x69, 0x00, 0x64, 0x00, 0x00, 0x00, 0x0F, 0x00, 0xFF, 0xFF, 0xFF,		 
 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF,		 
 0x01, 0x49, 0x00, 0x6E, 0x00, 0x64, 0x00, 0x65, 0x00, 0x78, 0x00, 0x0F, 0x00, 0xFF, 0x65, 0x00,		 
 0x72, 0x00, 0x56, 0x00, 0x6F, 0x00, 0x6C, 0x00, 0x75, 0x00, 0x00, 0x00, 0x6D, 0x00, 0x65, 0x00,		 
 0x49, 0x4E, 0x44, 0x45, 0x58, 0x45, 0x7E, 0x31, 0x20, 0x20, 0x20, 0x20, 0x00, 0x74, 0x0E, 0x97,		 
 0x93, 0x57, 0x93, 0x57, 0x00, 0x00, 0x0F, 0x97, 0x93, 0x57, 0x04, 0x00, 0x4C, 0x00, 0x00, 0x00 		 
 };
 
 UINT8C ADDR_0x55000[64] = {
 0x0C, 0x00, 0x00, 0x00, 0x09, 0xD0, 0x54, 0x66, 0x82, 0x13, 0xAE, 0xDE, 0x00, 0x00, 0x00, 0x00,		 
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,		 
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,		 
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 		 
 };
 
 
 UINT8C ADDR_0x5C000[128] = {
 0x7B, 0x00, 0x34, 0x00, 0x37, 0x00, 0x39, 0x00, 0x41, 0x00, 0x46, 0x00, 0x42, 0x00, 0x41, 0x00,		 
 0x37, 0x00, 0x2D, 0x00, 0x38, 0x00, 0x30, 0x00, 0x31, 0x00, 0x46, 0x00, 0x2D, 0x00, 0x34, 0x00,		 
 0x37, 0x00, 0x31, 0x00, 0x44, 0x00, 0x2D, 0x00, 0x42, 0x00, 0x38, 0x00, 0x31, 0x00, 0x37, 0x00,		 
 0x2D, 0x00, 0x39, 0x00, 0x44, 0x00, 0x46, 0x00, 0x45, 0x00, 0x43, 0x00, 0x44, 0x00, 0x41, 0x00,		 
 0x34, 0x00, 0x34, 0x00, 0x37, 0x00, 0x36, 0x00, 0x37, 0x00, 0x7D, 0x00, 0x00, 0x00, 0x00, 0x00,		 
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,		 
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,		 
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 		 
 };
 
 UINT8C ADDR_0x65000[128] = {
 0x7B, 0x00, 0x33, 0x00, 0x44, 0x00, 0x39, 0x00, 0x32, 0x00, 0x42, 0x00, 0x41, 0x00, 0x38, 0x00,		 
 0x37, 0x00, 0x2D, 0x00, 0x37, 0x00, 0x32, 0x00, 0x32, 0x00, 0x45, 0x00, 0x2D, 0x00, 0x34, 0x00,		 
 0x32, 0x00, 0x31, 0x00, 0x42, 0x00, 0x2D, 0x00, 0x38, 0x00, 0x44, 0x00, 0x34, 0x00, 0x39, 0x00,		 
 0x2D, 0x00, 0x46, 0x00, 0x39, 0x00, 0x31, 0x00, 0x36, 0x00, 0x42, 0x00, 0x43, 0x00, 0x30, 0x00,		 
 0x31, 0x00, 0x42, 0x00, 0x38, 0x00, 0x43, 0x00, 0x42, 0x00, 0x7D, 0x00, 0x00, 0x00, 0x00, 0x00,		 
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,		 
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,		 
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 		 
 };
 
 UINT8C ZERO[128] = {
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,		 
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,		 
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,		 
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,		 
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,		 
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,		 
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,		 
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 		 
 };
 
 
 
#line 6 "lib\flash.c" /0
 
  
#line 1 "C:\Keil\C51\Inc\stdio.h" /0






 
 
 
 
 
 
 
 
 
 
#line 17 "C:\Keil\C51\Inc\stdio.h" /1
  
 
#line 19 "C:\Keil\C51\Inc\stdio.h" /0
 
 
 
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
 
 
 
#line 7 "lib\flash.c" /0
 
  
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
 
 
#line 8 "lib\flash.c" /0
 
 
 #pragma NOAREGS
 
 sbit SPI_CS = P1 ^ 4;	 
 
 
 
 
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
 UINT32 i;	
 for (i=0;i<0x80000;i+=(UINT32)(4096UL))
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
 
 




 
 void ExecBadUSBPayload() {
 
 
 UINT8 FATDirEntry[128];
 UINT32 ReadFlashAddr = 0x41000;   
 UINT16 foundINF = 0;
 
 UINT16 blockLen = 65535;		 
 UINT8 dat = 0;
 UINT16 foundBadUSB = 0;
 UINT16 MaxRound = 32;				 
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
 
 
 for (i = 0; i < 128; i += 32) {
 
 if (FATDirEntry[i] == 'A' && FATDirEntry[i + 1] == 'U' && FATDirEntry[i + 2] == 'T' &&
 FATDirEntry[i + 3] == 'O' && FATDirEntry[i + 4] == 'R' && FATDirEntry[i + 5] == 'U' &&
 FATDirEntry[i + 6] == 'N' && FATDirEntry[i + 8] == 'I' && FATDirEntry[i + 9] == 'N' &&
 FATDirEntry[i + 10] == 'F') 
 {
 
 ReadFlashAddr =(UINT32) ((FATDirEntry[i + 26] + (FATDirEntry[i + 27] << 8))+2)*64*1024;
 foundINF=1;
 
 
 break;
 }
 }
 ReadFlashAddr += 128;
 }
 
 
 MaxRound = 32;
 if(!foundINF) ReadFlashAddr=0x60000;
 while (MaxRound--) {
 SPI_CS = 0;
  { SPI0_DATA = 0x0b; while(S0_FREE == 0); };   
  { SPI0_DATA = ((ReadFlashAddr & 0xFFFFFF) >> 16); while(S0_FREE == 0); };   
  { SPI0_DATA = ((ReadFlashAddr & 0xFFFF) >> 8); while(S0_FREE == 0); };
  { SPI0_DATA = ReadFlashAddr & 0xFF; while(S0_FREE == 0); };
  { SPI0_DATA = 0xFF; while(S0_FREE == 0); };
 
 while (blockLen--) {
  { SPI0_DATA = 0xFF; while(S0_FREE == 0); dat = SPI0_DATA; };
 
 
 for (i = 0; i < patternCount; i++) {
 if (dat == patterns[i][patternIndex[i]]) {
 patternIndex[i]++;
 if (patterns[i][patternIndex[i]] == '\0') {
 patternFound[i] = 1;
 patternIndex[i] = 0;
 
 
 if (i == 0) {   
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
 
 
 patternIndexFlag = 0;
 for (i = 0; i < patternCount; i++) patternIndexFlag+=patternIndex[i];
 for (i = 0; i < patternCount; i++) patternIndexFlag+=patternFound[i];
 if (foundBadUSB && patternIndexFlag == 0 && dat != '\n' && dat != '\r' && dat != '\0') {
 SendChar(dat);
 }
 
 
 for (i = 0; i < patternCount; i++) {
 if (patternFound[i]) {
 switch (i) {
 case 1: SendChar('\n'); break;   
 case 2: SendKey(0x02, 0x00); break;   
 case 3: SendKey(0x00, 0x39); break;   
 case 4: SendKey(0x08, 0x00); break;   
 case 5: SendKey(0x08, 0x15); break;   
 case 6: SendKey(0x04, 0x3D); break;   
 case 7: SendKey(0x08, 0x07); break;   
 case 8: SendKey(0x08, 0x0F); break;   
 case 9: SendKey(0x08, 0x08); break;   
 case 10: SendKey(0x10, 0x04); SendKey(0x4C, 0x00); break;   
 case 11: mDelaymS(500); break;   
 case 12: WriteDataToFlash(0x00, ZERO, sizeof(ZERO));CH554SoftReset(); break;   
 }
 patternIndex[i] = 0;
 patternFound[i] = 0;   
 }
 }
 }
 
 ReadFlashAddr += 65535;
  { SPI0_DATA = 0xFF; while(S0_FREE == 0); };
 SPI_CS = 1;
 }
 return;
 }
 
 






 
 void InitFlash(void)
 {
 mInitSTDIO();
 InitHostSPI0();
 WriteFlashEnable();                              
 WriteFlashStatus(0x00);                          
 }
 






 
 void InitHostSPI0(void)
 {
 SPI0_SETUP &= ~(0x80 | 0x08);               
 SPI0_CTRL = 0x20 | 0x40;                        
 SPI0_CK_SE = 0x02;                                           
 P1_MOD_OC |= (0x20 | 0x40 | 0x80 | 0x10);
 P1_DIR_PU |= (0x20 | 0x40 | 0x80 | 0x10);
 }
 






 
 UINT8 ReadFlashStatus(void)
 {
 UINT8 FlashStatus;
 
 SPI_CS = 0;
  { SPI0_DATA = 0x05; while(S0_FREE == 0); };                                        
  { SPI0_DATA = 0xFF; while(S0_FREE == 0); FlashStatus = SPI0_DATA; };                                 
 SPI_CS = 1;
 
 return FlashStatus;
 }
 






 
 void WaitFlashBusy(void)
 {
 while((ReadFlashStatus()) & 0x01 == 0x01);           
 }
 






 
 void WriteFlashStatus(UINT8 status)
 {
 SPI_CS = 0;
  { SPI0_DATA = 0x01; while(S0_FREE == 0); };                                        
  { SPI0_DATA = status; while(S0_FREE == 0); };                                      
 SPI_CS = 1;
 }
 






 
 void WriteFlashForbidden(void)
 {
 SPI_CS = 0;
  { SPI0_DATA = 0x04; while(S0_FREE == 0); };
 SPI_CS = 1;
 }
 






 
 void WriteFlashEnable(void)
 {
 SPI_CS = 0;
  { SPI0_DATA = 0x06; while(S0_FREE == 0); };                                        
 SPI_CS = 1;
 }
 






 
 void CheckFlashWriteEnable(void)
 {
 UINT8 WRENStatus;
 
 WRENStatus = ReadFlashStatus();                      
 if((WRENStatus & 0x02) != 0x02)                      
 {
 WriteFlashEnable();                              
 }
 }
 






 
 void EraseFlash(UINT32 Dst_Addr)
 {
 CheckFlashWriteEnable();
 SPI_CS = 0;
  { SPI0_DATA = 0x20; while(S0_FREE == 0); };                                        
  { SPI0_DATA = ((Dst_Addr & 0xFFFFFF) >> 16); while(S0_FREE == 0); };               
  { SPI0_DATA = ((Dst_Addr & 0xFFFF) >> 8); while(S0_FREE == 0); };
  { SPI0_DATA = Dst_Addr & 0xFF; while(S0_FREE == 0); };
 SPI_CS = 1;
 WaitFlashBusy();
 }
 






 
 UINT8 ByteReadFlash(UINT32 StarAddr)
 {
 UINT8 dat = 0;
 
 SPI_CS = 0;
  { SPI0_DATA = 0x03; while(S0_FREE == 0); };                                        
  { SPI0_DATA = ((StarAddr & 0xFFFFFF) >> 16); while(S0_FREE == 0); };               
  { SPI0_DATA = ((StarAddr & 0xFFFF) >> 8); while(S0_FREE == 0); };
  { SPI0_DATA = StarAddr & 0xFF; while(S0_FREE == 0); };
  { SPI0_DATA = 0xFF; while(S0_FREE == 0); dat = SPI0_DATA; };
 SPI_CS = 1;
 
 return dat;                                          
 }
 







 
 void ByteWriteFlash(UINT32 StarAddr, UINT8 dat)
 {
 WriteFlashEnable();
 SPI_CS = 0;
  { SPI0_DATA = 0x02; while(S0_FREE == 0); };                                        
  { SPI0_DATA = ((StarAddr & 0xFFFFFF) >> 16); while(S0_FREE == 0); };               
  { SPI0_DATA = ((StarAddr & 0xFFFF) >> 8); while(S0_FREE == 0); };
  { SPI0_DATA = StarAddr & 0xFF; while(S0_FREE == 0); };
  { SPI0_DATA = dat; while(S0_FREE == 0); };                                         
 SPI_CS = 1;
 WaitFlashBusy();
 }
 








 
 void BulkReadFlash(UINT32 StarAddr, UINT16 Len, PUINT8 RcvBuffer)
 {
 UINT16 i;
 
 SPI_CS = 0;
  { SPI0_DATA = 0x0b; while(S0_FREE == 0); };                                        
  { SPI0_DATA = ((StarAddr & 0xFFFFFF) >> 16); while(S0_FREE == 0); };               
  { SPI0_DATA = ((StarAddr & 0xFFFF) >> 8); while(S0_FREE == 0); };
  { SPI0_DATA = StarAddr & 0xFF; while(S0_FREE == 0); };
  { SPI0_DATA = 0x00; while(S0_FREE == 0); };
 for(i = 0; i < Len; i++)
 {
  { SPI0_DATA = 0xFF; while(S0_FREE == 0); RcvBuffer[i] = SPI0_DATA; };                            
 }
 SPI_CS = 1;
 }
 








 
 void BulkWriteFlash(UINT32 StarAddr, UINT16 Len, PUINT8 SendBuffer)
 {
 UINT16 i;
 
 WaitFlashBusy();                                 
 WriteFlashStatus(0x00);                          
 WriteFlashEnable();                              
 
 SPI_CS = 0;
  { SPI0_DATA = 0x02; while(S0_FREE == 0); };                                    
  { SPI0_DATA = ((StarAddr & 0xFFFFFF) >> 16); while(S0_FREE == 0); };           
  { SPI0_DATA = ((StarAddr & 0xFFFF) >> 8); while(S0_FREE == 0); };
  { SPI0_DATA = StarAddr & 0xFF; while(S0_FREE == 0); };
 for(i = 0; i < Len; i++)
 {
  { SPI0_DATA = SendBuffer[i]; while(S0_FREE == 0); };
 }
 SPI_CS = 1;
 WriteFlashForbidden();                           
 WaitFlashBusy();                                 
 }
