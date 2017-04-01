L_Uart_Rec_START:	
    	incf		CS_Rx_Cnt,1
    	CS_JNE_FD	CS_Rx_Cnt,1
    	goto		RecData_1th				;接收1个字节
		;非首字节
		btfss		CS_Flag,CS_C5_Flag
		goto		RecDataLength           ;去接收FF数据
		;接收C5命令的数据
			
		CS_JE_FD	CS_Rx_Cnt,2
		goto		RecDataLoop		
		;第2字节
		movfw		SBUF
		movwf		CS_RDATALength
		movlw		3
		addwf		CS_RDATALength,1	
		goto		RecDataLoop
RecData_1th:	
		;第1个字节
		CS_JE_FD	SBUF,FFh           			; 判断帧头FF
		goto		Do_Cmd_C5			        ; FF 错误		
		bcf			CS_Flag,CS_C5_Flag
		goto		L_Uart_Rec_END
RecDataLength:
    	CS_JE_FD	CS_Rx_Cnt,2
    	goto		RecDataLoop
    	;第2字节
    	movfw		SBUF
     	movwf		CS_RDATALength			    ;数据长度
    	movlw		3
    	addwf		CS_RDATALength,1
    	bsf			BSR,IRP1	
     	movlw		RECDATASTART
    	movwf       CS_fsr1
    	bcf			BSR,IRP1
    	goto		L_Uart_Rec_END

RecDataLoop:
	   bsf			BSR,IRP1
       movfw       CS_fsr1
       movwf       fsr1
	   movfw		  SBUF
	   movwf		  IND1
	   incf		  CS_fsr1,1
	   bcf		  BSR,IRP1
	   btfss       CS_Flag,CS_C5_Flag
	   goto        FF_Check            ;接收数据指令长度限制 
C5_Check:                           ;接收命令指令长度限制
	  movlw       8
	  subwf       CS_Rx_Cnt,0
	  btfsc       status,c
	  goto        Uart_err       
	  goto        Finish_Check
FF_Check:
  	  movlw       24
	  subwf       CS_Rx_Cnt,0
 	  btfsc       status,c
	  goto        Uart_err
Finish_Check:		
	  CS_JE_FF    CS_Rx_Cnt,CS_RDATALength			;是否接收完成
	  goto	      L_Uart_Rec_END 
	  ;接收完成
      ;判断C5所有命令状态
      btfss		CS_Flag,CS_C5_Flag
      goto		RecFinishData
	
	  CS_JNE_FD	RPDATA3,80h           			;80h执行成功
	  goto        Flag_TS		
	  CS_JNE_FD	RPDATA3,81h           			;81h执行成功
	  goto        Flag_TF
	  CS_JNE_FD	RPDATA3,82h           			;82h执行成功
	  goto        Flag_CSF
	  CS_JNE_FD	RPDATA3,01h           			;01h BLE处于广播状态
	  goto        Flag_ADV
	  CS_JNE_FD	RPDATA3,04h           			;04h BLE处于连接状态
	  goto        Flag_CON
      goto		RecFinishData			
Flag_TS:
	  bsf			BLES,TS
	  goto        RecFinishC5
	
Flag_TF:
	  bsf			BLES,TF
	  goto        RecFinishC5
	
Flag_CSF:
	  bsf			BLES,CSF
	  goto        RecFinishC5
	
Flag_ADV:
	  bcf			BLES,BLESTATE
	  goto        RecFinishC5
	
Flag_CON:
	 bsf			BLES,BLESTATE
	  goto		RecFinishC5

RecFinishC5: 
	clrf		CS_Rx_Cnt
	bcf			BSR,IRP1
	bcf			CS_Flag,CS_C5_Flag
	clrf		CS_RDATALength
	goto		L_Uart_Rec_END
	
			
RecFinishData:	
	bcf			CS_Flag,CS_C5_Flag
	bsf         CS_Flag,DataReadFlag     ;RF接收到APP数据
	movfw		CS_RDATALength
	movwf		BleDataLength            ;RF接收到数据长度
	decf        BleDataLength,1
	decf        BleDataLength,1
    decf        BleDataLength,1	
	clrf		CS_Rx_Cnt
	clrf		CS_RDATALength
	goto		L_Uart_Rec_END	

Do_Cmd_C5:
	CS_JE_FD	SBUF,c5h           			; 判断帧头C5
	goto		RecDataExit			        ; C5 错误
	
	bsf			BSR,IRP1
	
	movlw		RPDATA1
	movwf		FSR1
	movwf       CS_fsr1
	
	movfw		SBUF
	movwf		IND1					;缓存帧头
	incf		CS_fsr1,1
	bcf			BSR,IRP1
	bsf			CS_Flag,CS_C5_Flag						

	goto		L_Uart_Rec_END

Uart_err:
	clrf		CS_Rx_Cnt
	bcf			BSR,IRP1
	bcf			CS_Flag,CS_C5_Flag
	clrf		CS_RDATALength   
 
    goto        L_Uart_Rec_END	
RecDataExit:
	clrf		CS_Rx_Cnt
	goto        L_Uart_Rec_END
L_Uart_Rec_END:
	
	
	