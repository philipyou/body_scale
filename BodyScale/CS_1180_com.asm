
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
;初始化1180的IO
;===========================
F_InitCS1180_IO:
	bcf		EN_1180_SDO				;与1180_SDO连接的IO设置为输入
	bcf		EN_1180_DRDY		    ;DRDY设置为输入
	
	bsf		EN_1180_SCLK			;SCLK设置为输出
	bsf		EN_1180_SDI			    ;SDI设置为输出
	bsf		EN_1180_CS			    ;CS设置为输出
	
	bsf		PU_1180_SDO				;输入的IO口加上上拉
	bsf		PU_1180_DRDY
		
	return


;===========================
;发送时钟
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
;向SPI总线发送一个byte的数据
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
;在SPI总线上接收一个byte
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
;		1180初始化函数
;==================================================
;功能：初始化1180
;输入：
;缓存：
;输出：
;==================================================
; CONSTANT
DEF_COMM_RESET		 equ  feh
; INPUT	
; NONE
	
; OUTPUT
R_1180_RET1			 equ  R_SYS_C0			;初始化返回值1
R_1180_RET2			 equ  R_SYS_C1			;初始化返回值2
R_1180_RET3			 equ  R_SYS_C2			;初始化返回值3
R_1180_RET4			 equ  R_SYS_C3			;初始化返回值4
R_1180_RET5			 equ  R_SYS_C4			;初始化返回值5

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
	clrf	R_1180_temp		;延时513条指令周期
	decfsz	R_1180_temp,f
	goto	$-1	
	bcf		IO_1180_CS
	nop
	nop	
	
	movlw	50h
	movwf	R_1180_data
	call	F_SPI_send
	movlw	03h				;写4组寄存器
	movwf	R_1180_data
	call	F_SPI_send
	movlw	00h				;PGA=1
	movwf	R_1180_data
	call	F_SPI_send
	movlw	01h				;正常使用
	movwf	R_1180_data
	call	F_SPI_send
	movlw	05h				;7.5Hz 
	movwf	R_1180_data
	call	F_SPI_send
	movlw	00h				;默认值
	movwf	R_1180_data
	call	F_SPI_send
	
	bsf		IO_1180_CS	
	clrf	R_1180_temp		;延时513条指令周期
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
;		读取AD值
;==================================================
;功能：读取当前AD内码
;输入：
;缓存：
;输出：
;==================================================
; CONSTANT
DEF_COMM_RDATA		 equ  01h
; INPUT	
; NONE
	
; OUTPUT
R_1180_AD_L			 equ  R_SYS_C0					 ;读上来的AD值低8位
R_1180_AD_M			 equ  R_SYS_C1					 ;读上来的AD值中8位
R_1180_AD_H			 equ  R_SYS_C2					 ;读上来的AD值高8位

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
	

	clrf	R_1180_temp		;延时513条指令周期
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














