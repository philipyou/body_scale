;======================================
;	LED的buffer位定义（一般不修改）
;======================================
LED_BUF_BIT0	EQU		00000001B
LED_BUF_BIT1	EQU		00000010B
LED_BUF_BIT2	EQU		00000100B
LED_BUF_BIT3	EQU		00001000B
LED_BUF_BIT4	EQU		00010000B
LED_BUF_BIT5	EQU		00100000B
LED_BUF_BIT6	EQU		01000000B
LED_BUF_BIT7	EQU		10000000B

;======================================
;	数码管的A~G段和显示缓存的位对应关系
;======================================
;  __	   A		0			
; |  |	 F	 B 	  5	  1 	
;  __	   G		6		
; |  |	 E	 C	  4   2		
;  __  	   D		3		
;--------------------------------------
S_A		  EQU		LED_BUF_BIT0	
S_B		  EQU		LED_BUF_BIT1
S_C		  EQU		LED_BUF_BIT2	
S_D		  EQU		LED_BUF_BIT3
S_E		  EQU		LED_BUF_BIT4		
S_F		  EQU		LED_BUF_BIT5
S_G		  EQU		LED_BUF_BIT6	

;======================================
;	数字符号编码表
;======================================
;  __		A			
; |  | 	  F	  B 	
;  __		G		
; |  |    E   C		
;  __  		D
;--------------------------------------
Lcdch0    EQU   S_A+S_B+S_C+S_D+S_E+S_F
Lcdch1    EQU   S_B+S_C
Lcdch2    EQU   S_A+S_B+S_D+S_E+S_G
Lcdch3    EQU   S_A+S_B+S_C+S_D+S_G
Lcdch4    EQU   S_B+S_C+S_F+S_G
Lcdch5    EQU   S_A+S_C+S_D+S_F+S_G
Lcdch6    EQU   S_A+S_C+S_D+S_E+S_F+S_G
Lcdch7    EQU   S_A+S_B+S_C
Lcdch8    EQU   S_A+S_B+S_C+S_D+S_E+S_F+S_G
Lcdch9    EQU   S_A+S_B+S_C+S_D+S_F+S_G

LcdchA    EQU   S_A+S_B+S_C+S_E+S_F+S_G
Lcdchb    EQU   S_C+S_D+S_E+S_F+S_G
LcdchC    EQU   S_A+S_D+S_E+S_F
Lcdchd    EQU   S_B+S_C+S_D+S_E+S_G
LcdchE    EQU   S_A+S_D+S_E+S_F+S_G
LcdchF    EQU   S_A+S_E+S_F+S_G
                             
LcdchL    EQU   S_D+S_E+S_F
Lcdcho    EQU   S_C+S_D+S_E+S_G
LcdchP    EQU   S_A+S_B+S_E+S_F+S_G
Lcdchn    EQU   S_C+S_E+S_G
Lcdchr    EQU   S_E+S_G


;==================================================
;		LED初始化
;==================================================
;功能：完成LED的初始化配置
;输入：无
;缓存：无
;输出：无
;==================================================
F_LED_init:
	 ;-------------------------	
	 ;  初始化LED
     ;-------------------------					
		movlw	00111000b
		movwf	LEDCON1			;Bit7~5 LED_CURRENT[2:0] 		
								;LED驱动电流选择
								;000: 50mA
								;001: 40mA
								;010: 30mA
								;011: 25mA
								;100: 20mA
								;101: 15mA
								;110: 10mA
								;111: 10mA
								;Bit4~3 LED_DUTY[1:0] 
								;LED扫描占空比选择
								;11: 100%
								;10: 75%
								;01: 50%
								;00: 25%
								;Bit2~1 LEDCLKS[1:0] LED时钟选择
								;00: ICLK/32
								;01: ICLK/64
								;10: ICLK/128
								;11: ICLK/256
								;Bit0 LED_PMODE LED驱动电源控制
								;0： VDD作为驱动电源
								;1： CHPEN=1	3.8V pump
								;	 CHPEN=0    外部输入电源
		movlw	00000000b			
		movwf	LEDCON2			;Bit0 LEDEN		LED硬件驱动使能
								;0： LED驱动不使能
								;1:	 LED驱动使能
								
		movlw	00000000b
		movwf	CHPCON			;Bit4 CHPVS	 charge pump 输出电压选择
								;0： 输出电压3.8V
								;1： 输出电压3.6V
								;Bit2~1 CHPCLKS[1:0] charge pump 时钟选择
								;00: 500KHz
								;01: 250KHz
								;10: 125KHz
								;11: 62.5KHz
								;Bit0 CHPEN charge pump 使能位
								;0： charge pump 不使能
								;1： charge pump 使能
		movlw	26H
		movwf	7DH				;特殊寄存器7DH
								;26h: 使能大电流驱动 
								;00h: 关闭大电流驱动
		movlw	ffH		
		movwf	PT2EN			;0:输入		1:输出

	 ;-------------------------	
	 ;  初始化TIME1
     ;-------------------------
		movlw	240
		movwf	TM1IN			;Bit7~0 TM1IN[7:0]		
								;定时器1溢出值		
		movlw	10110000b
		movwf	TM1CON			;Bit7 T1EN 定时器1使能位
	    						;0:  禁止定时器1
	    						;1:  使能定时器1
	    						;Bit6~4 T1RATE[2:0] 时钟分频
	    						;000: CPUCLK
	    						;001: CPUCLK/2
								;010：CPUCLK/4
	    						;011: CPUCLK/8
	    						;100：CPUCLK/16
	    						;101: CPUCLK/32
	    						;110：CPUCLK/64
	    						;111: CPUCLK/128
								;Bit3 T1CKS 定时器1时钟源选择
								;0: CPUCLK的分频时钟
	    						;1: PT4.0作为时钟
	    						;Bit2 T1RSTB 定时器1复位
	    						;0: 使能定时器1复位
	    						;1: 禁止定时器1复位
	    						;Bit1~0 T1OUT PWM1OUT PT4.1口输出控制
								;PT4.1输出控制，仅当PT4.1配置为输出有效
	    						;00: IO输出
	    						;10: 蜂鸣器输出	
								;01: PWM1输出
	    						;11: PWM1取反输出
		bsf		INTE,TM1IE
		bsf		INTE,GIE
		return

		
;==================================================
;		查表函数
;==================================================
;功能：查表函数
;输入：无
;缓存：无
;输出：无
;==================================================
F_Dsp_Table:
		addpcw	       
		retlw	Lcdch0	;0	(work=0)
		retlw	Lcdch1	;1	(work=1)
		retlw	Lcdch2	;2	(work=2)
		retlw	Lcdch3	;3	(work=3)
		retlw	Lcdch4	;4	(work=4)
		retlw	Lcdch5	;5	(work=5)
		retlw	Lcdch6	;6	(work=6)
		retlw	Lcdch7	;7	(work=7)
		retlw	Lcdch8	;8	(work=8)
		retlw	Lcdch9	;9	(work=9)
		retlw	LcdchA	;A	(work=a)
		retlw	Lcdchb	;b	(work=b)
		retlw	LcdchC	;C	(work=c)
		retlw	Lcdchd	;d	(work=d)
		retlw	LcdchE	;E	(work=e)
		retlw	LcdchF	;F	(work=f)		
		

	
		
		
		
