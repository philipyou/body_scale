INT_All:
	 ;-------------------------	
	 ;  �����ֳ�
     ;-------------------------
		push
    	movfw   BSR
		movwf   CS_BsrSave	
		movfw	FSR0
		movwf   CS_fsr0_save
		movfw   FSR1
		movwf   CS_fsr1_save
	 ;-------------------------	
	 ;  �ж����
     ;-------------------------		
		btfsc	INTF2,URRIF		;���ڽ����ж�
		goto	INT_URR	
		
		btfsc	INTF,ADIF		;AD�ж�
		goto	INT_AD
		
		btfsc	INTF,TM1IF		;Timer1�ж�
		goto	INT_TM1
		
		goto	INT_OTHER
	 ;-------------------------	
	 ;  ���ڽ����ж�
     ;-------------------------	
INT_URR:
		bcf		INTF2,URRIF
		include	CS_uart_rec_data.asm
		goto	INT_EXIT
	 ;-------------------------	
	 ;  AD�ж�
     ;-------------------------
INT_AD:
		bcf		INTF,ADIF
		
		btfsc	R_INT_AD_FLAG,B_GetAdc
		goto	INT_EXIT
		
		movfw	ADOH				;��ȡԭʼAD
		movwf	R_INT_AdH
		movfw	ADOL
		movwf	R_INT_AdM
		movfw	ADOLL
		movwf	R_INT_AdL
		
		bsf		R_INT_AD_FLAG,B_GetAdc		
		goto	INT_EXIT	
	 ;-------------------------	
	 ;  Timer1�ж�
     ;-------------------------	
INT_TM1:
		bcf		intf,tm1if		
		include CS_led_drv.asm		
		goto	INT_EXIT	
	 ;-------------------------	
	 ;  �����ж�
     ;-------------------------		
INT_OTHER:
       	clrf	INTF
       	goto	INT_EXIT
	 ;-------------------------	
	 ;  �жϳ���
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

	




