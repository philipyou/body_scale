
/***********************************************************

发送数据
***********************************************************/
SendBleName:	
	bsf			PTWAKEUPEN,bBleWakeupPin
	bcf			PTWAKEUPPU,bBleWakeupPin
	bcf			PTWAKEUP,bBleWakeupPin
	
	movlw		6
	call  		cs_delay_1ms
	
	clrf		Num
				
	movlw		C5h
	movwf		SBUF
	call		cs_Send_Byte
	
	movlw       C5h
	xorwf       Num,f
	
	movlw		03h
	movwf		SBUF
	call		cs_Send_Byte
	
	movlw       03h
	xorwf       Num,f
	
	movlw		89h
	movwf		SBUF
	call		cs_Send_Byte
	
	movlw       89h
	xorwf       Num,f
	
	movlw		57h
	movwf		SBUF
	call		cs_Send_Byte
	
	movlw       57h
	xorwf       Num,f
	
	movlw		42h
	movwf		SBUF
	call		cs_Send_Byte
	
	movlw       42h
	xorwf       Num,f
	
	movfw		Num
	movwf		SBUF
	call		cs_Send_Byte	
	bsf			PTWAKEUP,bBleWakeupPin
	return

	
/***********************************************************

发送UUID
***********************************************************/
SendUUID:	
	bsf			PTWAKEUPEN,bBleWakeupPin
	bcf			PTWAKEUPPU,bBleWakeupPin
	bcf			PTWAKEUP,bBleWakeupPin
	
	movlw		6
	call  		cs_delay_1ms
				
	movlw		C5h
	movwf		SBUF
	call		cs_Send_Byte	
	movlw		08h
	movwf		SBUF
	call		cs_Send_Byte	
	movlw		85h
	movwf		SBUF
	call		cs_Send_Byte	
	movlw		FEh			;SERVICE UUID
	movwf		SBUF		
	call		cs_Send_Byte		
	movlw		E7h
	movwf		SBUF
	call		cs_Send_Byte
	movlw		FEh			;WRITE UUID
	movwf		SBUF		
	call		cs_Send_Byte		
	movlw		C7h
	movwf		SBUF
	call		cs_Send_Byte
	movlw		FEh			;NOTICE UUID
	movwf		SBUF		
	call		cs_Send_Byte		
	movlw		C8h
	movwf		SBUF
	call		cs_Send_Byte
	movlw		00h
	movwf		SBUF
	call		cs_Send_Byte
	
	
	clrf		Num
	movlw       C5h
	xorwf       Num,f
	movlw       08h
	xorwf       Num,f
	movlw       85h
	xorwf       Num,f
	movlw       FEh
	xorwf       Num,f
	movlw       E7h
	xorwf       Num,f
	movlw       FEh
	xorwf       Num,f
	movlw       C7h
	xorwf       Num,f
	movlw       FEh
	xorwf       Num,f
	movlw       C8h
	xorwf       Num,f
	movlw       00h
	xorwf       Num,f
	
	movfw		Num
	movwf		SBUF
	call		cs_Send_Byte	
	bsf			PTWAKEUP,bBleWakeupPin
	return


/***********************************************************

发送数据
***********************************************************/
SendBleData:	
	bsf			PTWAKEUPEN,bBleWakeupPin
	bcf			PTWAKEUPPU,bBleWakeupPin
	bcf			PTWAKEUP,bBleWakeupPin
	
	movlw		6
	call  		cs_delay_1ms 								
				
	movlw		C5h
	movwf		SBUF
	call		cs_Send_Byte
	
	movlw		03h
	movwf		SBUF
	call		cs_Send_Byte
	
	movlw		95h
	movwf		SBUF
	call		cs_Send_Byte
	
	movfw		R_SYS_ADbufH
	movwf		SBUF
	call		cs_Send_Byte
	
	movfw		R_SYS_ADbufL
	movwf		SBUF
	call		cs_Send_Byte
	
	movlw       53h
	xorwf		R_SYS_ADbufH,0
	xorwf       R_SYS_ADbufL,0	

	movwf		SBUF
	call		cs_Send_Byte	
	bsf			PTWAKEUP,bBleWakeupPin
	return

	
	
/*******************************************************
设置广播间隔  1s
*******************************************************/
BLESETTIME:
    bsf     	PTWAKEUPen,bBleWakeupPin
    bsf     	PTWAKEUPpu,bBleWakeupPin
	bcf			PTWAKEUP,bBleWakeupPin
	movlw		6
	call  		cs_delay_1ms  
	
	movlw       c5h
	movwf		SBUF
	call		cs_Send_Byte	
	
	movlw       03H
	movwf		SBUF
	call		cs_Send_Byte

	movlw       82H
	movwf		SBUF
	call		cs_Send_Byte
	
	movlw       40h
	movwf		SBUF                    ;1s
	call		cs_Send_Byte
	
	movlw       06h
	movwf		SBUF
	call		cs_Send_Byte
	
	movlw       02h
	movwf		SBUF
	call		cs_Send_Byte	

	bsf			PTWAKEUP,bBleWakeupPin
	return		