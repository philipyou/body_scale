;============================================
; CST34XX Bluetooth Configuration Definition
;============================================

BT_PATCH_BIN_SIZE       EQU 	1F49H			; The filesize of bt_patch.bin

;-------------------------------------------
; PrimaryService about GAP: GAP Service
;-------------------------------------------
HANDLE_DeviceName       EQU 	0003H			; Device Name
HANDLE_Appearance       EQU 	0005H			; Appearance

;-------------------------------------------
; PrimaryService about OKOKService: Chipsea OKOK service
;-------------------------------------------
HANDLE_FFF1             EQU 	0008H			; 
HANDLE_FFF2             EQU 	000BH			; 

;-------------------------------------------
; PrimaryService about weChatService: wechat service
;-------------------------------------------
HANDLE_FEC7             EQU 	000EH			; 
HANDLE_FEC8             EQU 	0010H			; 
HANDLE_FEC9             EQU 	0013H			; 

;-------------------------------------------
; PrimaryService about JDService: JD service
;-------------------------------------------
HANDLE_D618D010         EQU 	0016H			; 
HANDLE_D618D020         EQU 	0018H			; 
HANDLE_D618D030         EQU 	001BH			; 

;============================================
; End of CST34XX Bluetooth Configuration Definition
;============================================

