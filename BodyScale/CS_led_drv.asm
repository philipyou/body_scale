;==================================================
;		MAP OF RAM
;==================================================
RAM_LED_SEG1		equ  R_RAM_ALC_LD_S
R_LED_COUNT			equ  RAM_LED_SEG1+0			;用于记录扫描到第几个循环从PT2.0~PT2.7有8个循环
R_LED_LIGHT			equ  RAM_LED_SEG1+1			;标志每次循环要开启的IO口
R_LED_DUTY			equ  RAM_LED_SEG1+2			;统计每次循环要点亮LED的个数


;==================================================
;		需要放到定时中断里定时扫描
;==================================================

L_LED_DRIVER_START: 		
		incf	R_LED_COUNT,f		
		movlw	8
		subwf	R_LED_COUNT,w
		btfsc	status,c
		clrf	R_LED_COUNT
		
		movlw	ffh
		movwf	pt2
		
		movwf	PT2CON			;PT2CON[X]
								;0:	 LEDEN=0 电流驱动能力3ma
								;	 LEDEN=1 电流由LED_Current控制
								;1:	         电流由LED_Current控制
			
		movwf	7FH				;Bit7~0 LEDZCON[7:0] PT2高阻态输出控制
								;0: 输出高或低 1：输出高阻态
		movwf	R_LED_LIGHT		
		clrf	R_LED_DUTY
		
		movfw	R_LED_COUNT
		addpcw	
		goto	INTERRUPT_LED_P20
		goto	INTERRUPT_LED_P21
		goto	INTERRUPT_LED_P22
		goto	INTERRUPT_LED_P23
		goto	INTERRUPT_LED_P24
		goto	INTERRUPT_LED_P25
		goto	INTERRUPT_LED_P26
		goto	INTERRUPT_LED_P27
;--------------------------------		
INTERRUPT_LED_P20:		
		;PT2.0
		btfsc	LED1,0
		incf	R_LED_DUTY,f
		btfsc	LED2,1
		incf	R_LED_DUTY,f
		btfsc	LED1,6
		incf	R_LED_DUTY,f
		btfsc	LED2,2
		incf	R_LED_DUTY,f
		btfsc	LED4,6
		incf	R_LED_DUTY,f
		btfsc	LED2,3
		incf	R_LED_DUTY,f
		btfsc   LED7,0
		incf    R_LED_DUTY,F
		
		btfsc	LED1,0
		bcf		R_LED_LIGHT,1
		btfsc	LED2,1
		bcf		R_LED_LIGHT,2
		btfsc	LED1,6
		bcf		R_LED_LIGHT,3
		btfsc	LED2,2
		bcf		R_LED_LIGHT,4
		btfsc	LED4,6
		bcf		R_LED_LIGHT,5
		btfsc	LED2,3
		bcf		R_LED_LIGHT,6
		btfsc   LED7,0
		bcf		R_LED_LIGHT,7
				
		movlw	11111111b
		xorwf	R_LED_LIGHT,w
		btfsc	status,z
		goto	INTERRUPT_LED_END
		
		bcf		R_LED_LIGHT,0
		movfw	R_LED_LIGHT
		movwf	PT2CON
		movwf	7FH						
		movlw	11111110b
		movwf	PT2		
		goto	INTERRUPT_LED_END
;--------------------------------		
INTERRUPT_LED_P21:		
		;PT2.1
		btfsc	LED2,0
		incf	R_LED_DUTY,f
		btfsc	LED5,0
		incf	R_LED_DUTY,f
		btfsc	LED1,1
		incf	R_LED_DUTY,f
		btfsc	LED3,7
		incf	R_LED_DUTY,f
		btfsc	LED3,1
		incf	R_LED_DUTY,f
		btfsc	LED7,7
		incf	R_LED_DUTY,f
		btfsc	LED7,1
		incf	R_LED_DUTY,f
		
		btfsc	LED2,0
		bcf		R_LED_LIGHT,0
		btfsc	LED5,0
		bcf		R_LED_LIGHT,2
		btfsc	LED1,1
		bcf		R_LED_LIGHT,3
		btfsc	LED3,7
		bcf		R_LED_LIGHT,4
		btfsc	LED3,1
		bcf		R_LED_LIGHT,5
		btfsc	LED7,7
		bcf		R_LED_LIGHT,6
		btfsc	LED7,1
		bcf		R_LED_LIGHT,7
		
		movlw	11111111b
		xorwf	R_LED_LIGHT,w
		btfsc	status,z
		goto	INTERRUPT_LED_END
		
		bcf		R_LED_LIGHT,1
		movfw	R_LED_LIGHT
		movwf	PT2CON
		movwf	7FH						
		movlw	11111101b
		movwf	PT2		
		goto	INTERRUPT_LED_END
;--------------------------------
INTERRUPT_LED_P22:		
		;PT2.2
		btfsc	LED2,5
		incf	R_LED_DUTY,f
		btfsc	LED2,7
		incf	R_LED_DUTY,f
		btfsc	LED5,5
		incf	R_LED_DUTY,f
		btfsc	LED5,7
		incf	R_LED_DUTY,f
		btfsc	LED4,1
		incf	R_LED_DUTY,f
		btfsc	LED4,0
		incf	R_LED_DUTY,f
		btfsc	LED7,2
		incf	R_LED_DUTY,f
				
		btfsc	LED2,5
		bcf		R_LED_LIGHT,0
		btfsc	LED2,7
		bcf		R_LED_LIGHT,1
		btfsc	LED5,5
		bcf		R_LED_LIGHT,3
		btfsc	LED5,7
		bcf		R_LED_LIGHT,4
		btfsc	LED4,1
		bcf		R_LED_LIGHT,5
		btfsc	LED4,0
		bcf		R_LED_LIGHT,6
		btfsc	LED7,2
		bcf		R_LED_LIGHT,7
		
		movlw	11111111b
		xorwf	R_LED_LIGHT,w
		btfsc	status,z
		goto	INTERRUPT_LED_END
		
		bcf		R_LED_LIGHT,2
		movfw	R_LED_LIGHT
		movwf	PT2CON
		movwf	7FH					
		movlw	11111011b
		movwf	PT2		
		goto	INTERRUPT_LED_END
;--------------------------------
INTERRUPT_LED_P23:		
		;PT2.3
		btfsc	LED2,6
		incf	R_LED_DUTY,f
		btfsc	LED1,5
		incf	R_LED_DUTY,f
		btfsc	LED5,1
		incf	R_LED_DUTY,f
		btfsc	LED5,4
		incf	R_LED_DUTY,f
		btfsc	LED5,3
		incf	R_LED_DUTY,f
		btfsc	LED1,2
		incf	R_LED_DUTY,f		
		btfsc	LED7,3
		incf	R_LED_DUTY,f		
		
		btfsc	LED2,6
		bcf		R_LED_LIGHT,0
		btfsc	LED1,5
		bcf		R_LED_LIGHT,1
		btfsc	LED5,1
		bcf		R_LED_LIGHT,2
		btfsc	LED5,4
		bcf		R_LED_LIGHT,4
		btfsc	LED5,3
		bcf		R_LED_LIGHT,5
		btfsc	LED1,2
		bcf		R_LED_LIGHT,6
        btfsc	LED7,3
        bcf		R_LED_LIGHT,7
		
		movlw	11111111b
		xorwf	R_LED_LIGHT,w
		btfsc	status,z
		goto	INTERRUPT_LED_END
		
		bcf		R_LED_LIGHT,3
		movfw	R_LED_LIGHT
		movwf	PT2CON
		movwf	7FH				
		movlw	11110111b
		movwf	PT2		
		goto	INTERRUPT_LED_END
;--------------------------------
INTERRUPT_LED_P24:		
		;PT2.4
		btfsc	LED2,4
		incf	R_LED_DUTY,f
		btfsc	LED5,6
		incf	R_LED_DUTY,f
		btfsc	LED4,7
		incf	R_LED_DUTY,f
		btfsc	LED5,2
		incf	R_LED_DUTY,f
		btfsc	LED4,4
		incf	R_LED_DUTY,f
		btfsc	LED4,3
		incf	R_LED_DUTY,f
		btfsc	LED7,4
		incf	R_LED_DUTY,f				
		
		btfsc	LED2,4
		bcf		R_LED_LIGHT,0
		btfsc	LED5,6
		bcf		R_LED_LIGHT,1
		btfsc	LED4,7
		bcf		R_LED_LIGHT,2
		btfsc	LED5,2
		bcf		R_LED_LIGHT,3
		btfsc	LED4,4
		bcf		R_LED_LIGHT,5
		btfsc	LED4,3
		bcf		R_LED_LIGHT,6
		btfsc	LED7,4
		bcf		R_LED_LIGHT,7
		
		movlw	11111111b
		xorwf	R_LED_LIGHT,w
		btfsc	status,z
		goto	INTERRUPT_LED_END
		
		bcf		R_LED_LIGHT,4
		movfw	R_LED_LIGHT
		movwf	PT2CON
		movwf	7FH				
		movlw	11101111b
		movwf	PT2		
		goto	INTERRUPT_LED_END
;--------------------------------
INTERRUPT_LED_P25:				
		;PT2.5
		btfsc	LED3,6
		incf	R_LED_DUTY,f
		btfsc	LED3,5
		incf	R_LED_DUTY,f
		btfsc	LED4,5
		incf	R_LED_DUTY,f
		btfsc	LED1,7
		incf	R_LED_DUTY,f
		btfsc	LED4,2
		incf	R_LED_DUTY,f
		btfsc	LED3,4
		incf	R_LED_DUTY,f
		btfsc	LED7,5
		incf	R_LED_DUTY,f		
				
		btfsc	LED3,6
		bcf		R_LED_LIGHT,0
		btfsc	LED3,5
		bcf		R_LED_LIGHT,1
		btfsc	LED4,5
		bcf		R_LED_LIGHT,2
		btfsc	LED1,7
		bcf		R_LED_LIGHT,3
		btfsc	LED4,2
		bcf		R_LED_LIGHT,4
		btfsc	LED3,4
		bcf		R_LED_LIGHT,6
		btfsc	LED7,5
		bcf		R_LED_LIGHT,7
		
		movlw	11111111b
		xorwf	R_LED_LIGHT,w
		btfsc	status,z
		goto	INTERRUPT_LED_END
		
		bcf		R_LED_LIGHT,5
		movfw	R_LED_LIGHT
		movwf	PT2CON
		movwf	7FH					
		movlw	11011111b
		movwf	PT2		
		goto	INTERRUPT_LED_END
;--------------------------------
INTERRUPT_LED_P26:		
		;PT2.6
		btfsc	LED1,3
		incf	R_LED_DUTY,f
		btfsc	LED6,7
		incf	R_LED_DUTY,f
		btfsc	LED3,0
		incf	R_LED_DUTY,f
		btfsc	LED1,4
		incf	R_LED_DUTY,f
		btfsc	LED3,3
		incf	R_LED_DUTY,f
		btfsc	LED3,2
		incf	R_LED_DUTY,f		
		btfsc	LED7,6
		incf	R_LED_DUTY,f		
		
		btfsc	LED1,3
		bcf		R_LED_LIGHT,0
		btfsc	LED6,7
		bcf		R_LED_LIGHT,1
		btfsc	LED3,0
		bcf		R_LED_LIGHT,2
		btfsc	LED1,4
		bcf		R_LED_LIGHT,3
		btfsc	LED3,3
		bcf		R_LED_LIGHT,4
		btfsc	LED3,2
		bcf		R_LED_LIGHT,5
		btfsc	LED7,6
		bcf		R_LED_LIGHT,7
		
		movlw	11111111b
		xorwf	R_LED_LIGHT,w
		btfsc	status,z
		goto	INTERRUPT_LED_END
		
		bcf		R_LED_LIGHT,6		
		movfw	R_LED_LIGHT
		movwf	PT2CON
		movwf	7FH				
		movlw	10111111b
		movwf	PT2
		goto	INTERRUPT_LED_END		
;--------------------------------		
INTERRUPT_LED_P27:		
		;PT2.7
		btfsc	LED6,0
		incf	R_LED_DUTY,f
		btfsc	LED6,1
		incf	R_LED_DUTY,f
		btfsc	LED6,2
		incf	R_LED_DUTY,f
		btfsc	LED6,3
		incf	R_LED_DUTY,f
		btfsc	LED6,4
		incf	R_LED_DUTY,f
		btfsc	LED6,5
		incf	R_LED_DUTY,f		
		btfsc	LED6,6
		incf	R_LED_DUTY,f
			
		btfsc	LED6,0
		bcf		R_LED_LIGHT,0
		btfsc	LED6,1
		bcf		R_LED_LIGHT,1
		btfsc	LED6,2
		bcf		R_LED_LIGHT,2
		btfsc	LED6,3
		bcf		R_LED_LIGHT,3
		btfsc	LED6,4
		bcf		R_LED_LIGHT,4
		btfsc	LED6,5
		bcf		R_LED_LIGHT,5
		btfsc	LED6,6
		bcf		R_LED_LIGHT,6
		
		movlw	11111111b
		xorwf	R_LED_LIGHT,w
		btfsc	status,z
		goto	INTERRUPT_LED_END
		
		bcf		R_LED_LIGHT,7		
		movfw	R_LED_LIGHT
		movwf	PT2CON
		movwf	7FH				
		movlw	01111111b
		movwf	PT2
		goto	INTERRUPT_LED_END		
;--------------------------------	
INTERRUPT_LED_END:
		bcf		status,c
		rlf		R_LED_DUTY,f		
		;根据点灯个数做电流调整	
		movfw	R_LED_DUTY
		addpcw	
		nop
		nop
		movlw	10111000b					
		goto	INTERRUPT_LED_END1
		movlw	01111000b					
		goto	INTERRUPT_LED_END1
		movlw	00111000b					
		goto	INTERRUPT_LED_END1
		movlw	00011000b					
		goto	INTERRUPT_LED_END1
		movlw	00011000b					
		goto	INTERRUPT_LED_END1
		movlw	00011000b				
		goto	INTERRUPT_LED_END1
		movlw	00011000b	       			
		goto	INTERRUPT_LED_END1
;--------------------------------
INTERRUPT_LED_END1:	
		movwf	LEDCON1			
		;根据点灯个数做时间调整
		movfw	R_LED_DUTY
		addpcw	
		nop
		nop
		movlw	115							
		goto	INTERRUPT_LED_END2
		movlw	139						
		goto	INTERRUPT_LED_END2
		movlw	124
		goto	INTERRUPT_LED_END2
		movlw	130
		goto	INTERRUPT_LED_END2
		movlw	170
		goto	INTERRUPT_LED_END2
		movlw	210
		goto	INTERRUPT_LED_END2
		movlw	255
		goto	INTERRUPT_LED_END2			
INTERRUPT_LED_END2:	
		movwf	TM1IN	
			
L_LED_DRIVER_END: 		  


