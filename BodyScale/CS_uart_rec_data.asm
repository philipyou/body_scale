L_Uart_Rec_START:	
    	incf		CS_Rx_Cnt,1
    	CS_JNE_FD	CS_Rx_Cnt,1
    	goto		RecData_1th				;����1���ֽ�
		;�����ֽ�
		btfss		CS_Flag,CS_C5_Flag
		goto		RecDataLength           ;ȥ����FF����
		;����C5���������
			
		CS_JE_FD	CS_Rx_Cnt,2
		goto		RecDataLoop		
		;��2�ֽ�
		movfw		SBUF
		movwf		CS_RDATALength
		movlw		3
		addwf		CS_RDATALength,1	
		goto		RecDataLoop
RecData_1th:	
		;��1���ֽ�
		CS_JE_FD	SBUF,FFh           			; �ж�֡ͷFF
		goto		Do_Cmd_C5			        ; FF ����		
		bcf			CS_Flag,CS_C5_Flag
		goto		L_Uart_Rec_END
RecDataLength:
    	CS_JE_FD	CS_Rx_Cnt,2
    	goto		RecDataLoop
    	;��2�ֽ�
    	movfw		SBUF
     	movwf		CS_RDATALength			    ;���ݳ���
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
	   goto        FF_Check            ;��������ָ������� 
C5_Check:                           ;��������ָ�������
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
	  CS_JE_FF    CS_Rx_Cnt,CS_RDATALength			;�Ƿ�������
	  goto	      L_Uart_Rec_END 
	  ;�������
      ;�ж�C5��������״̬
      btfss		CS_Flag,CS_C5_Flag
      goto		RecFinishData
	
	  CS_JNE_FD	RPDATA3,80h           			;80hִ�гɹ�
	  goto        Flag_TS		
	  CS_JNE_FD	RPDATA3,81h           			;81hִ�гɹ�
	  goto        Flag_TF
	  CS_JNE_FD	RPDATA3,82h           			;82hִ�гɹ�
	  goto        Flag_CSF
	  CS_JNE_FD	RPDATA3,01h           			;01h BLE���ڹ㲥״̬
	  goto        Flag_ADV
	  CS_JNE_FD	RPDATA3,04h           			;04h BLE��������״̬
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
	bsf         CS_Flag,DataReadFlag     ;RF���յ�APP����
	movfw		CS_RDATALength
	movwf		BleDataLength            ;RF���յ����ݳ���
	decf        BleDataLength,1
	decf        BleDataLength,1
    decf        BleDataLength,1	
	clrf		CS_Rx_Cnt
	clrf		CS_RDATALength
	goto		L_Uart_Rec_END	

Do_Cmd_C5:
	CS_JE_FD	SBUF,c5h           			; �ж�֡ͷC5
	goto		RecDataExit			        ; C5 ����
	
	bsf			BSR,IRP1
	
	movlw		RPDATA1
	movwf		FSR1
	movwf       CS_fsr1
	
	movfw		SBUF
	movwf		IND1					;����֡ͷ
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
	
	
	