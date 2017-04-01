

;==================================================
;		MAP OF RAM
;==================================================
R_AD_SEG_S			 equ  R_RAM_ALC_AD_S
; F_Get_Adc & F_Get_Fast_Adc 
R_AD_FLAG			 equ  R_AD_SEG_S+0		 ;AD标志位
R_AD_SUM_TIMES		 equ  R_AD_SEG_S+1		 ;累计求和次数
R_AD_SUM_BUF_LL		 equ  R_AD_SEG_S+2		 ;32位AD求和缓存bit7~0
R_AD_SUM_BUF_LH		 equ  R_AD_SEG_S+3		 ;32位AD求和缓存bit15~8
R_AD_SUM_BUF_HL		 equ  R_AD_SEG_S+4		 ;32位AD求和缓存bit23~16
R_AD_SUM_BUF_HH		 equ  R_AD_SEG_S+5		 ;32位AD求和缓存bit31~24
; public	用完就释放，嵌套的函数没有用到
R_AD_TempL			 equ  R_AD_SEG_S+6		 ;缓存
R_AD_TempM			 equ  R_AD_SEG_S+7		 ;缓存
R_AD_TempH			 equ  R_AD_SEG_S+8
R_AD_Count			 equ  R_AD_SEG_S+9		 ;缓存

R_AD_Run_ZeroL		 equ  R_AD_SEG_S+10		 ;运行零点值低8位
R_AD_Run_ZeroH		 equ  R_AD_SEG_S+11		 ;运行零点值高8位

R_AD_Pow_ZeroL		 equ  R_AD_SEG_S+12		 ;运行零点值低8位
R_AD_Pow_ZeroH		 equ  R_AD_SEG_S+13		 ;运行零点值高8位

; F_Adc_Filter 专用变量 total: 20
R_F_Adc_Filter_S	 equ  R_AD_SEG_S+14
R_F_Adc_Filter_E	 equ  R_AD_SEG_S+33		 ;滑动滤波缓存8高8位


;==================================================
;		上电零点设置函数
;==================================================
;功能：把输入参数设置为上电零点
;输入：
;缓存：
;输出：
;==================================================
F_SetPowerOnZero:
		movfw	R_SYS_A0
		movwf	R_AD_Pow_ZeroL	
		movfw	R_SYS_A1
		movwf	R_AD_Pow_ZeroH	
		return

;==================================================
;		正常零点设置函数
;==================================================
;功能：把输入参数设置为当前零点
;输入：
;缓存：
;输出：
;==================================================
F_SetRunZero:
		movfw	R_SYS_A0
		movwf	R_AD_Run_ZeroL	
		movfw	R_SYS_A1
		movwf	R_AD_Run_ZeroH	
		return

		
;==================================================
;		零点处理函数
;==================================================
;功能：把输入参数设置为当前零点
;输入：
;缓存：
;输出：
;==================================================

		


;==================================================
;		计算相对零点的AD变化量函数
;==================================================
;功能：计算当前AD内码和零点AD内码的差值
;输入：
;缓存：
;输出：
;==================================================
; INPUT	
R_AD_OriIn_L		 equ  R_SYS_A0					 ;原始的AD值低8位
R_AD_OriIn_H		 equ  R_SYS_A1					 ;原始的AD值高8位
; OUTPUT
R_AD_Delta_L		 equ  R_SYS_C0					 ;滤波后的AD值低8位
R_AD_Delta_H		 equ  R_SYS_C1					 ;滤波后的AD值高8位
B_AD_Delta_POS		 equ  1
; public
;R_AD_Run_ZeroL		 equ  R_AD_SEG_S+9		 ;运行零点值低8位
;R_AD_Run_ZeroH		 equ  R_AD_SEG_S+10		 ;运行零点值高8位

F_GetDeltaAD:	
		fcall2	F_ABS_24,R_AD_OriIn_L,2,R_AD_Run_ZeroL,2,R_AD_Delta_L,2
		btfss	R_SYS_RET,0
		goto	$+3
		bsf		R_AD_FLAG,B_AD_Delta_POS
		goto	$+2
		bcf		R_AD_FLAG,B_AD_Delta_POS		
		return


;==================================================
;		滑动平均滤波函数
;==================================================
;功能：1阶8级滑动平均滤波,返回滤波值和滤波次数
;输入：R_AD_BufNow_L,R_AD_BufNow_H
;缓存：
;输出：R_AD_BufFil_L,R_AD_BufFil_H
;==================================================
; CONSTANT
;DEF_XXX			 equ  4							 ;常量参数
; INPUT	
R_AD_BufNow_L		 equ  R_SYS_A0					 ;要进行滤波的AD值低8位
R_AD_BufNow_H		 equ  R_SYS_A1					 ;要进行滤波的AD值高8位
; OUTPUT
R_AD_BufFil_L		 equ  R_SYS_C0					 ;滤波后的AD值低8位
R_AD_BufFil_H		 equ  R_SYS_C1					 ;滤波后的AD值高8位
R_AD_BufFil_RET		 equ  R_SYS_RET					 ;返回值
; PRIVATE
R_AD_FilTimes		 equ  R_F_Adc_Filter_S+0		 ;滑动滤波次数变量
R_AD_FilRange		 equ  R_F_Adc_Filter_S+1		 ;滑动平均滤波范围
R_AD_BufOld_L		 equ  R_F_Adc_Filter_S+2		 ;上一笔滤波数据低8位
R_AD_BufOld_H		 equ  R_F_Adc_Filter_S+3		 ;上一笔滤波数据高8位
R_AD_FilBuf1_L		 equ  R_F_Adc_Filter_S+4		 ;滑动滤波缓存1低8位
R_AD_FilBuf1_H		 equ  R_F_Adc_Filter_S+5		 ;滑动滤波缓存1高8位
R_AD_FilBuf2_L		 equ  R_F_Adc_Filter_S+6		 ;滑动滤波缓存2低8位
R_AD_FilBuf2_H		 equ  R_F_Adc_Filter_S+7		 ;滑动滤波缓存2高8位
R_AD_FilBuf3_L		 equ  R_F_Adc_Filter_S+8		 ;滑动滤波缓存3低8位
R_AD_FilBuf3_H		 equ  R_F_Adc_Filter_S+9		 ;滑动滤波缓存3高8位
R_AD_FilBuf4_L		 equ  R_F_Adc_Filter_S+10		 ;滑动滤波缓存4低8位
R_AD_FilBuf4_H		 equ  R_F_Adc_Filter_S+11		 ;滑动滤波缓存4高8位

R_AD_FilBuf5_L		 equ  R_F_Adc_Filter_S+12		 ;滑动滤波缓存5低8位
R_AD_FilBuf5_H		 equ  R_F_Adc_Filter_S+13		 ;滑动滤波缓存5高8位
R_AD_FilBuf6_L		 equ  R_F_Adc_Filter_S+14		 ;滑动滤波缓存6低8位
R_AD_FilBuf6_H		 equ  R_F_Adc_Filter_S+15		 ;滑动滤波缓存6高8位
R_AD_FilBuf7_L		 equ  R_F_Adc_Filter_S+16		 ;滑动滤波缓存7低8位
R_AD_FilBuf7_H		 equ  R_F_Adc_Filter_S+17		 ;滑动滤波缓存7高8位
R_AD_FilBuf8_L		 equ  R_F_Adc_Filter_S+18		 ;滑动滤波缓存8低8位
R_AD_FilBuf8_H		 equ  R_F_Adc_Filter_S+19		 ;滑动滤波缓存8高8位
; PUBLIC

F_AD_SetFilRange:
		movfw	R_SYS_A0
		movwf	R_AD_FilRange
		return	

F_Adc_Filter:
		fcall2	F_ABS_24,R_AD_BufNow_L,2,R_AD_BufOld_L,2,R_AD_TempL,2
		movfw	R_AD_FilRange
		subwf	R_AD_TempL,w
		movlw	00h
		subwfc	R_AD_TempH,w
				
		movfw	R_AD_BufNow_L
		movwf	R_AD_BufOld_L
		movfw	R_AD_BufNow_H
		movwf	R_AD_BufOld_H
		
		btfss	STATUS,C
		goto	F_Adc_Filter_L1
		
		call	F_AD_ClrFilBuf
		clrf	R_AD_FilTimes		
		goto	F_Adc_Filter_Exit
		
F_Adc_Filter_L1:
		movlw	ffh					;达到最大值，不再增加
		subwf	R_AD_FilTimes,w
		btfsc	STATUS,C
		decf	R_AD_FilTimes,f
	    incf	R_AD_FilTimes,f	
	    
		movlw	09h					;R_AD_FilTimes>=9 9->work
		subwf	R_AD_FilTimes,w		;R_AD_FilTimes<9  R_AD_FilTimes->work
		btfss	STATUS,C
		goto	$+3
		movlw	09h
		goto	$+2
		movfw	R_AD_FilTimes
		
		addpcw	
		nop		
		goto	F_Adc_Filter_Load1
		goto	F_Adc_Filter_Load2
		goto	F_Adc_Filter_Load3
		goto	F_Adc_Filter_Load4
		
		goto	F_Adc_Filter_Load5
		goto	F_Adc_Filter_Load6
		goto	F_Adc_Filter_Load7
		goto	F_Adc_Filter_Load8
		
		goto	F_Adc_Filter_Load9
F_Adc_Filter_Load1:
		movfw	R_AD_BufNow_L
		movwf	R_AD_FilBuf1_L
		movfw	R_AD_BufNow_H
		movwf	R_AD_FilBuf1_H	
F_Adc_Filter_Load2:
		movfw	R_AD_BufNow_L
		movwf	R_AD_FilBuf2_L
		movfw	R_AD_BufNow_H
		movwf	R_AD_FilBuf2_H		
F_Adc_Filter_Load3:
		movfw	R_AD_BufNow_L
		movwf	R_AD_FilBuf3_L
		movfw	R_AD_BufNow_H
		movwf	R_AD_FilBuf3_H		
F_Adc_Filter_Load4:
		movfw	R_AD_BufNow_L
		movwf	R_AD_FilBuf4_L
		movfw	R_AD_BufNow_H
		movwf	R_AD_FilBuf4_H			
F_Adc_Filter_Load5:
		movfw	R_AD_BufNow_L
		movwf	R_AD_FilBuf5_L
		movfw	R_AD_BufNow_H
		movwf	R_AD_FilBuf5_H
F_Adc_Filter_Load6:
		movfw	R_AD_BufNow_L
		movwf	R_AD_FilBuf6_L
		movfw	R_AD_BufNow_H
		movwf	R_AD_FilBuf6_H
F_Adc_Filter_Load7:
		movfw	R_AD_BufNow_L
		movwf	R_AD_FilBuf7_L
		movfw	R_AD_BufNow_H
		movwf	R_AD_FilBuf7_H		
F_Adc_Filter_Load8:
		movfw	R_AD_BufNow_L
		movwf	R_AD_FilBuf8_L
		movfw	R_AD_BufNow_H
		movwf	R_AD_FilBuf8_H
		goto	F_Adc_Filter_SUMandAVG
F_Adc_Filter_Load9:
		movfw	R_AD_FilBuf2_L
		movwf	R_AD_FilBuf1_L
		movfw	R_AD_FilBuf2_H
		movwf	R_AD_FilBuf1_H
		
		movfw	R_AD_FilBuf3_L
		movwf	R_AD_FilBuf2_L
		movfw	R_AD_FilBuf3_H
		movwf	R_AD_FilBuf2_H
		
		movfw	R_AD_FilBuf4_L
		movwf	R_AD_FilBuf3_L
		movfw	R_AD_FilBuf4_H
		movwf	R_AD_FilBuf3_H
		
		movfw	R_AD_FilBuf5_L
		movwf	R_AD_FilBuf4_L
		movfw	R_AD_FilBuf5_H
		movwf	R_AD_FilBuf4_H
		
		movfw	R_AD_FilBuf6_L
		movwf	R_AD_FilBuf5_L
		movfw	R_AD_FilBuf6_H
		movwf	R_AD_FilBuf5_H
		
		movfw	R_AD_FilBuf7_L
		movwf	R_AD_FilBuf6_L
		movfw	R_AD_FilBuf7_H
		movwf	R_AD_FilBuf6_H
		
		movfw	R_AD_FilBuf8_L
		movwf	R_AD_FilBuf7_L
		movfw	R_AD_FilBuf8_H
		movwf	R_AD_FilBuf7_H
		
		movfw	R_AD_BufNow_L
		movwf	R_AD_FilBuf8_L
		movfw	R_AD_BufNow_H
		movwf	R_AD_FilBuf8_H
		
F_Adc_Filter_SUMandAVG:
		call	F_AD_SUMandAVG
		movfw	R_AD_TempL
		movwf	R_AD_BufOld_L
		movfw	R_AD_TempM
		movwf	R_AD_BufOld_H	
F_Adc_Filter_Exit:
		movfw	R_AD_BufOld_L
		movwf	R_AD_BufFil_L
		movfw	R_AD_BufOld_H
		movwf	R_AD_BufFil_H
		movfw	R_AD_FilTimes
		movwf	R_AD_BufFil_RET
		return
			
		

;-------------------------	
;  滤波缓存求和取平均子函数 
;-------------------------	
F_AD_SUMandAVG:
		clrf	R_AD_TempL
		clrf	R_AD_TempM
		clrf	R_AD_TempH
		
		bcf		BSR,PAGE0	
		bsf		BSR,IRP0
		movlw	R_AD_FilBuf1_L
		movwf	FSR0
		
		movlw	8
		movwf	R_AD_Count
F_AD_SUM_L1:
		movfw	IND0
		addwf	R_AD_TempL,f
		incf	FSR0,f
		
		movfw	IND0
		addwfc	R_AD_TempM,f
		movlw	00h
		addwfc	R_AD_TempH,f
		incf	FSR0,f
		
		decfsz	R_AD_Count,f
		goto	F_AD_SUM_L1
		
		bcf		STATUS,C
		rrf		R_AD_TempH,f
		rrf		R_AD_TempM,f
		rrf		R_AD_TempL,f
		
		bcf		STATUS,C
		rrf		R_AD_TempH,f
		rrf		R_AD_TempM,f
		rrf		R_AD_TempL,f
		
		bcf		STATUS,C
		rrf		R_AD_TempH,f
		rrf		R_AD_TempM,f
		rrf		R_AD_TempL,f
		return
		
;-------------------------	
;  清缓存子函数 
;-------------------------		
F_AD_ClrFilBuf:
		bcf		BSR,PAGE0	
		bsf		BSR,IRP0
		movlw	R_AD_FilBuf1_L
		movwf	FSR0
		movlw	16
		movwf	R_AD_Count
F_AD_ClrFilBuf_L1:
		clrf	IND0
		decfsz	R_AD_Count,f
		goto	F_AD_ClrFilBuf_L1
		return


		
		

;==================================================
;		AD采集函数
;==================================================
;功能：将AD加一个偏移后累加求平均然后截取中间
;	   16bit输出
;输入：R_AD_OriginalX(L,M,H)
;缓存：R_AD_SUM_BUF_XX(LL,LH,HL,HH),R_AD_SUM_TIMES
;输出：R_AD_Avg_OutX(L,H),B_AD_GetOne
;==================================================
; CONSTANT
DEF_SumTimes		 equ  4				 ;AD累加笔数 (方便计算取2的指数倍)	
DEF_AdShiftL		 equ  00h			 ;AD偏移量bit7~0
DEF_AdShiftM		 equ  00h			 ;AD偏移量bit15~8
DEF_AdShiftH		 equ  10h			 ;AD偏移量bit23~16
; INPUT
R_AD_OriginalL		 equ  R_SYS_A0		 ;原始AD值低8位
R_AD_OriginalM		 equ  R_SYS_A1		 ;原始AD值中8位
R_AD_OriginalH		 equ  R_SYS_A2		 ;原始AD值高8位
; OUTPUT
R_AD_Avg_OutL		 equ  R_SYS_C0		 ;原始AD加了偏移累加求平均后的输出bit13~6
R_AD_Avg_OutH		 equ  R_SYS_C1		 ;原始AD加了偏移累加求平均后的输出bit21~14
B_AD_GetOne			 equ  0				 ;完成一次求和平均后函数返回值最低位置1
; PRIVATE


F_Get_Adc:
		bcf		R_AD_FLAG,B_AD_GetOne
	 ;-------------------------	
	 ;  AD加上DEF_AdShift偏移值 
     ;-------------------------
		movlw   DEF_AdShiftL    		        
	    addwf   R_AD_OriginalL,f 
	    movlw   DEF_AdShiftM
	    addwfc  R_AD_OriginalM,f
	    movlw   DEF_AdShiftH
	    addwfc  R_AD_OriginalH,f
	 ;-------------------------
	 ;  取R_AD_Originalx累加 
     ;-------------------------
	    movfw	R_AD_OriginalL
	    addwf	R_AD_SUM_BUF_LL,f
	    movfw	R_AD_OriginalM
	    addwfc	R_AD_SUM_BUF_LH,f
	    movfw	R_AD_OriginalH
	    addwfc	R_AD_SUM_BUF_HL,f
	    movlw	0
	    addwfc	R_AD_SUM_BUF_HH,f	    
	    	      
	    incf	R_AD_SUM_TIMES,f
	    movlw	DEF_SumTimes
	    subwf	R_AD_SUM_TIMES,w
	    btfss	STATUS,C
	    goto	F_Get_Adc_Exit	 	
	 ;-------------------------	
	 ;  截取求和缓存的中间16位输出 
     ;-------------------------
	    ;  注*在R_AD_SUM_TIMES为4即累加为4次时取中间
	    ;  16位输出，即取的是R_AD_Originalx的bit21~6
        ;-------------------------  
	    movfw	R_AD_SUM_BUF_LH
	 	movwf	R_AD_Avg_OutL	
	    movfw	R_AD_SUM_BUF_HL
	 	movwf	R_AD_Avg_OutH	
	 	
	 	bsf		R_AD_FLAG,B_AD_GetOne
	 	clrf	R_AD_SUM_TIMES
	 	clrf	R_AD_SUM_BUF_LL
	 	clrf	R_AD_SUM_BUF_LH
	 	clrf	R_AD_SUM_BUF_HL
	 	clrf	R_AD_SUM_BUF_HH	    	
F_Get_Adc_Exit:	
		movfw	R_AD_FLAG
		movwf	R_SYS_RET
		return


			

;==================================================
;		高速AD采集函数
;==================================================
;功能：将AD加一个偏移后累加求平均然后截取中间
;	   16bit输出(程序会进入halt等处理完成)
;输入：B_AD_GetOne,R_AD_OriginalX(L,M,H)
;缓存：R_AD_SUM_BUF_XX(LL,LH,HL,HH),R_AD_SUM_TIMES
;输出：R_AD_Avg_OutX(L,H)
;==================================================		
		
F_Get_Fast_Adc:
	 	bcf		ADCON,ADM_2
	 	bcf		ADCON,ADM_1
		bsf		ADCON,ADM_0		;Bit2~0	 ADM[2:0]	降采样速率（输出速率）
								;001： 1953Hz
		clrf	R_AD_SUM_TIMES
	 	clrf	R_AD_SUM_BUF_LL
	 	clrf	R_AD_SUM_BUF_LH
	 	clrf	R_AD_SUM_BUF_HL
	 	clrf	R_AD_SUM_BUF_HH	
		bsf		INTE,ADIE
        bsf     INTE,GIE
F_Get_Fast_Adc_L1:
		bcf		R_AD_FLAG,B_AD_GetOne
F_Get_Fast_Adc_L2:
		halt
	    nop
		nop
		btfss	 R_AD_FLAG,B_AD_GetOne
		goto	 F_Get_Fast_Adc_L2
		incf	 R_AD_SUM_TIMES,f
		movlw    04h		
		subwf    R_AD_SUM_TIMES,w
		btfss    STATUS,C
        goto	 F_Get_Fast_Adc_L1		;抛弃前面3笔数据
		
	 ;-------------------------	
	 ;  AD加上DEF_AdShift偏移值 
     ;-------------------------
		movlw   DEF_AdShiftL    		        
	    addwf   R_AD_OriginalL,f 
	    movlw   DEF_AdShiftM
	    addwfc  R_AD_OriginalM,f
	    movlw   DEF_AdShiftH
	    addwfc  R_AD_OriginalH,f	 
	 ;-------------------------
	 ;  取R_AD_Originalx累加 
     ;-------------------------
	    movfw	R_AD_OriginalL
	    addwf	R_AD_SUM_BUF_LL,f
	    movfw	R_AD_OriginalM
	    addwfc	R_AD_SUM_BUF_LH,f
	    movlw	R_AD_OriginalH
	    addwfc	R_AD_SUM_BUF_HL,f
	    movlw	0
	    addwfc	R_AD_SUM_BUF_HH,f	    
	    
	    movlw	05h						;5-3=2累加两笔数据
	    subwf	R_AD_SUM_TIMES,w
	    btfss   STATUS,C
	    goto	F_Get_Fast_Adc_L1
	    
	    bcf		INTE,ADIE
	    bcf		INTF,ADIF
	    bcf		INTE,GIE
	    
	 ;-------------------------
	 ;  缓存左移1位 
     ;-------------------------
	 	bcf		STATUS,C				
	    rlf		R_AD_SUM_BUF_LL,f
	    rlf		R_AD_SUM_BUF_LH,f
	    rlf		R_AD_SUM_BUF_HL,f    	    
	    rlf		R_AD_SUM_BUF_HH,f	
	    							;累加了两笔，左移一位再取缓存的
	    							;中间16位实际是取原始AD
									;的bit21~6这中间的16位
	    movfw	R_AD_SUM_BUF_LH
	 	movwf	R_AD_Avg_OutL	
	    movfw	R_AD_SUM_BUF_HL
	 	movwf	R_AD_Avg_OutH
	 	
F_Get_Fast_Adc_Exit:
		return

	
	
		