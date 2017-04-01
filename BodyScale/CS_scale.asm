;**************************************************	
;				上电开机流程
;**************************************************	
L_POWERON_PROC:
		
		;fcall0	F_delay_1mclk,2,0	
	
		call	F_Init_SOC
	 ;-------------------------	
	 ;  称重参数初始化
     ;-------------------------	
	 	fcall0	F_AD_SetFilRange,15,0 
	 	movlw	LOW DEF_SYS_CALIDOT1
	 	movwf	R_SYS_CalDot1L
	 	movlw	HIGH DEF_SYS_CALIDOT1
	 	movwf	R_SYS_CalDot1H
	 	
	 	movlw	LOW DEF_SYS_CALIDOT2
	 	movwf	R_SYS_CalDot2L
	 	movlw	HIGH DEF_SYS_CALIDOT2
	 	movwf	R_SYS_CalDot2H
	 	
	 	movlw	LOW DEF_SYS_CALIDOT3
	 	movwf	R_SYS_CalDot3L
	 	movlw	HIGH DEF_SYS_CALIDOT3
	 	movwf	R_SYS_CalDot3H
		
	 ;-------------------------	
	 ;  开机全显 
     ;-------------------------
		bcf		R_AD_FLAG,B_AD_GetOne
			
	 ;-------------------------	
	 ;  开机取零点 
     ;-------------------------	
L_POWERON_PROC_GetZero:	
		movlw	30
		movwf	R_SYS_Count
L_POWERON_PROC_GetZero_L1:		
	 	btfss	R_INT_AD_FLAG,B_GetAdc
		goto	L_POWERON_PROC_GetZero_L1
		bcf		R_INT_AD_FLAG,B_GetAdc
		
		fcall1  F_Get_Adc,R_INT_AdL,3,R_SYS_ADbufL,2
		btfss	R_SYS_RET,0
		goto	L_POWERON_PROC_GetZero_L1
		
		decfsz	R_SYS_Count,f		;超时处理
		goto	L_POWERON_PROC_GetZero_L2
		goto	L_POWERON_PROC_GetZero_default
		
L_POWERON_PROC_GetZero_L2:		
		fcall1	F_Adc_Filter,R_SYS_ADbufL,2,R_SYS_ADbufL,2		
		movlw	6					;连续进入滑动滤波6次表示数据稳定
		subwf	R_SYS_RET,w			;函数返回的是滑动平均滤波的次数
		btfss	STATUS,C
		goto	L_POWERON_PROC_GetZero_L1
		
		fcall	F_SetPowerOnZero,R_SYS_ADbufL,2
		fcall	F_SetRunZero,R_SYS_ADbufL,2
		goto	L_POWERON_PROC_GetZero_Exit
L_POWERON_PROC_GetZero_default:
		fcall	F_SetPowerOnZero,R_SYS_ADbufL,2
		fcall	F_SetRunZero,R_SYS_ADbufL,2		
L_POWERON_PROC_GetZero_Exit:			
L_POWERON_PROC_E:
		goto	Main

		
		

		
;**************************************************	
;				锁定流程
;**************************************************	
L_SCALELOCK_PROC:
		
		
		

	
	
L_SCALELOCK_PROC_E:		
		goto	Main	
	
	
	
		
	
	
	
	