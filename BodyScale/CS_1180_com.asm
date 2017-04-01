
;==================================================
;		MAP OF RAM
;==================================================
R_1180_SEG_S		 equ  R_RAM_ALC_1180_S
R_1180_temp			 equ  R_1180_SEG_S+0
R_1180_data			 equ  R_1180_SEG_S+1

DEFINE	IO_1180_SCLK	"PT4,2"  
DEFINE	EN_1180_SCLK	"PT4EN,2" 

DEFINE  IO_1180_SDI		"PT4,3"	
DEFINE  EN_1180_SDI		"PT4EN,3"

DEFINE	IO_1180_CS		"PT4,4"	
DEFINE	EN_1180_CS		"PT4EN,4"

DEFINE	IO_1180_SDO		"PT4,5"	
DEFINE	EN_1180_SDO		"PT4EN,5"
DEFINE	PU_1180_SDO		"PT4PU,5"

DEFINE	IO_1180_DRDY	"PT4,6"			
DEFINE	EN_1180_DRDY	"PT4EN,6"		
DEFINE	PU_1180_DRDY	"PT4PU,6"

;===========================
;��ʼ��1180��IO
;===========================
F_InitCS1180_IO:
	bcf		EN_1180_SDO				;��1180_SDO���ӵ�IO����Ϊ����
	bcf		EN_1180_DRDY		    ;DRDY����Ϊ����
	
	bsf		EN_1180_SCLK			;SCLK����Ϊ���
	bsf		EN_1180_SDI			    ;SDI����Ϊ���
	bsf		EN_1180_CS			    ;CS����Ϊ���
	
	bsf		PU_1180_SDO				;�����IO�ڼ�������
	bsf		PU_1180_DRDY
		
	return


;===========================
;����ʱ��
;===========================
F_SPI_clock:
	bsf		IO_1180_SCLK
	nop
	nop
	bcf		IO_1180_SCLK
	nop
	nop
	return

;============================
;��SPI���߷���һ��byte������
;============================	
F_SPI_send:
	movlw	8
	movwf	R_1180_temp
F_SPI_send_L1:
	btfss	R_1180_data,7
	bcf		IO_1180_SDI
	btfsc	R_1180_data,7
	bsf		IO_1180_SDI
	
	call	F_SPI_clock
	
	rlf		R_1180_data,f
	
	decfsz	R_1180_temp,f
	goto	F_SPI_send_L1
	return

;=============================
;��SPI�����Ͻ���һ��byte
;=============================
	
F_SPI_receive:
	movlw	8
	movwf	R_1180_temp
F_SPI_receive_L1:
	rlf		R_1180_data,f
	
	btfss	IO_1180_SDO
	bcf		R_1180_data,0
	btfsc	IO_1180_SDO
	bsf		R_1180_data,0
	
	
	call	F_SPI_clock	
	
	decfsz	R_1180_temp,f
	goto	F_SPI_receive_L1
	return
	
	
;==================================================
;		1180��ʼ������
;==================================================
;���ܣ���ʼ��1180
;���룺
;���棺
;�����
;==================================================
; CONSTANT
DEF_COMM_RESET		 equ  feh
; INPUT	
; NONE
	
; OUTPUT
R_1180_RET1			 equ  R_SYS_C0			;��ʼ������ֵ1
R_1180_RET2			 equ  R_SYS_C1			;��ʼ������ֵ2
R_1180_RET3			 equ  R_SYS_C2			;��ʼ������ֵ3
R_1180_RET4			 equ  R_SYS_C3			;��ʼ������ֵ4
R_1180_RET5			 equ  R_SYS_C4			;��ʼ������ֵ5

F_InitCS1180:
	bsf		IO_1180_CS
	bcf		IO_1180_SCLK
	bsf		IO_1180_SDI
	bsf		IO_1180_SDO
	bcf		IO_1180_CS
	nop
	nop
	
	movlw	DEF_COMM_RESET
	movwf	R_1180_data
	call	F_SPI_send
	
	
	bsf		IO_1180_CS	
	clrf	R_1180_temp		;��ʱ513��ָ������
	decfsz	R_1180_temp,f
	goto	$-1	
	bcf		IO_1180_CS
	nop
	nop	
	
	movlw	50h
	movwf	R_1180_data
	call	F_SPI_send
	movlw	03h				;д4��Ĵ���
	movwf	R_1180_data
	call	F_SPI_send
	movlw	00h				;PGA=1
	movwf	R_1180_data
	call	F_SPI_send
	movlw	01h				;����ʹ��
	movwf	R_1180_data
	call	F_SPI_send
	movlw	05h				;7.5Hz 
	movwf	R_1180_data
	call	F_SPI_send
	movlw	00h				;Ĭ��ֵ
	movwf	R_1180_data
	call	F_SPI_send
	
	bsf		IO_1180_CS	
	clrf	R_1180_temp		;��ʱ513��ָ������
	decfsz	R_1180_temp,f
	goto	$-1	
	bcf		IO_1180_CS
	nop
	nop
	
	
InitCS1180_L1:
	btfsc	IO_1180_DRDY
	goto	InitCS1180_L1	
InitCS1180_L2:	
	btfss	IO_1180_DRDY
	goto	InitCS1180_L2
InitCS1180_L3:
	bcf		IO_1180_CS
		
	movlw	10h
	movwf	R_1180_data
	call	F_SPI_send
	nop
	nop
	
	movlw	4
	movwf	R_1180_data
	call	F_SPI_send
	nop
	nop

	
	call	F_SPI_receive
	movfw	R_1180_data
	movwf	R_1180_RET1
	
	call	F_SPI_receive
	movfw	R_1180_data
	movwf	R_1180_RET2
	
	call	F_SPI_receive
	movfw	R_1180_data
	movwf	R_1180_RET3
	
	call	F_SPI_receive
	movfw	R_1180_data
	movwf	R_1180_RET4
	
	call	F_SPI_receive
	movfw	R_1180_data
	movwf	R_1180_RET5
	
	bsf		IO_1180_CS	
	
	return

;==================================================
;		��ȡADֵ
;==================================================
;���ܣ���ȡ��ǰAD����
;���룺
;���棺
;�����
;==================================================
; CONSTANT
DEF_COMM_RDATA		 equ  01h
; INPUT	
; NONE
	
; OUTPUT
R_1180_AD_L			 equ  R_SYS_C0					 ;��������ADֵ��8λ
R_1180_AD_M			 equ  R_SYS_C1					 ;��������ADֵ��8λ
R_1180_AD_H			 equ  R_SYS_C2					 ;��������ADֵ��8λ

F_ReadAdData:
	btfsc	IO_1180_DRDY
	goto	F_ReadAdData	
F_ReadAdData_L1:	
	btfss	IO_1180_DRDY
	goto	F_ReadAdData_L1
	
	bcf		IO_1180_CS
	nop
	nop
	movlw	DEF_COMM_RDATA
	movwf	R_1180_data
	call	F_SPI_send
	

	clrf	R_1180_temp		;��ʱ513��ָ������
	decfsz	R_1180_temp,f
	goto	$-1	

	
	call	F_SPI_receive
	movfw	R_1180_data
	movwf	R_1180_AD_L
	
	call	F_SPI_receive
	movfw	R_1180_data
	movwf	R_1180_AD_M
	
	call	F_SPI_receive
	movfw	R_1180_data
	movwf	R_1180_AD_H	
	
	bcf		IO_1180_SCLK
	
	bsf		IO_1180_CS
	return














