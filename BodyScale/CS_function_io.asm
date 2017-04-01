
;==================================================
;		输入参数A函数
;==================================================
;功能：用于导入地址FSR0处的RAM到R_FUNC_A0~5
;	   传入的WORK参数决定导入的个数
;	   导入顺序依次从R_FUNC_A0到R_FUNC_A5
;输入：FSR0,WORK
;缓存：R_FUNC_COUNT
;输出：R_FUNC_A0~5
;==================================================
F_Input_ParameterA:
		movwf	R_FUNC_COUNT
		bcf		BSR,PAGE0	
		bsf		BSR,IRP0
		bcf		BSR,PAGE1		;* 为了通用性输入输出参数限制在第一页后面256的ram
		bsf		BSR,IRP1
		
		movfw	R_FUNC_A0		; 备份A0到A5的数据，用于参数B调用A的原始参数
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
		
		movlw	R_FUNC_A0		; 同一个地址不更新数据 解决函数调用A时，A的值被改写
		movwf	FSR1
		xorwf	FSR0,w
		btfsc	STATUS,Z
		goto	F_Input_ParameterA_L2
		
		clrf	R_FUNC_A0		; 考虑到有些函数参数就有6个但是输入给的个数不够6个
		clrf	R_FUNC_A1		; 带来运算的出错，输入参数要先初始化为零
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
;		输入参数B函数
;==================================================
;功能：用于导入地址FSR0处的RAM到R_FUNC_B0~2
;	   传入的WORK参数决定导入的个数
;	   导入顺序依次从R_FUNC_B0到R_FUNC_B2
;输入：FSR0,WORK
;缓存：R_FUNC_COUNT
;输出：R_FUNC_B0~2
;==================================================
F_Input_ParameterB:
		movwf	R_FUNC_COUNT
		bcf		BSR,PAGE0	;* 为了通用性输入输出参数限制在第一页后面256的ram
		bsf		BSR,IRP0
		bcf		BSR,PAGE1	
		bsf		BSR,IRP1
		
		movlw	R_FUNC_B0		; 同一个地址不跟新数据
		movwf	FSR1
		xorwf	FSR0,w
		btfsc	STATUS,Z
		goto	F_Input_ParameterB_L3
		
		movlw	R_FUNC_B0				;B参数的输入地址是A参数的地址
		subwf	FSR0,w
		btfsc	STATUS,C
		goto	F_Input_ParameterB_L1   ;没有从参数A地址处获取参数B跳去正常参数导入
											
		movlw	R_FUNC_BAK_A0			;*以参数A的地址导入参数B，由于参数A已经
		addwf	FSR0,f					;被更新，只能从影子寄存器获取参数A的数据
		bcf		BSR,IRP0				;影子寄存器在第一页前面128byte里面		
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
;		输出参数C函数
;==================================================
;功能：用于导出R_FUNC_C0~5到地址FSR0处的RAM,
;	   导出的个数由传入的WORK决定
;	   导出顺序依次从R_FUNC_C0到R_FUNC_C5
;输入：FSR0,WORK
;缓存：R_FUNC_COUNT
;输出：R_FUNC_C0~5
;==================================================	
F_Output_ParameterC:
		movwf	R_FUNC_COUNT
		bcf		BSR,PAGE0	;* 为了通用性输入输出参数限制在第一页后面256的ram
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
;		嵌套调用备份调用参数函数
;==================================================
;功能：根据函数调用的层数备份输入参数到相应缓存
;	   备份80H到88H这9个缓存到对应层数的缓存R_FUNC_LX_XX
;输入：
;缓存：R_FUNC_COUNT,R_FUNC_XX,R_FUNC_LX_XX
;输出：
;==================================================	
F_Input_ParameterBakup:
		incf	R_FUNC_LEVEL,f		
		movlw	1
		subwf	R_FUNC_LEVEL,w
		bcf		STATUS,C
		rlf		WORK,w
		addpcw
		nop
		goto	F_Input_ParameterBakup_Exit	;一级调用不备份
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
		bcf		BSR,PAGE0			;输入参数在第一页后面256的RAM
		bsf		BSR,IRP0
		bcf		BSR,PAGE1			;备份寄存器在第一页前面128的RAM
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
;		嵌套调用还原调用参数函数
;==================================================
;功能：根据函数调用的层数还原输入参数到相应缓存
;	   把备份缓存R_FUNC_LX_XX还原到80H到88H这9个缓存
;输入：
;缓存：R_FUNC_COUNT,R_FUNC_XX,R_FUNC_LX_XX
;输出：
;==================================================	
F_Input_ParameterRestore:
		movlw	1
		subwf	R_FUNC_LEVEL,w
		bcf		STATUS,C
		rlf		WORK,w
		addpcw
		nop
		goto	F_Input_ParameterRestore_Exit	;一级调用不还原
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
	
		
		
		

