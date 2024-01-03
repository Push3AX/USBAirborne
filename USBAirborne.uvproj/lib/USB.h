#ifndef __USB_H__
#define __USB_H__

#define DISK_SEC_LEN    (UINT32)(4096UL)                               	// 扇区大小 4KB
#define DISK_SEC_NUM    (UINT32)(1024UL)   															// 总扇区数
#define DISK_SEC_LAST   (UINT32)(1023999UL)                        			// 伪装成4G的容量

void InitUSB(void);
void SendKey(UINT8 FunctionKey, UINT8 Key);
void SendChar(UINT8 c);
void SendString(UINT8 *s,UINT8 length);

#endif