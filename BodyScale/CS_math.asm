
R_Math_S 			 equ  R_SYS_ABC_S
R_Math_A0			 equ  R_Math_S+0
R_Math_A1			 equ  R_Math_S+1
R_Math_A2			 equ  R_Math_S+2
R_Math_A3			 equ  R_Math_S+3
R_Math_A4			 equ  R_Math_S+4
R_Math_A5			 equ  R_Math_S+5

R_Math_B0			 equ  R_Math_S+6
R_Math_B1			 equ  R_Math_S+7
R_Math_B2			 equ  R_Math_S+8

R_Math_C0			 equ  R_Math_S+9
R_Math_C1			 equ  R_Math_S+10
R_Math_C2			 equ  R_Math_S+11
R_Math_C3			 equ  R_Math_S+12
R_Math_C4			 equ  R_Math_S+13
R_Math_C5			 equ  R_Math_S+14

R_Math_Count		 equ  R_Math_S+15
R_Math_RET			 equ  R_Math_S+15	

;==================================================
; ��������24λ���ľ���ֵ
;==================================================
;���ܣ�  | R_Math_A2~0 - R_Math_B2~0 | 
;        ����R_Math_A2~0 �� R_Math_B0~2 �ľ���ֵ
;		 ������B_Math_A_bigger��A>=B ʱ��1 ��Ϊ0�� 
;���룺  R_Math_A2~0, R_Math_B2~0
;���棺  
;�����  R_Math_C2~0,B_Math_A_bigger
;==================================================
B_Math_A_bigger		equ	 0	

F_ABS_24:
		bsf		R_Math_RET,B_Math_A_bigger
		
		movfw	R_Math_B0
		subwf	R_Math_A0,w
		movwf	R_Math_C0
		
		movfw	R_Math_B1
		subwfc  R_Math_A1,w
		movwf	R_Math_C1
		
		movfw	R_Math_B2
		subwfc  R_Math_A2,w
		movwf	R_Math_C2
				
		btfsc	STATUS,C
		return
		
		bcf		R_Math_RET,B_Math_A_bigger
		
		movfw	R_Math_A0
		subwf	R_Math_B0,w
		movwf	R_Math_C0
		
		movfw	R_Math_A1
		subwfc  R_Math_B1,w
		movwf	R_Math_C1
		
		movfw	R_Math_A2
		subwfc  R_Math_B2,w
		movwf	R_Math_C2
		
		return

;==================================================
; HexCode to BCDCode Transfer
;==================================================
;���ܣ�  ��R_Math_A2~R_Math_A0�е�16������ת����
;		 BCD��浽R_Math_C3~R_Math_C0��
;���룺  R_Math_A2~R_Math_A0 
;���棺  R_Math_Count
;�����  R_Math_C3~R_Math_C0
;ע����  Run cycle : 1611
;==================================================
F_Hex2BCD:  
		clrf	R_Math_C0
		clrf	R_Math_C1
		clrf	R_Math_C2
		clrf	R_Math_C3
		
		movlw	24
		movwf	R_Math_Count
		bcf		STATUS,C
F_Hex2BCD_L1:
		rlf		R_Math_A0,f
		rlf		R_Math_A1,f
		rlf		R_Math_A2,f
		
		rlf		R_Math_C0,f
		rlf		R_Math_C1,f
		rlf		R_Math_C2,f
		rlf		R_Math_C3,f
		decfsz	R_Math_Count,f
		goto	F_Hex2BCD_L2_AdjDec
		return
F_Hex2BCD_L2_AdjDec:
		movlw	R_Math_C0
		movwf	FSR0
		call	F_AdjBcd
		movlw	R_Math_C1
		movwf	FSR0
		call	F_AdjBcd
		movlw	R_Math_C2
		movwf	FSR0
		call	F_AdjBcd
		movlw	R_Math_C3
		movwf	FSR0
		call	F_AdjBcd
		goto	F_Hex2BCD_L1
;;;-----------------------------  
F_AdjBcd:  
		movlw	03h
		addwf	IND0,w
		btfsc	WORK,3
		movwf	IND0
		movlw	30h
		addwf	IND0,w
		btfsc	WORK,7
		movwf	IND0
		return
		
		

		
;==================================================
;��������48λ����24λ
;==================================================
;���ܣ� ��R_Math_A5~R_Math_A0��/��R_Math_B2~R_Math_B0��
;        ->�̣�R_Math_A2~R_Math_A0������(R_Math_A5~R_Math_A3)
;���룺  R_Math_A5~R_Math_A0,R_Math_B2~R_Math_B0  
;���棺  R_Math_Count
;�����  R_Math_A5~R_Math_A0
;==================================================
F_Div24U:
	movlw	 18h
	movwf	 R_Math_Count
	
    movlw 	 0               ;�ж�R_Math_A5�Ƿ�Ϊ��
	xorwf	 R_Math_A5,w
	btfss	 status,z 
	goto     L_Div24_1        ;��Ļ����г���
	movlw 	 0               ;�ж�R_Math_A4�Ƿ�Ϊ��
	xorwf	 R_Math_A4,w
	btfss	 status,z 
	goto     L_Div24_1        ;��Ļ����г���
	movlw 	 0               ;�ж�R_Math_A3�Ƿ�Ϊ��
	xorwf	 R_Math_A3,w
	btfss	 status,z 
	goto     L_Div24_1        ;��Ļ����г���
	movlw 	 0               ;�ж�R_Math_A2�Ƿ�Ϊ��
	xorwf	 R_Math_A2,w
	btfss	 status,z 
	goto     L_Div24_1        ;��Ļ����г���
	movlw 	 0               ;�ж�R_Math_A1�Ƿ�Ϊ��
	xorwf	 R_Math_A1,w
	btfss	 status,z 
	goto     L_Div24_1        ;��Ļ����г���
	movlw 	 0               ;�ж�R_Math_A0�Ƿ�Ϊ��
	xorwf	 R_Math_A0,w
	btfss	 status,z 
	goto     L_Div24_1        ;��Ļ����г��� 
	goto     L_Div24_4
L_Div24_1:
	bcf		 Status,C
	rlf      R_Math_A0,1
	rlf	     R_Math_A1,1
	rlf	     R_Math_A2,1
	rlf	     R_Math_A3,1
	rlf	     R_Math_A4,1
	rlf      R_Math_A5,1
	
	btfsc    Status,C
	goto	 L_Div24_2
	movfw	 R_Math_B2		;����Ƿ��������ڳ���
	subwf	 R_Math_A5,0
		
	btfsc    Status,Z	      ;����0����Ƚ��дθ�λ�Ƚ�
	goto     L_Div24_COMP1
	btfss	 Status,C
	goto     L_Div24_3
	goto     L_Div24_2
L_Div24_COMP1:		           ;�����λ�������θ�λ
	movfw    R_Math_B1
	subwf    R_Math_A4,0
	btfsc    Status,Z	      ;����0����Ƚ��дθ�λ�Ƚ� 
	goto     L_Div24_COMP2
	btfss	 Status,C
	goto     L_Div24_3
	goto     L_Div24_2
L_Div24_COMP2:
	movfw    R_Math_B0
	subwf    R_Math_A3,0
	btfss	 Status,C
	goto     L_Div24_3
	goto     L_Div24_2
L_Div24_2:
	movfw	 R_Math_B0
	subwf	 R_Math_A3,1
	movfw    R_Math_B1
	subwfc   R_Math_A4,1
	movfw	 R_Math_B2
	subwfc   R_Math_A5,1
	incf	 R_Math_A0,1
L_Div24_3:
	decfsz   R_Math_Count,1
	goto     L_Div24_1
L_Div24_4:
	movfw	 R_Math_A0
	movwf	 R_Math_C0
	movfw	 R_Math_A1
	movwf	 R_Math_C1
	movfw	 R_Math_A2
	movwf	 R_Math_C2
	movfw	 R_Math_A3
	movwf	 R_Math_C3
	movfw	 R_Math_A4
	movwf	 R_Math_C4
	movfw	 R_Math_A5
	movwf	 R_Math_C5	
	return


;==================================================
;�˷����� 24λ����24λ
;==================================================
;���ܣ�  (R_Math_A2~R_Math_A0)*(R_Math_B2~R_Math_B0)
;        ->R_Math_C5~R_Math_C0
;���룺  R_Math_A2~R_Math_A0 ��R_Math_B2~R_Math_B0
;���棺  R_Math_Count
;�����  R_Math_C5~R_Math_C0
;==================================================
F_Mul24U:
	movlw	   24
	movwf	   R_Math_Count
	clrf	   R_Math_C5
	clrf	   R_Math_C4
	clrf	   R_Math_C3
	clrf	   R_Math_C2
	clrf	   R_Math_C1
	clrf	   R_Math_C0
     
L_Mul24_1:
    bcf		   Status,C       ;clrc
    rlf	       R_Math_A0,1
    rlf        R_Math_A1,1
   	rlf        R_Math_A2,1
   	
    btfss	   Status,C       ;jc
    goto	   L_Mul24_2
    
	movfw	   R_Math_B0
    addwf	   R_Math_C0,1
    movfw	   R_Math_B1
    addwfc	   R_Math_C1,1
    movfw	   R_Math_B2
    addwfc	   R_Math_C2,1
    movlw      0
    addwfc	   R_Math_C3,1
    movlw      0
    addwfc	   R_Math_C4,1
    movlw      0
    addwfc	   R_Math_C5,1
     	
L_Mul24_2:
    decfsz	   R_Math_Count,1
    goto	   L_Mul24_3
    return
L_Mul24_3:
    bcf		   Status,C
    rlf	       R_Math_C0,1
    rlf	       R_Math_C1,1
    rlf	       R_Math_C2,1
    rlf	       R_Math_C3,1
    rlf	       R_Math_C4,1
    rlf	       R_Math_C5,1
    goto	   L_Mul24_1








