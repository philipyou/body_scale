;==================================================
;		MAP OF RAM
;==================================================
; private
RAM_LED_Map_S		 equ  R_RAM_ALC_LM_S
R_LED_TEMP1			 equ  RAM_LED_Map_S+0			;Ó³Éä¹ý³Ì»º´æ
R_LED_TEMP2			 equ  RAM_LED_Map_S+1			
R_LED_TEMP3			 equ  RAM_LED_Map_S+2
R_LED_TEMP4			 equ  RAM_LED_Map_S+3
R_LED_TEMP5			 equ  RAM_LED_Map_S+4
R_LED_TEMP6			 equ  RAM_LED_Map_S+5
R_LED_TEMP7			 equ  RAM_LED_Map_S+6

F_LED_REFRESH:		
		call	F_LED_MAPPING_CLR
		call	F_LED_MAPPING
		call	F_LED_MAPPING_ASSIGNMENT                            
		RETURN


F_LED_MAPPING_CLR:
		clrf	R_LED_TEMP1
		clrf	R_LED_TEMP2
		clrf	R_LED_TEMP3
		clrf	R_LED_TEMP4
		clrf	R_LED_TEMP5
		clrf	R_LED_TEMP6
		clrf	R_LED_TEMP7		
		RETURN


;Í¨ÓÃ°æ±¾	
F_LED_MAPPING:
		;---LED1Ó³Éä×ª»»
		btfsc	R_LED_BUFFER1,0
		bsf		R_LED_BUFFER1_BIT0
		btfsc	R_LED_BUFFER1,1
		bsf		R_LED_BUFFER1_BIT1
		btfsc	R_LED_BUFFER1,2
		bsf		R_LED_BUFFER1_BIT2
		btfsc	R_LED_BUFFER1,3
		bsf		R_LED_BUFFER1_BIT3
		btfsc	R_LED_BUFFER1,4
		bsf		R_LED_BUFFER1_BIT4
		btfsc	R_LED_BUFFER1,5
		bsf		R_LED_BUFFER1_BIT5
		btfsc	R_LED_BUFFER1,6
		bsf		R_LED_BUFFER1_BIT6	
		btfsc	R_LED_BUFFER1,7
		bsf		R_LED_BUFFER1_BIT7
		;---LED2Ó³Éä×ª»»
		btfsc	R_LED_BUFFER2,0
		bsf		R_LED_BUFFER2_BIT0
		btfsc	R_LED_BUFFER2,1
		bsf		R_LED_BUFFER2_BIT1
		btfsc	R_LED_BUFFER2,2
		bsf		R_LED_BUFFER2_BIT2
		btfsc	R_LED_BUFFER2,3
		bsf		R_LED_BUFFER2_BIT3
		btfsc	R_LED_BUFFER2,4
		bsf		R_LED_BUFFER2_BIT4
		btfsc	R_LED_BUFFER2,5
		bsf		R_LED_BUFFER2_BIT5
		btfsc	R_LED_BUFFER2,6
		bsf		R_LED_BUFFER2_BIT6	
		btfsc	R_LED_BUFFER2,7
		bsf		R_LED_BUFFER2_BIT7
		;---LED3Ó³Éä×ª»»
		btfsc	R_LED_BUFFER3,0
		bsf		R_LED_BUFFER3_BIT0
		btfsc	R_LED_BUFFER3,1
		bsf		R_LED_BUFFER3_BIT1
		btfsc	R_LED_BUFFER3,2
		bsf		R_LED_BUFFER3_BIT2
		btfsc	R_LED_BUFFER3,3
		bsf		R_LED_BUFFER3_BIT3
		btfsc	R_LED_BUFFER3,4
		bsf		R_LED_BUFFER3_BIT4
		btfsc	R_LED_BUFFER3,5
		bsf		R_LED_BUFFER3_BIT5
		btfsc	R_LED_BUFFER3,6
		bsf		R_LED_BUFFER3_BIT6	
		btfsc	R_LED_BUFFER3,7
		bsf		R_LED_BUFFER3_BIT7
		;---LED4Ó³Éä×ª»»
		btfsc	R_LED_BUFFER4,0
		bsf		R_LED_BUFFER4_BIT0
		btfsc	R_LED_BUFFER4,1
		bsf		R_LED_BUFFER4_BIT1
		btfsc	R_LED_BUFFER4,2
		bsf		R_LED_BUFFER4_BIT2
		btfsc	R_LED_BUFFER4,3
		bsf		R_LED_BUFFER4_BIT3
		btfsc	R_LED_BUFFER4,4
		bsf		R_LED_BUFFER4_BIT4
		btfsc	R_LED_BUFFER4,5
		bsf		R_LED_BUFFER4_BIT5
		btfsc	R_LED_BUFFER4,6
		bsf		R_LED_BUFFER4_BIT6
		btfsc	R_LED_BUFFER4,7
		bsf		R_LED_BUFFER4_BIT7
		;---LED5Ó³Éä×ª»»
		btfsc	R_LED_BUFFER5,0
		bsf		R_LED_BUFFER5_BIT0
		btfsc	R_LED_BUFFER5,1
		bsf		R_LED_BUFFER5_BIT1
		btfsc	R_LED_BUFFER5,2
		bsf		R_LED_BUFFER5_BIT2
		btfsc	R_LED_BUFFER5,3
		bsf		R_LED_BUFFER5_BIT3
		btfsc	R_LED_BUFFER5,4
		bsf		R_LED_BUFFER5_BIT4
		btfsc	R_LED_BUFFER5,5
		bsf		R_LED_BUFFER5_BIT5
		btfsc	R_LED_BUFFER5,6
		bsf		R_LED_BUFFER5_BIT6
		btfsc	R_LED_BUFFER5,7
		bsf		R_LED_BUFFER5_BIT7
		;---LED6Ó³Éä×ª»»
		btfsc	R_LED_BUFFER6,0
		bsf		R_LED_BUFFER6_BIT0
		btfsc	R_LED_BUFFER6,1
		bsf		R_LED_BUFFER6_BIT1
		btfsc	R_LED_BUFFER6,2
		bsf		R_LED_BUFFER6_BIT2
		btfsc	R_LED_BUFFER6,3
		bsf		R_LED_BUFFER6_BIT3
		btfsc	R_LED_BUFFER6,4
		bsf		R_LED_BUFFER6_BIT4
		btfsc	R_LED_BUFFER6,5
		bsf		R_LED_BUFFER6_BIT5
		btfsc	R_LED_BUFFER6,6
		bsf		R_LED_BUFFER6_BIT6
		btfsc	R_LED_BUFFER6,7
		bsf		R_LED_BUFFER6_BIT7
		;---LED7Ó³Éä×ª»»
		btfsc	R_LED_BUFFER7,0
		bsf		R_LED_BUFFER7_BIT0       
		btfsc	R_LED_BUFFER7,1
		bsf		R_LED_BUFFER7_BIT1      
		btfsc	R_LED_BUFFER7,2
		bsf		R_LED_BUFFER7_BIT2     
		btfsc	R_LED_BUFFER7,3
		bsf		R_LED_BUFFER7_BIT3       
		btfsc	R_LED_BUFFER7,4
		bsf		R_LED_BUFFER7_BIT4	      
		btfsc	R_LED_BUFFER7,5
		bsf		R_LED_BUFFER7_BIT5    	  
		btfsc	R_LED_BUFFER7,6
		bsf		R_LED_BUFFER7_BIT6    	 
		btfsc	R_LED_BUFFER7,7
		bsf		R_LED_BUFFER7_BIT7      
		return
		
F_LED_MAPPING_ASSIGNMENT:
		movfw	R_LED_TEMP1
		movwf	LED1
		movfw	R_LED_TEMP2
		movwf	LED2
		movfw	R_LED_TEMP3
		movwf	LED3
		movfw	R_LED_TEMP4
		movwf	LED4
		movfw	R_LED_TEMP5
		movwf	LED5
		movfw	R_LED_TEMP6
		movwf	LED6
		movfw	R_LED_TEMP7
		movwf	LED7
		RETURN

	


	  


