INT_All:
	 ;-------------------------	
	 ;  保护现场
     ;-------------------------
		push
    	movfw   BSR
		movwf   CS_BsrSave	
		movfw	FSR0
		movwf   CS_fsr0_save
		movfw   FSR1
		movwf   CS_fsr1_save
	 ;-------------------------	
	 ;  中断入口
     ;-------------------------		
		btfsc	INTF2,URRIF		;串口接收中断
		goto	INT_URR	
		
		btfsc	INTF,ADIF		;AD中断
		goto	INT_AD
		
		btfsc	INTF,TM1IF		;Timer1中断
		goto	INT_TM1
		
		goto	INT_OTHER
	 ;-------------------------	
	 ;  串口接收中断
     ;-------------------------	
INT_URR:
		bcf		INTF2,URRIF
		include	CS_uart_rec_data.asm
		goto	INT_EXIT
	 ;-------------------------	
	 ;  AD中断
     ;-------------------------
INT_AD:
		bcf		INTF,ADIF
		
		btfsc	R_INT_AD_FLAG,B_GetAdc
		goto	INT_EXIT
		
		movfw	ADOH				;获取原始AD
		movwf	R_INT_AdH
		movfw	ADOL
		movwf	R_INT_AdM
		movfw	ADOLL
		movwf	R_INT_AdL
		
		bsf		R_INT_AD_FLAG,B_GetAdc		
		goto	INT_EXIT	
	 ;-------------------------	
	 ;  Timer1中断
     ;-------------------------	
INT_TM1:
		bcf		intf,tm1if		
		include CS_led_drv.asm		
		goto	INT_EXIT	
	 ;-------------------------	
	 ;  其它中断
     ;-------------------------		
INT_OTHER:
       	clrf	INTF
       	goto	INT_EXIT
	 ;-------------------------	
	 ;  中断出口
     ;-------------------------
INT_EXIT:
		movfw   CS_BsrSave
		movwf   BSR		
		movfw	CS_fsr0_save
		movwf	FSR0	
		movfw   CS_fsr1_save
		movwf   FSR1
		pop
		retfie

	




