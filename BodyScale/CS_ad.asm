

;==================================================
;		MAP OF RAM
;==================================================
R_AD_SEG_S			 equ  R_RAM_ALC_AD_S
; F_Get_Adc & F_Get_Fast_Adc 
R_AD_FLAG			 equ  R_AD_SEG_S+0		 ;AD��־λ
R_AD_SUM_TIMES		 equ  R_AD_SEG_S+1		 ;�ۼ���ʹ���
R_AD_SUM_BUF_LL		 equ  R_AD_SEG_S+2		 ;32λAD��ͻ���bit7~0
R_AD_SUM_BUF_LH		 equ  R_AD_SEG_S+3		 ;32λAD��ͻ���bit15~8
R_AD_SUM_BUF_HL		 equ  R_AD_SEG_S+4		 ;32λAD��ͻ���bit23~16
R_AD_SUM_BUF_HH		 equ  R_AD_SEG_S+5		 ;32λAD��ͻ���bit31~24
; public	������ͷţ�Ƕ�׵ĺ���û���õ�
R_AD_TempL			 equ  R_AD_SEG_S+6		 ;����
R_AD_TempM			 equ  R_AD_SEG_S+7		 ;����
R_AD_TempH			 equ  R_AD_SEG_S+8
R_AD_Count			 equ  R_AD_SEG_S+9		 ;����

R_AD_Run_ZeroL		 equ  R_AD_SEG_S+10		 ;�������ֵ��8λ
R_AD_Run_ZeroH		 equ  R_AD_SEG_S+11		 ;�������ֵ��8λ

R_AD_Pow_ZeroL		 equ  R_AD_SEG_S+12		 ;�������ֵ��8λ
R_AD_Pow_ZeroH		 equ  R_AD_SEG_S+13		 ;�������ֵ��8λ

; F_Adc_Filter ר�ñ��� total: 20
R_F_Adc_Filter_S	 equ  R_AD_SEG_S+14
R_F_Adc_Filter_E	 equ  R_AD_SEG_S+33		 ;�����˲�����8��8λ


;==================================================
;		�ϵ�������ú���
;==================================================
;���ܣ��������������Ϊ�ϵ����
;���룺
;���棺
;�����
;==================================================
F_SetPowerOnZero:
		movfw	R_SYS_A0
		movwf	R_AD_Pow_ZeroL	
		movfw	R_SYS_A1
		movwf	R_AD_Pow_ZeroH	
		return

;==================================================
;		����������ú���
;==================================================
;���ܣ��������������Ϊ��ǰ���
;���룺
;���棺
;�����
;==================================================
F_SetRunZero:
		movfw	R_SYS_A0
		movwf	R_AD_Run_ZeroL	
		movfw	R_SYS_A1
		movwf	R_AD_Run_ZeroH	
		return

		
;==================================================
;		��㴦����
;==================================================
;���ܣ��������������Ϊ��ǰ���
;���룺
;���棺
;�����
;==================================================

		


;==================================================
;		�����������AD�仯������
;==================================================
;���ܣ����㵱ǰAD��������AD����Ĳ�ֵ
;���룺
;���棺
;�����
;==================================================
; INPUT	
R_AD_OriIn_L		 equ  R_SYS_A0					 ;ԭʼ��ADֵ��8λ
R_AD_OriIn_H		 equ  R_SYS_A1					 ;ԭʼ��ADֵ��8λ
; OUTPUT
R_AD_Delta_L		 equ  R_SYS_C0					 ;�˲����ADֵ��8λ
R_AD_Delta_H		 equ  R_SYS_C1					 ;�˲����ADֵ��8λ
B_AD_Delta_POS		 equ  1
; public
;R_AD_Run_ZeroL		 equ  R_AD_SEG_S+9		 ;�������ֵ��8λ
;R_AD_Run_ZeroH		 equ  R_AD_SEG_S+10		 ;�������ֵ��8λ

F_GetDeltaAD:	
		fcall2	F_ABS_24,R_AD_OriIn_L,2,R_AD_Run_ZeroL,2,R_AD_Delta_L,2
		btfss	R_SYS_RET,0
		goto	$+3
		bsf		R_AD_FLAG,B_AD_Delta_POS
		goto	$+2
		bcf		R_AD_FLAG,B_AD_Delta_POS		
		return


;==================================================
;		����ƽ���˲�����
;==================================================
;���ܣ�1��8������ƽ���˲�,�����˲�ֵ���˲�����
;���룺R_AD_BufNow_L,R_AD_BufNow_H
;���棺
;�����R_AD_BufFil_L,R_AD_BufFil_H
;==================================================
; CONSTANT
;DEF_XXX			 equ  4							 ;��������
; INPUT	
R_AD_BufNow_L		 equ  R_SYS_A0					 ;Ҫ�����˲���ADֵ��8λ
R_AD_BufNow_H		 equ  R_SYS_A1					 ;Ҫ�����˲���ADֵ��8λ
; OUTPUT
R_AD_BufFil_L		 equ  R_SYS_C0					 ;�˲����ADֵ��8λ
R_AD_BufFil_H		 equ  R_SYS_C1					 ;�˲����ADֵ��8λ
R_AD_BufFil_RET		 equ  R_SYS_RET					 ;����ֵ
; PRIVATE
R_AD_FilTimes		 equ  R_F_Adc_Filter_S+0		 ;�����˲���������
R_AD_FilRange		 equ  R_F_Adc_Filter_S+1		 ;����ƽ���˲���Χ
R_AD_BufOld_L		 equ  R_F_Adc_Filter_S+2		 ;��һ���˲����ݵ�8λ
R_AD_BufOld_H		 equ  R_F_Adc_Filter_S+3		 ;��һ���˲����ݸ�8λ
R_AD_FilBuf1_L		 equ  R_F_Adc_Filter_S+4		 ;�����˲�����1��8λ
R_AD_FilBuf1_H		 equ  R_F_Adc_Filter_S+5		 ;�����˲�����1��8λ
R_AD_FilBuf2_L		 equ  R_F_Adc_Filter_S+6		 ;�����˲�����2��8λ
R_AD_FilBuf2_H		 equ  R_F_Adc_Filter_S+7		 ;�����˲�����2��8λ
R_AD_FilBuf3_L		 equ  R_F_Adc_Filter_S+8		 ;�����˲�����3��8λ
R_AD_FilBuf3_H		 equ  R_F_Adc_Filter_S+9		 ;�����˲�����3��8λ
R_AD_FilBuf4_L		 equ  R_F_Adc_Filter_S+10		 ;�����˲�����4��8λ
R_AD_FilBuf4_H		 equ  R_F_Adc_Filter_S+11		 ;�����˲�����4��8λ

R_AD_FilBuf5_L		 equ  R_F_Adc_Filter_S+12		 ;�����˲�����5��8λ
R_AD_FilBuf5_H		 equ  R_F_Adc_Filter_S+13		 ;�����˲�����5��8λ
R_AD_FilBuf6_L		 equ  R_F_Adc_Filter_S+14		 ;�����˲�����6��8λ
R_AD_FilBuf6_H		 equ  R_F_Adc_Filter_S+15		 ;�����˲�����6��8λ
R_AD_FilBuf7_L		 equ  R_F_Adc_Filter_S+16		 ;�����˲�����7��8λ
R_AD_FilBuf7_H		 equ  R_F_Adc_Filter_S+17		 ;�����˲�����7��8λ
R_AD_FilBuf8_L		 equ  R_F_Adc_Filter_S+18		 ;�����˲�����8��8λ
R_AD_FilBuf8_H		 equ  R_F_Adc_Filter_S+19		 ;�����˲�����8��8λ
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
		movlw	ffh					;�ﵽ���ֵ����������
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
;  �˲��������ȡƽ���Ӻ��� 
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
;  �建���Ӻ��� 
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
;		AD�ɼ�����
;==================================================
;���ܣ���AD��һ��ƫ�ƺ��ۼ���ƽ��Ȼ���ȡ�м�
;	   16bit���
;���룺R_AD_OriginalX(L,M,H)
;���棺R_AD_SUM_BUF_XX(LL,LH,HL,HH),R_AD_SUM_TIMES
;�����R_AD_Avg_OutX(L,H),B_AD_GetOne
;==================================================
; CONSTANT
DEF_SumTimes		 equ  4				 ;AD�ۼӱ��� (�������ȡ2��ָ����)	
DEF_AdShiftL		 equ  00h			 ;ADƫ����bit7~0
DEF_AdShiftM		 equ  00h			 ;ADƫ����bit15~8
DEF_AdShiftH		 equ  10h			 ;ADƫ����bit23~16
; INPUT
R_AD_OriginalL		 equ  R_SYS_A0		 ;ԭʼADֵ��8λ
R_AD_OriginalM		 equ  R_SYS_A1		 ;ԭʼADֵ��8λ
R_AD_OriginalH		 equ  R_SYS_A2		 ;ԭʼADֵ��8λ
; OUTPUT
R_AD_Avg_OutL		 equ  R_SYS_C0		 ;ԭʼAD����ƫ���ۼ���ƽ��������bit13~6
R_AD_Avg_OutH		 equ  R_SYS_C1		 ;ԭʼAD����ƫ���ۼ���ƽ��������bit21~14
B_AD_GetOne			 equ  0				 ;���һ�����ƽ����������ֵ���λ��1
; PRIVATE


F_Get_Adc:
		bcf		R_AD_FLAG,B_AD_GetOne
	 ;-------------------------	
	 ;  AD����DEF_AdShiftƫ��ֵ 
     ;-------------------------
		movlw   DEF_AdShiftL    		        
	    addwf   R_AD_OriginalL,f 
	    movlw   DEF_AdShiftM
	    addwfc  R_AD_OriginalM,f
	    movlw   DEF_AdShiftH
	    addwfc  R_AD_OriginalH,f
	 ;-------------------------
	 ;  ȡR_AD_Originalx�ۼ� 
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
	 ;  ��ȡ��ͻ�����м�16λ��� 
     ;-------------------------
	    ;  ע*��R_AD_SUM_TIMESΪ4���ۼ�Ϊ4��ʱȡ�м�
	    ;  16λ�������ȡ����R_AD_Originalx��bit21~6
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
;		����AD�ɼ�����
;==================================================
;���ܣ���AD��һ��ƫ�ƺ��ۼ���ƽ��Ȼ���ȡ�м�
;	   16bit���(��������halt�ȴ������)
;���룺B_AD_GetOne,R_AD_OriginalX(L,M,H)
;���棺R_AD_SUM_BUF_XX(LL,LH,HL,HH),R_AD_SUM_TIMES
;�����R_AD_Avg_OutX(L,H)
;==================================================		
		
F_Get_Fast_Adc:
	 	bcf		ADCON,ADM_2
	 	bcf		ADCON,ADM_1
		bsf		ADCON,ADM_0		;Bit2~0	 ADM[2:0]	���������ʣ�������ʣ�
								;001�� 1953Hz
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
        goto	 F_Get_Fast_Adc_L1		;����ǰ��3������
		
	 ;-------------------------	
	 ;  AD����DEF_AdShiftƫ��ֵ 
     ;-------------------------
		movlw   DEF_AdShiftL    		        
	    addwf   R_AD_OriginalL,f 
	    movlw   DEF_AdShiftM
	    addwfc  R_AD_OriginalM,f
	    movlw   DEF_AdShiftH
	    addwfc  R_AD_OriginalH,f	 
	 ;-------------------------
	 ;  ȡR_AD_Originalx�ۼ� 
     ;-------------------------
	    movfw	R_AD_OriginalL
	    addwf	R_AD_SUM_BUF_LL,f
	    movfw	R_AD_OriginalM
	    addwfc	R_AD_SUM_BUF_LH,f
	    movlw	R_AD_OriginalH
	    addwfc	R_AD_SUM_BUF_HL,f
	    movlw	0
	    addwfc	R_AD_SUM_BUF_HH,f	    
	    
	    movlw	05h						;5-3=2�ۼ���������
	    subwf	R_AD_SUM_TIMES,w
	    btfss   STATUS,C
	    goto	F_Get_Fast_Adc_L1
	    
	    bcf		INTE,ADIE
	    bcf		INTF,ADIF
	    bcf		INTE,GIE
	    
	 ;-------------------------
	 ;  ��������1λ 
     ;-------------------------
	 	bcf		STATUS,C				
	    rlf		R_AD_SUM_BUF_LL,f
	    rlf		R_AD_SUM_BUF_LH,f
	    rlf		R_AD_SUM_BUF_HL,f    	    
	    rlf		R_AD_SUM_BUF_HH,f	
	    							;�ۼ������ʣ�����һλ��ȡ�����
	    							;�м�16λʵ����ȡԭʼAD
									;��bit21~6���м��16λ
	    movfw	R_AD_SUM_BUF_LH
	 	movwf	R_AD_Avg_OutL	
	    movfw	R_AD_SUM_BUF_HL
	 	movwf	R_AD_Avg_OutH
	 	
F_Get_Fast_Adc_Exit:
		return

	
	
		