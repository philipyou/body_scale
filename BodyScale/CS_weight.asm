
;==================================================
;		MAP OF RAM
;==================================================
R_WT_SEG_S			 equ  R_RAM_ALC_WT_S	 ;ϵͳ�����RAM��ʼ��ַ
; public
R_WT_TempL			 equ  R_WT_SEG_S+0		 ;�����8λ
R_WT_TempH			 equ  R_WT_SEG_S+1		 ;�����8λ
; private
; F_GetWeight
; NONE
; F_JudgeWeight_Steady
R_F_JudgeWeight_Steady_S  equ   R_WT_SEG_S+2
R_F_JudgeWeight_Steady_E  equ	R_WT_SEG_S+5
	

;==================================================
;		������������
;==================================================
;���ܣ����㵱ǰ����
;���룺
;���棺
;�����
;==================================================
; CONSTANT
DEF_CALIDOT1		 equ  5000				 ;��һ�α궨���Ӧ�����仯50.00kg
DEF_CALIDOT2		 equ  5000				 ;�ڶ��α궨���Ӧ�����仯50.00kg
DEF_CALIDOT1a2		 equ  10000				 ;��һ�����α궨��������������仯100.00kg
DEF_CALIDOT3		 equ  5000				 ;�����α궨���Ӧ�����仯50.00kg
; INPUT	
R_WT_CaliDot1_L		 equ  R_SYS_A0			 ;��һ�α궨��AD�����8λ
R_WT_CaliDot1_H		 equ  R_SYS_A1			 ;��һ�α궨��AD�����8λ
R_WT_CaliDot2_L		 equ  R_SYS_A2			 ;�ڶ��α궨��AD�����8λ
R_WT_CaliDot2_H		 equ  R_SYS_A3			 ;�ڶ��α궨��AD�����8λ
R_WT_CaliDot3_L		 equ  R_SYS_A4			 ;�����α궨��AD�����8λ
R_WT_CaliDot3_H		 equ  R_SYS_A5			 ;�����α궨��AD�����8λ
R_WT_AD_L			 equ  R_SYS_B0			 ;�����AD�����8λ
R_WT_AD_H			 equ  R_SYS_B1			 ;�����AD�����8λ
; OUTPUT
R_WT_GetWeight_L		 equ  R_SYS_C0			 ;����ֵ��kg����8λ
R_WT_GetWeight_H		 equ  R_SYS_C1			 ;����ֵ��kg����8λ
; private
; NONE

; public
;R_WT_TempL			 equ  R_WT_SEG_S+0		 ;�����8λ
;R_WT_TempH			 equ  R_WT_SEG_S+1		 ;�����8λ

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
;		���ȴ�����
;==================================================
;���ܣ��жϵ�ǰ�����Ƿ��ȶ�
;���룺
;���棺
;�����
;==================================================
; CONSTANT
DEF_SameWeightRange	 equ  10				 ;�ж���ͬһ�������ķ�Χ����λΪ10g��	
DEF_SteadyTimes		 equ  6					 ;�ж��ȶ��Ĵ���
DEF_MinLockWeight	 equ  500				 ;��С��������5.00kg
; INPUT	
R_WT_Weight_L		 equ  R_SYS_A0					 ;ԭʼ��ADֵ��8λ
R_WT_Weight_H		 equ  R_SYS_A1					 ;ԭʼ��ADֵ��8λ
; OUTPUT
;R_WT_Steady_Flag	 equ  R_SYS_RET					 ;�����ȶ�״̬
; private
R_WT_WeightOldL		 equ  R_F_JudgeWeight_Steady_S+0		 ;�����˲���������
R_WT_WeightOldH		 equ  R_F_JudgeWeight_Steady_S+1		 ;����ƽ���˲���Χ
R_WT_SameWeightTimes equ  R_F_JudgeWeight_Steady_S+2		 ;��¼�жϳ�ͬһ�������Ĵ���
R_WT_Steady_Flag	 equ  R_F_JudgeWeight_Steady_S+3		 ;��¼�ȶ���־
B_WT_Small_Steady	 equ  0
B_WT_Heavy_Steady	 equ  1

; public
;R_WT_TempL			 equ  R_WT_SEG_S+0		 ;�����8λ
;R_WT_TempH			 equ  R_WT_SEG_S+1		 ;�����8λ

F_JudgeWeight_Steady:		
		fcall2	F_ABS_24,R_WT_Weight_L,2,R_WT_WeightOldL,2,R_WT_TempL,2		
		movlw	DEF_SameWeightRange
		subwf	R_WT_TempL,w
		movlw	00
		subwfc	R_WT_TempH,w
		
		btfss	STATUS,C
		goto	F_JudgeWeight_Steady_L1		 ;��ͬһ�������ķ�Χ�� 		
		clrf	R_WT_SameWeightTimes
		goto	F_JudgeWeight_Steady_L2
F_JudgeWeight_Steady_L1:
		movlw	ffh							 ;��ͬ����ͳ�Ƽ�һ�����ֻ��Ϊ255
		subwf	R_WT_SameWeightTimes,w
		btfss	STATUS,C
		incf	R_WT_SameWeightTimes,f
F_JudgeWeight_Steady_L2:
		movfw	R_WT_Weight_L				 ;�������������������һ�εıȽ�
		movwf	R_WT_WeightOldL
		movfw	R_WT_Weight_H
		movwf	R_WT_WeightOldH
		
		bcf		R_WT_Steady_Flag,B_WT_Small_Steady
		bcf		R_WT_Steady_Flag,B_WT_Heavy_Steady
		
		movlw	DEF_SteadyTimes				 ;�ﵽ�ȶ������Ĵ���
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


