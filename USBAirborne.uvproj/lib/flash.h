#ifndef	__FLASH_H__
#define __FLASH_H__

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

#endif
