;============================================
; filename: CST34M97.asm
; chip    : CST34M97
; author  :
; date    : 2016-11-08
;============================================
		include CST34M97.inc
		include BleStack97.inc
		include blerec.inc
		include	def.inc
		include led_mapping_user.inc
		include	CS_function_io.inc
;============================================
; program start
;============================================
		org	    000h
   	 	dw		ffffh
    	dw		ffffh
    	goto    Main_Start
    	goto    Main_Start
    	org     004h
    	btfss   CS_Flag,CS_BleSuccess
    	goto    RFINT
    	goto    INT_All
;============================================
; main loop
;============================================   
Main_Start:	
		goto	L_POWERON_PROC		
Main:	
		call	SendUUID
		call	SendBleName	
		
Main_Loop:	
		btfss	R_INT_AD_FLAG,B_GetAdc
		goto	Main_Loop
		bcf		R_INT_AD_FLAG,B_GetAdc
		
		fcall1  F_Get_Adc,R_INT_AdL,3,R_SYS_ADbufL,2
		btfss	R_SYS_RET,0
		goto	Main_Loop
		
		fcall1	F_GetDeltaAD,R_SYS_ADbufL,2,R_SYS_ADbufL,2
		
		fcall1	F_Adc_Filter,R_SYS_ADbufL,2,R_SYS_ADbufL,2
		
		fcall2  F_GetWeight,R_SYS_CalDot1L,6,R_SYS_ADbufL,2,R_SYS_ADbufL,2  
		
		fcall	F_JudgeWeight_Steady,R_SYS_ADbufL,2
		bcf		R_LED_BUFFER5,2
		bcf		R_LED_BUFFER5,3
		bcf		R_LED_BUFFER5,4
		;btfsc	R_SYS_RET,0
		;bsf		R_LED_BUFFER5,3
		btfss	R_SYS_RET,1
		goto	Main_Loop_L1
		bsf		R_LED_BUFFER5,2		;显示蓝牙符号
		call	SendBleData	
			
Main_Loop_L1:		
		fcall1	F_Hex2BCD,R_SYS_ADbufL,2,R_TEMP1,4
		
		
		movfw	R_TEMP3
		andlw	0fh
		call	F_Dsp_Table
		movwf	R_LED_BUFFER1
		
		swapf	R_TEMP2,w
		andlw	0fh
		call	F_Dsp_Table
		movwf	R_LED_BUFFER2
		
		movfw	R_TEMP2
		andlw	0fh
		call	F_Dsp_Table
		movwf	R_LED_BUFFER3
		
		swapf	R_TEMP1,w
		andlw	0fh
		call	F_Dsp_Table
		movwf	R_LED_BUFFER4
		
		bsf		R_LED_BUFFER5,0	
		bsf		R_LED_BUFFER5,5
		
		call	F_LED_REFRESH
	
		goto	Main_Loop	
DataTest:                        
		movlw   100
		call    cs_delay_1ms
		call    SendBleData                          ;发送数据
		movlw   100
		call    cs_delay_1ms
		btfsc   BLES,TS
		incf    Num,1
		bcf     BLES,TS
		call    QueryBleState
    	goto    DataTest
         	

		include Ble_Stack.asm
		include ble_api.asm
		include CS_function_io.asm
		include CS_interrupt.asm
		include	CS_led_mapping.asm
		include	CS_led_app.asm
		include	CS_math.asm
		include	CS_initial.asm
		include	CS_ad.asm
		include CS_scale.asm
		include CS_weight.asm
		include CS_time.asm
		include CS_1180_com.asm

		end
;============================================