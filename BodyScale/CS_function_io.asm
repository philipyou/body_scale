
;==================================================
;		�������A����
;==================================================
;���ܣ����ڵ����ַFSR0����RAM��R_FUNC_A0~5
;	   �����WORK������������ĸ���
;	   ����˳�����δ�R_FUNC_A0��R_FUNC_A5
;���룺FSR0,WORK
;���棺R_FUNC_COUNT
;�����R_FUNC_A0~5
;==================================================
F_Input_ParameterA:
		movwf	R_FUNC_COUNT
		bcf		BSR,PAGE0	
		bsf		BSR,IRP0
		bcf		BSR,PAGE1		;* Ϊ��ͨ��������������������ڵ�һҳ����256��ram
		bsf		BSR,IRP1
		
		movfw	R_FUNC_A0		; ����A0��A5�����ݣ����ڲ���B����A��ԭʼ����
		movwf	R_FUNC_BAK_A0	
		movfw	R_FUNC_A1
		movwf	R_FUNC_BAK_A1
		movfw	R_FUNC_A2
		movwf	R_FUNC_BAK_A2
		movfw	R_FUNC_A3
		movwf	R_FUNC_BAK_A3
		movfw	R_FUNC_A4
		movwf	R_FUNC_BAK_A4
		movfw	R_FUNC_A5
		movwf	R_FUNC_BAK_A5
		
		movlw	R_FUNC_A0		; ͬһ����ַ���������� �����������Aʱ��A��ֵ����д
		movwf	FSR1
		xorwf	FSR0,w
		btfsc	STATUS,Z
		goto	F_Input_ParameterA_L2
		
		clrf	R_FUNC_A0		; ���ǵ���Щ������������6������������ĸ�������6��
		clrf	R_FUNC_A1		; ��������ĳ����������Ҫ�ȳ�ʼ��Ϊ��
		clrf	R_FUNC_A2
		clrf	R_FUNC_A3
		clrf	R_FUNC_A4
		clrf	R_FUNC_A5
		
F_Input_ParameterA_L1:
		movfw	IND0
		movwf	IND1
		incf	FSR0,f
		incf	FSR1,f
		decfsz	R_FUNC_COUNT,f
		goto	F_Input_ParameterA_L1
F_Input_ParameterA_L2:
		return


;==================================================
;		�������B����
;==================================================
;���ܣ����ڵ����ַFSR0����RAM��R_FUNC_B0~2
;	   �����WORK������������ĸ���
;	   ����˳�����δ�R_FUNC_B0��R_FUNC_B2
;���룺FSR0,WORK
;���棺R_FUNC_COUNT
;�����R_FUNC_B0~2
;==================================================
F_Input_ParameterB:
		movwf	R_FUNC_COUNT
		bcf		BSR,PAGE0	;* Ϊ��ͨ��������������������ڵ�һҳ����256��ram
		bsf		BSR,IRP0
		bcf		BSR,PAGE1	
		bsf		BSR,IRP1
		
		movlw	R_FUNC_B0		; ͬһ����ַ����������
		movwf	FSR1
		xorwf	FSR0,w
		btfsc	STATUS,Z
		goto	F_Input_ParameterB_L3
		
		movlw	R_FUNC_B0				;B�����������ַ��A�����ĵ�ַ
		subwf	FSR0,w
		btfsc	STATUS,C
		goto	F_Input_ParameterB_L1   ;û�дӲ���A��ַ����ȡ����B��ȥ������������
											
		movlw	R_FUNC_BAK_A0			;*�Բ���A�ĵ�ַ�������B�����ڲ���A�Ѿ�
		addwf	FSR0,f					;�����£�ֻ�ܴ�Ӱ�ӼĴ�����ȡ����A������
		bcf		BSR,IRP0				;Ӱ�ӼĴ����ڵ�һҳǰ��128byte����		
F_Input_ParameterB_L1:		
			
		clrf	R_FUNC_B0
		clrf	R_FUNC_B1
		clrf	R_FUNC_B2
		
F_Input_ParameterB_L2:
		movfw	IND0
		movwf	IND1
		incf	FSR0,f
		incf	FSR1,f
		decfsz	R_FUNC_COUNT,f
		goto	F_Input_ParameterB_L2
F_Input_ParameterB_L3:
		return

;==================================================
;		�������C����
;==================================================
;���ܣ����ڵ���R_FUNC_C0~5����ַFSR0����RAM,
;	   �����ĸ����ɴ����WORK����
;	   ����˳�����δ�R_FUNC_C0��R_FUNC_C5
;���룺FSR0,WORK
;���棺R_FUNC_COUNT
;�����R_FUNC_C0~5
;==================================================	
F_Output_ParameterC:
		movwf	R_FUNC_COUNT
		bcf		BSR,PAGE0	;* Ϊ��ͨ��������������������ڵ�һҳ����256��ram
		bsf		BSR,IRP0
		bcf		BSR,PAGE1	
		bsf		BSR,IRP1
		
		movlw	R_FUNC_C0
		movwf	FSR1
F_Output_ParameterC_L1:
		movfw	IND1
		movwf	IND0
		incf	FSR0,f
		incf	FSR1,f
		decfsz	R_FUNC_COUNT,f
		goto	F_Output_ParameterC_L1	
		return

;==================================================
;		Ƕ�׵��ñ��ݵ��ò�������
;==================================================
;���ܣ����ݺ������õĲ������������������Ӧ����
;	   ����80H��88H��9�����浽��Ӧ�����Ļ���R_FUNC_LX_XX
;���룺
;���棺R_FUNC_COUNT,R_FUNC_XX,R_FUNC_LX_XX
;�����
;==================================================	
F_Input_ParameterBakup:
		incf	R_FUNC_LEVEL,f		
		movlw	1
		subwf	R_FUNC_LEVEL,w
		bcf		STATUS,C
		rlf		WORK,w
		addpcw
		nop
		goto	F_Input_ParameterBakup_Exit	;һ�����ò�����
		movlw	R_FUNC_L1_A0
		goto	F_Input_ParameterBakup_L1
		movlw	R_FUNC_L2_A0
		goto	F_Input_ParameterBakup_L1
		movlw	R_FUNC_L3_A0
		goto	F_Input_ParameterBakup_L1
		movlw	R_FUNC_L4_A0
		goto	F_Input_ParameterBakup_L1
		movlw	R_FUNC_L5_A0
		goto	F_Input_ParameterBakup_L1
		movlw	R_FUNC_L6_A0
		goto	F_Input_ParameterBakup_L1
		
F_Input_ParameterBakup_L1:
		movwf	FSR1	
		movlw	R_FUNC_A0
		movwf	FSR0
		bcf		BSR,PAGE0			;��������ڵ�һҳ����256��RAM
		bsf		BSR,IRP0
		bcf		BSR,PAGE1			;���ݼĴ����ڵ�һҳǰ��128��RAM
		bcf		BSR,IRP1
		movlw	9
		movwf	R_FUNC_COUNT
F_Input_ParameterBakup_L2:
		movfw	IND0
		movwf	IND1		
		incf	FSR0,f
		incf	FSR1,f
		decfsz	R_FUNC_COUNT,f
		goto	F_Input_ParameterBakup_L2	
F_Input_ParameterBakup_Exit:		
		return

		

		
;==================================================
;		Ƕ�׵��û�ԭ���ò�������
;==================================================
;���ܣ����ݺ������õĲ�����ԭ�����������Ӧ����
;	   �ѱ��ݻ���R_FUNC_LX_XX��ԭ��80H��88H��9������
;���룺
;���棺R_FUNC_COUNT,R_FUNC_XX,R_FUNC_LX_XX
;�����
;==================================================	
F_Input_ParameterRestore:
		movlw	1
		subwf	R_FUNC_LEVEL,w
		bcf		STATUS,C
		rlf		WORK,w
		addpcw
		nop
		goto	F_Input_ParameterRestore_Exit	;һ�����ò���ԭ
		movlw	R_FUNC_L1_A0
		goto	F_Input_ParameterRestore_L1
		movlw	R_FUNC_L2_A0
		goto	F_Input_ParameterRestore_L1
		movlw	R_FUNC_L3_A0
		goto	F_Input_ParameterRestore_L1
		movlw	R_FUNC_L4_A0
		goto	F_Input_ParameterRestore_L1
		movlw	R_FUNC_L5_A0
		goto	F_Input_ParameterRestore_L1
		movlw	R_FUNC_L6_A0
		goto	F_Input_ParameterRestore_L1
F_Input_ParameterRestore_L1:
		movwf	FSR1	
		movlw	R_FUNC_A0
		movwf	FSR0
		bcf		BSR,PAGE0	
		bsf		BSR,IRP0
		bcf		BSR,PAGE1	
		bcf		BSR,IRP1
		movlw	9
		movwf	R_FUNC_COUNT
F_Input_ParameterRestore_L2:
		movfw	IND1
		movwf	IND0		
		incf	FSR0,f
		incf	FSR1,f
		decfsz	R_FUNC_COUNT,f
		goto	F_Input_ParameterRestore_L2
F_Input_ParameterRestore_Exit:
		decf	R_FUNC_LEVEL,f	
		return
	
		
		
		

