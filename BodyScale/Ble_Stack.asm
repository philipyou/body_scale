/*************************************************************************
MCU初始化
*************************************************************************/
Cs_Ble_Init:
	
	movlw	110b
	movwf	mck			;2MHZ	
	call	CS_clrf_ram	
	movlw	1110b		;P1.0  Rx  输入     P1.1 Tx  输出
	movwf	pt1en
	movlw	ffh
	movwf	pt1pu		;上拉
    clrf    pt1

						;UART Init
    MOVLW	01010001B	
    MOVWF	SCON1		;UART方式2
    bsF		SCON2,SMOD    ;波特率15200
    bsf		SCON2,6   ;14.7456M  
    bsf		INTE2,URRIE
    bcf		INTE2,URTIE
    bsf		INTE,GIE
    bsf     BSR,IRP1   ;寄存器后256个字节
    	
	return
/***************************END************************************************/	

/******************************************************************************
ble  downcode
******************************************************************************/	
BleInit:	
	
Ble_DDDD:
	call	Cs_Ble_Init	
    BCF     CS_Flag,CS_BleSuccess
    
Soft_Start:
    ;拉低GPIO5 10ms复位
	bsf		PTWAKEUPEN,bBleWakeupPin
	bcf		PTWAKEUPPU,bBleWakeupPin
	bcf		PTWAKEUP,bBleWakeupPin    
    movlw   30
	call   	cs_delay_1ms   	
	bsf		PTWAKEUPEN,bBleWakeupPin
	bcf		PTWAKEUPPU,bBleWakeupPin
	bsf		PTWAKEUP,bBleWakeupPin    	    
;Rest  01 00  fc 00	
Soft_Rest:
    movlw   200
	call   	cs_delay_1ms   
	bcf		CS_Flag,CS_RecFinishFlag
    MOVLW	CS_STARTADDRESS
    MOVWF	CS_RxAddress					;存储接受到数据地址	
    
	call	YC_softReset
    movlw   20
	call   	cs_delay_1ms   
	btfss	CS_Flag,CS_RecFinishFlag
	goto	Soft_Rest1
	bcf		CS_Flag,CS_RecFinishFlag
	goto    Downcode_Start

Soft_Rest1:
    incf    BleDataLength,1
	movlw   10
	subwf   BleDataLength,0
	btfss   status,c
    goto    Soft_Rest

    call    BleRest96
    movlw   70
	call    cs_delay_1ms 
	 clrf    BleDataLength
    goto    Soft_Rest
;downcode
Downcode_Start:

    movlw	CS_CODEADDRESSL   
    MOVWF   EADRL
    MOVLW   CS_CODEADDRESSH
    MOVWF   EADRH
    movp
    nop		
    movwf	CS_PathBufLength
    
Downcode_Lp1:    
    MOVLW	CS_STARTADDRESS
    MOVWF	CS_RxAddress					;存储接受到数据地址	
            
    movlw	CS_CODEADDENDL    
    subwf   EADRL,0
    btfss	status,z
    goto	Downcode_Lp2
    movlw	CS_CODEADDENDH
    subwf	EADRH,0
    btfss	status,z
    goto	DownCode_Lp2
    goto	Downcode_End
Downcode_LP2:
    
    incfsz	EADRL,1
    goto	$+3
    clrf	EADRL						;规避编译器加一问题
    incf	EADRH,1
    movp
    nop	    	
    movwf	CS_FlashSave				;暂存低位
    movfw	EDAT
    movwf	sbuf						;发送高位
    btfss  	INTF2,URTIF
    GOTO	$-1	 
    bcf		INTF2,URTIF       
    decfsz	CS_PathBufLength,1
    goto	$+2
    goto	DownCOde_LP3
    
DownCOde_LP22:    

    movfw	CS_FlashSave
    movwf	sbuf						;发送低位
    btfss  	INTF2,URTIF
    GOTO	$-1	 
    bcf		INTF2,URTIF       
    decfsz	CS_PathBufLength,1
    goto	DownCOde_LP2    
    goto	DownCOde_LP4
DownCOde_LP4: 
   										;偶数
    incfsz	EADRL,1
    goto	$+3
    clrf	EADRL						;规避编译器加一问题
    incf	EADRH,1
    movp
    nop		
    movwf	CS_FlashSave				;暂存低位
    movfw	EDAT
	movwf	CS_PathBufLength			;要发送buf长度  
	    
	btfss	CS_Flag,CS_RecFinishFlag  ;应答04 0e 04 01 03 fc 00 
	goto	$-1
	bcf		CS_Flag,CS_RecFinishFlag 

;    call	CS_Delay
    
    MOVLW	CS_STARTADDRESS
    MOVWF	CS_RxAddress				;存储接受到数据地址	
    	
    movlw	CS_CODEADDENDL    
    subwf   EADRL,0
    btfss	status,z
    goto	Downcode_Lp22
    movlw	CS_CODEADDENDH
    subwf	EADRH,0
    btfss	status,z
    goto	DownCode_Lp22
    goto	Downcode_End	


    	   
    
DownCOde_LP3:    						;单数
	movfw	Cs_FlashSave
	movwf	CS_PathBufLength			;要发送buf长度
	
	btfss	CS_Flag,CS_RecFinishFlag    ;应答04 0e 04 01 03 fc 00 
	goto	$-1
	bcf		CS_Flag,CS_RecFinishFlag  
	  
;    call	CS_Delay	
    
    goto	Downcode_Lp1
    
    
Downcode_End:
  	movlw	 	70
	dw			ffffh
	dw			ffffh
	nop
	call     	cs_delay_1ms 		

	bcf	    	CS_Flag,CS_RecFinishFlag   
    dw			ffffh
    nop
	call		sub_Send_Mac  
	
	
  	movlw	 	60
	dw			ffffh
	dw			ffffh
	nop
	call     	cs_delay_1ms 
    bcf			bsr,7       
 	bsf	    	CS_Flag,CS_BleSuccess    
	bsf			PTWAKEUPEN,bBleWakeupPin
	bcf			PTWAKEUPPU,bBleWakeupPin
	bSf			PTWAKEUP,bBleWakeupPin	    
    RETURN
/**********************************end**************************************************/    
YC_softReset:
	movlw 	YC_CMD 
	movwf	sbuf
    btfss  	INTF2,URTIF
    GOTO	$-1	 
    bcf		INTF2,URTIF
    
	movlw 	YC_CMD_RESET
	movwf	sbuf
    btfss  	INTF2,URTIF
    GOTO	$-1	 
    bcf		INTF2,URTIF    
    
	movlw 	YC_CMD_OGF
	movwf	sbuf
    btfss  	INTF2,URTIF
    GOTO	$-1	 
    bcf		INTF2,URTIF   
    
	movlw 	0x00
	movwf	sbuf
    btfss  	INTF2,URTIF
    GOTO	$-1	 
    bcf		INTF2,URTIF 
    movlw   10
    call    Cs_delay_1ms   
    return 
/************************************************************/

;/***************延时*****************************/
;CS_Delay:
;		MOVLW		20
;		MOVWF       CS_DelayR1
;		
;CS_Delay_Lp1:		
;		movlw		125
;		movwf		CS_DelayR2
;CS_Delay_Lp2:
;		nop
;		nop
;		nop
;		nop
;		nop
;		decfsz		CS_DelayR2,1
;		goto		CS_Delay_Lp2
;		decfsz		CS_DelayR1,1
;		goto		CS_Delay_Lp1
;		return	
		
		
CS_clrf_ram:
		clrf		bsr
		movlw		ffh
		movwf   	80h
		movlw		81h
		movwf   	fsr0
		bsf     	BSR,IRP1	   
		movlw		100h
		movwf   	fsr1	   	  	   
CS_clrf_loop:
		clrf   		ind0   
		clrf   		ind1
		incf        fsr0,1
		incf        fsr1,1
		bcf			status,c
		decfsz      80h,1
		goto        CS_clrf_loop
;;		bcf         BSR,IRP1
		movlw		180h
		movwf   	fsr1
		movlw		64
		movwf   	80h
CS_clrf_loop2:  
		clrf   		ind1
		incf    	fsr1,1		
		bcf			status,c
		decfsz   	80h,1		
		goto     	CS_clrf_loop2				
		return   	

;================================================
;   UART发送一个字节
;------------------------------------------------
CS_SendByte:		
	btfss  		INTF2,URTIF
    goto		$-1	 
    bcf			INTF2,URTIF 
	return		


;****************************************************
;功能：蓝牙睡眠      
;****************************************************
BleSleep:
	bsf			PTWAKEUPEN,bBleWakeupPin
	bcf			PTWAKEUPPU,bBleWakeupPin
	bcf			PTWAKEUP,bBleWakeupPin
	
	movlw		6
	dw			ffffh
	nop
	call  		cs_delay_1ms 								

	movlw		10h
	movwf		SBUF
	call		cs_Send_Byte
			
	movlw		00h
	movwf		SBUF
	call		cs_Send_Byte
	
	movlw		00h
	movwf		SBUF
	call		cs_Send_Byte
		
	movlw		00h
	movwf		SBUF
	call		cs_Send_Byte
				
	movlw		C5h
	movwf		SBUF
	call		cs_Send_Byte
	
	movlw		01h
	movwf		SBUF
	call		cs_Send_Byte
	
	movlw		80h
	movwf		SBUF
	call		cs_Send_Byte
	
	movlw		44h
	movwf		SBUF
	call		cs_Send_Byte
	
	bsf			PTWAKEUP,bBleWakeupPin					
	return	
	
BleRest96:
	bsf			PTWAKEUPEN,bBleWakeupPin
	bcf			PTWAKEUPPU,bBleWakeupPin
	bcf			PTWAKEUP,bBleWakeupPin
	
	movlw		6
	dw			ffffh
	nop
	call  		cs_delay_1ms 								


				
	movlw		C5h
	movwf		SBUF
	call		cs_Send_Byte
	
	movlw		01h
	movwf		SBUF
	call		cs_Send_Byte
	
	movlw		96h
	movwf		SBUF
	call		cs_Send_Byte
	
	movlw		52h
	movwf		SBUF
	call		cs_Send_Byte
	
	bsf			PTWAKEUP,bBleWakeupPin					
	return	
;****************************************************
;功能：蓝牙唤醒      
;****************************************************
BleWakeup:
	bsf			PTWAKEUPEN,bBleWakeupPin
	bcf			PTWAKEUPPU,bBleWakeupPin
	bcf			PTWAKEUP,bBleWakeupPin
	
	movlw		6
	call  		cs_delay_1ms
	bsf			PTWAKEUP,bBleWakeupPin
			
	return

;****************************************************
;功能：查询蓝牙状态    
;****************************************************
QueryBleState:
	bsf			PTWAKEUPEN,bBleWakeupPin
	bcf			PTWAKEUPPU,bBleWakeupPin
	bcf			PTWAKEUP,bBleWakeupPin
	
	movlw		6
	call  		cs_delay_1ms 								
				
	movlw		C5h
	movwf		SBUF
	call		cs_Send_Byte
	
	movlw		01h
	movwf		SBUF
	call		cs_Send_Byte
	
	movlw		81h              ;蓝牙状态
	movwf		SBUF
	call		cs_Send_Byte
	
	movlw		45h
	movwf		SBUF
	call		cs_Send_Byte
	
	bsf			PTWAKEUP,bBleWakeupPin
	return

;;;--------------------------------------------------------
cs_Send_Byte:
	BTFSS		INTF2,URTIF
	goto		cs_Send_Byte
	bcf			INTF2,URTIF		
	return

;****************************************************
;功能：在OTP地址3FFA-3FFF读取MAC地址     
; 3FFA保存第1字节地址
;****************************************************
sub_Send_Mac:
    bsf     	PTWAKEUPen,bBleWakeupPin
    bsf     	PTWAKEUPpu,bBleWakeupPin
	bcf			PTWAKEUP,bBleWakeupPin
	movlw		6
	dw			ffffh
	nop
	call  		cs_delay_1ms								
	
	;Read Mac 
	movlw		3
	movwf		CS_R0
	
	movlw       1fH		
	movwf		EADRH	
	movlw       fdH		
	movwf		EADRL
	movwf		CS_R1
	
	bsf			BSR,IRP1
	movlw		TDATA1
	movwf		FSR1
ReadMac:	
	movp
	movwf		CS_FlashSave
	movfw		EDAT
	movwf		IND1
	
	incf		FSR1,1	
	movfw		CS_FlashSave
	movwf		IND1
	
	incf		FSR1,1		
	incf		CS_R1,1
	movfw		CS_R1
	movwf		EADRL

	decfsz		CS_R0,1
	goto		ReadMac				
	;Read Mac END
	;==============================test========================
;	movlw       06h
;	movwf       TDATA6
;	movlw       9ch
;	movwf       TDATA5
;	movlw       3ch
;	movwf       TDATA4
;	movlw       93h
;	movwf       TDATA3
;	movlw       7ah
;	movwf       TDATA2
;	movlw       18h
;	movwf       TDATA1
	;==============================test========================	
	;checksum
	movlw		6
	movwf		CS_R0
	
	clrf		CS_R1
	movlw		TDATA1
	movwf		FSR1
Mac_XOR_L1:		
	movfw		IND1
	xorwf 		CS_R1,1
	incf		FSR1,1
	decfsz		CS_R0,1
	goto		Mac_XOR_L1
	bcf			BSR,IRP1
	
	movlw		C5h
	xorwf		CS_R1,1
	movlw		07h
	xorwf		CS_R1,1
	movlw		90h
	xorwf		CS_R1,1
	

	movlw		C5h
	movwf		SBUF
	call		cs_Send_Byte
		
	movlw		07h
	movwf		SBUF
	call		cs_Send_Byte
		
	movlw		90h
	movwf		SBUF
	call		cs_Send_Byte
	
	;MAC	
	movfw		TDATA6
	movwf		SBUF
	call		cs_Send_Byte
		
	movfw		TDATA5
	movwf		SBUF
	call		cs_Send_Byte
		
	movfw		TDATA4
	movwf		SBUF
	call		cs_Send_Byte
		
	movfw		TDATA3
	movwf		SBUF
	call		cs_Send_Byte		
		
	movfw		TDATA2
	movwf		SBUF
	call		cs_Send_Byte	
		
	movfw		TDATA1
	movwf		SBUF          ;第1字节
	call		cs_Send_Byte
	
	;MAC END	

	movfw		CS_R1
	movwf		SBUF          ;校验
	call		cs_Send_Byte									
		

	
	clrf		TDATA1
	clrf		TDATA2
	clrf		TDATA3
	clrf		TDATA4
	clrf		TDATA5
	clrf		TDATA6
	
	bsf			PTWAKEUP,bBleWakeupPin	
						
	return		
	


;***********************************************
;延时指令周期数：2+2+1	+	(250*8*delay_k1)
;  函数进入2条指令周期，退出1条指令周期，
;  数据准备2条指令周期
;***********************************************
cs_delay_1ms:							
	movwf   	CS_DelayR1
delay_1ms_lp1:
	movlw   	249
	movwf		CS_DelayR2
delay_1ms_lp2:
	nop
	nop
	nop
	nop
	nop
	decfsz  	CS_DelayR2,1
	goto    	delay_1ms_lp2
	decfsz  	CS_DelayR1,1
	goto    	delay_1ms_lp1
	return	
	
		    
/************************************end*************************************/

	
RFINT:
	push
;	bcf			INTE,GIE 
    movfw       bsr
	movwf       CS_BsrSave	
	movfw		fsr0
	movwf       CS_fsr0_save
	movfw       fsr1
	movwf       CS_fsr1_save
	
	
interrupt_uartri:
		
	btfss		INTF2,URRIF
	goto		interrupt_clrf
	BCF			INTF2,URRIF
										        ;UART接收到数据						
	incf 		CS_RxAddress,1			
	    		    
RecCmdFinish:									;是否接受完成
	MOVLW		CS_ENDADDRESS					
	xorwf       CS_RxAddress,0	 
	btfss		status,z
	goto		interrupt_exit
	bsf			CS_Flag,CS_RecFinishFlag		;接收完成   	
interrupt_clrf:
	
	clrf        intf
	clrf        intf2
interrupt_exit:

    movfw       CS_BsrSave
	movwf       bsr		
	movfw		CS_fsr0_save
	movwf		fsr0	


	movfw       CS_fsr1_save
	movwf       fsr1	
	pop
	
	
    retfie
	

		    
