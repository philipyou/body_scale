

YC_CMD				EQU		0x01
YC_CMD_OGF			EQU		0xfc
YC_CMD_RESET		EQU		0x00
YC_CMD_BAUD			EQU		0x02
YC_CMD_ECHO			EQU		0x05

YC_SUCCESS 			EQU		0
YC_ERROR 			EQU		1

bBleWakeupPin		EQU		7
	ptwakeup		EQU 	PT4	
PTWAKEUPEN			EQU 	PT4EN	
PTWAKEUPPU			EQU	    PT4PU	


;Э��ջRAM��ַ:180H-1FFH
;Note: CS��ͷ�ı���ΪЭ��ջ�ڲ�����

RAM_1E0h				equ		1E0h

CS_Flag					EQU		RAM_1E0h
CS_BleSuccess			EQU		0
CS_RecFinishFlag        EQU     1
CS_C5_Flag              EQU     2
;------------------------------------------------;
CS_DelayR1				equ		RAM_1E0h+1h
CS_DelayR2				equ		RAM_1E0h+2h
CS_fsr0_save			EQU		RAM_1E0h+3H
CS_RxAddress			EQU		RAM_1E0h+4H
BleDataLength           EQU     RAM_1E0h+5H
CS_R0                   EQU     RAM_1E0h+6H
CS_PathBufLength		equ		RAM_1E0h+7h
CS_PathBufNum			equ		RAM_1E0h+8h			  ;pathBuf  ����
CS_fsr1                 equ     RAM_1E0h+9h
CS_fsr1_save            equ     RAM_1E0h+Ah

TDATA1                  equ     RAM_1E0h+BH
TDATA2                  equ     RAM_1E0h+CH
TDATA3                  equ     RAM_1E0h+DH
TDATA4                  equ     RAM_1E0h+EH
TDATA5                  equ     RAM_1E0h+FH
TDATA6                  equ     RAM_1E0h+10H

CS_INT_R0				equ		RAM_1E0h+11h

CS_FlashSave			equ		RAM_1E0h+12h
CS_BsrSave              equ     RAM_1E0h+13h
CS_R1                   equ     RAM_1E0h+14h 
Uart_Buff               equ     RAM_1E0h+15h 
;�궨��

CS_STARTADDRESS			EQU		1c1h   ;	RAM_190h+4
CS_ENDADDRESS			EQU		1c8h       ;RAM_190h+5

;�������������Э��ջ��ַ����ַ/2+1=CS_CODEADDRESS
CS_CODEADDRESSH	    	EQU		14h  ; 17h   ;16H
CS_CODEADDRESSL	    	EQU	   	dah  ; 7bh   ;48h  ;7bH


CS_CODEADDENDH	     	EQU		1fH
;CS_CODEADDENDL=fah/f9h,��bin�ļ����油�����㣬7����ΪF9h��6����ΪFah
CS_CODEADDENDL	    	EQU	    f9h  ;	f9H
	
;****************************************************
; ���ܣ�f1  = d1,˳��ִ��
;       f1 �� f2,PC+1
;****************************************************
CS_JNE_FD  Macro   f1,d1
		movfw   f1
		xorlw   d1
		btfsc	Status,Z
		endm

;****************************************************
; ���ܣ�f1  = d1,PC+1
;       f1 �� f2,˳��ִ��
;****************************************************
CS_JE_FD   Macro   f1,d1
		movfw   f1
		xorlw   d1
		btfss	Status,Z
		endm

;****************************************************
; ���ܣ�f1  = f2,PC+1
;       f1 �� f2,˳��ִ��
;CS_JE_FF 
;****************************************************
CS_JE_FF   Macro   f1,f2
		movfw   f1
		xorwf   f2,0
		btfss	Status,Z					
		endm