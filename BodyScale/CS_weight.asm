
;==================================================
;		MAP OF RAM
;==================================================
R_WT_SEG_S			 equ  R_RAM_ALC_WT_S	 ;系统分配的RAM初始地址
; public
R_WT_TempL			 equ  R_WT_SEG_S+0		 ;缓存低8位
R_WT_TempH			 equ  R_WT_SEG_S+1		 ;缓存高8位
; private
; F_GetWeight
; NONE
; F_JudgeWeight_Steady
R_F_JudgeWeight_Steady_S  equ   R_WT_SEG_S+2
R_F_JudgeWeight_Steady_E  equ	R_WT_SEG_S+5
	

;==================================================
;		计算重量函数
;==================================================
;功能：计算当前重量
;输入：
;缓存：
;输出：
;==================================================
; CONSTANT
DEF_CALIDOT1		 equ  5000				 ;第一段标定点对应重量变化50.00kg
DEF_CALIDOT2		 equ  5000				 ;第二段标定点对应重量变化50.00kg
DEF_CALIDOT1a2		 equ  10000				 ;第一、二段标定点合起来的重量变化100.00kg
DEF_CALIDOT3		 equ  5000				 ;第三段标定点对应重量变化50.00kg
; INPUT	
R_WT_CaliDot1_L		 equ  R_SYS_A0			 ;第一段标定点AD内码低8位
R_WT_CaliDot1_H		 equ  R_SYS_A1			 ;第一段标定点AD内码高8位
R_WT_CaliDot2_L		 equ  R_SYS_A2			 ;第二段标定点AD内码低8位
R_WT_CaliDot2_H		 equ  R_SYS_A3			 ;第二段标定点AD内码高8位
R_WT_CaliDot3_L		 equ  R_SYS_A4			 ;第三段标定点AD内码低8位
R_WT_CaliDot3_H		 equ  R_SYS_A5			 ;第三段标定点AD内码高8位
R_WT_AD_L			 equ  R_SYS_B0			 ;输入的AD内码低8位
R_WT_AD_H			 equ  R_SYS_B1			 ;输入的AD内码高8位
; OUTPUT
R_WT_GetWeight_L		 equ  R_SYS_C0			 ;重量值（kg）低8位
R_WT_GetWeight_H		 equ  R_SYS_C1			 ;重量值（kg）高8位
; private
; NONE

; public
;R_WT_TempL			 equ  R_WT_SEG_S+0		 ;缓存低8位
;R_WT_TempH			 equ  R_WT_SEG_S+1		 ;缓存高8位

F_GetWeight:
		fcall2	F_ABS_24,R_WT_AD_L,2,R_WT_CaliDot1_L,2,R_WT_TempL,2	
		btfss	R_SYS_RET,0
		goto	F_GetWeight_Dot1	;R_WT_AD_L < R_WT_CaliDot1_L
		
		fcall2	F_ABS_24,R_WT_TempL,2,R_WT_CaliDot2_L,2,R_SYS_C0,2
		btfss	R_SYS_RET,0	
		goto	F_GetWeight_Dot2	;R_WT_CaliDot1_L <= R_WT_AD_L < R_WT_CaliDot2_L
		goto	F_GetWeight_Dot3	;R_WT_CaliDot2_L <= R_WT_AD_L 
F_GetWeight_Dot1:
		movlw	LOW DEF_CALIDOT1
		movwf	R_WT_TempL
		movlw	HIGH DEF_CALIDOT1
		movwf	R_WT_TempH
		fcall2	F_Mul24U,R_WT_AD_L,2,R_WT_TempL,2,R_SYS_C0,4
		fcall2  F_Div24U,R_SYS_C0,4,R_WT_CaliDot1_L,2,R_WT_GetWeight_L,2
		goto	F_GetWeight_Exit		

F_GetWeight_Dot2:
		movfw	R_WT_TempL
		movwf	R_WT_AD_L
		movfw	R_WT_TempH
		movwf	R_WT_AD_H
		
		movlw	LOW DEF_CALIDOT2
		movwf	R_WT_TempL
		movlw	HIGH DEF_CALIDOT2
		movwf	R_WT_TempH
		fcall2	F_Mul24U,R_WT_AD_L,2,R_WT_TempL,2,R_SYS_C0,4
		fcall2  F_Div24U,R_SYS_C0,4,R_WT_CaliDot2_L,2,R_WT_GetWeight_L,2
		
		movlw	LOW DEF_CALIDOT1
		addwf	R_WT_GetWeight_L,f
		movlw	HIGH DEF_CALIDOT1
		addwfc	R_WT_GetWeight_H,f
		
		goto	F_GetWeight_Exit
F_GetWeight_Dot3:
		movfw	R_SYS_C0
		movwf	R_WT_AD_L
		movfw	R_SYS_C1
		movwf	R_WT_AD_H
		
		movlw	LOW DEF_CALIDOT3
		movwf	R_WT_TempL
		movlw	HIGH DEF_CALIDOT3
		movwf	R_WT_TempH
		fcall2	F_Mul24U,R_WT_AD_L,2,R_WT_TempL,2,R_SYS_C0,4
		fcall2  F_Div24U,R_SYS_C0,4,R_WT_CaliDot3_L,2,R_WT_GetWeight_L,2
		
		movlw	LOW DEF_CALIDOT1a2
		addwf	R_WT_GetWeight_L,f
		movlw	HIGH DEF_CALIDOT1a2
		addwfc	R_WT_GetWeight_H,f		
F_GetWeight_Exit:	
		return
	




;==================================================
;		判稳处理函数
;==================================================
;功能：判断当前重量是否稳定
;输入：
;缓存：
;输出：
;==================================================
; CONSTANT
DEF_SameWeightRange	 equ  10				 ;判断是同一个重量的范围（单位为10g）	
DEF_SteadyTimes		 equ  6					 ;判断稳定的次数
DEF_MinLockWeight	 equ  500				 ;最小锁定重量5.00kg
; INPUT	
R_WT_Weight_L		 equ  R_SYS_A0					 ;原始的AD值低8位
R_WT_Weight_H		 equ  R_SYS_A1					 ;原始的AD值高8位
; OUTPUT
;R_WT_Steady_Flag	 equ  R_SYS_RET					 ;返回稳定状态
; private
R_WT_WeightOldL		 equ  R_F_JudgeWeight_Steady_S+0		 ;滑动滤波次数变量
R_WT_WeightOldH		 equ  R_F_JudgeWeight_Steady_S+1		 ;滑动平均滤波范围
R_WT_SameWeightTimes equ  R_F_JudgeWeight_Steady_S+2		 ;记录判断出同一个重量的次数
R_WT_Steady_Flag	 equ  R_F_JudgeWeight_Steady_S+3		 ;记录稳定标志
B_WT_Small_Steady	 equ  0
B_WT_Heavy_Steady	 equ  1

; public
;R_WT_TempL			 equ  R_WT_SEG_S+0		 ;缓存低8位
;R_WT_TempH			 equ  R_WT_SEG_S+1		 ;缓存高8位

F_JudgeWeight_Steady:		
		fcall2	F_ABS_24,R_WT_Weight_L,2,R_WT_WeightOldL,2,R_WT_TempL,2		
		movlw	DEF_SameWeightRange
		subwf	R_WT_TempL,w
		movlw	00
		subwfc	R_WT_TempH,w
		
		btfss	STATUS,C
		goto	F_JudgeWeight_Steady_L1		 ;在同一个重量的范围内 		
		clrf	R_WT_SameWeightTimes
		goto	F_JudgeWeight_Steady_L2
F_JudgeWeight_Steady_L1:
		movlw	ffh							 ;相同重量统计加一，最大只能为255
		subwf	R_WT_SameWeightTimes,w
		btfss	STATUS,C
		incf	R_WT_SameWeightTimes,f
F_JudgeWeight_Steady_L2:
		movfw	R_WT_Weight_L				 ;保存这次重量，用于下一次的比较
		movwf	R_WT_WeightOldL
		movfw	R_WT_Weight_H
		movwf	R_WT_WeightOldH
		
		bcf		R_WT_Steady_Flag,B_WT_Small_Steady
		bcf		R_WT_Steady_Flag,B_WT_Heavy_Steady
		
		movlw	DEF_SteadyTimes				 ;达到稳定次数的处理
		subwf	R_WT_SameWeightTimes,w
		btfss	STATUS,C
		goto	F_JudgeWeight_Steady_Exit
		
		movlw	DEF_MinLockWeight
		subwf	R_WT_Weight_L,w
		movlw	0
		subwfc	R_WT_Weight_H,w
		
		btfsc	STATUS,C
		goto	F_JudgeWeight_Steady_L3
		bsf		R_WT_Steady_Flag,B_WT_Small_Steady
		goto	F_JudgeWeight_Steady_Exit		
F_JudgeWeight_Steady_L3:
		bsf		R_WT_Steady_Flag,B_WT_Heavy_Steady	
F_JudgeWeight_Steady_Exit:	
		movfw	R_WT_Steady_Flag
		movwf	R_SYS_RET
		return


