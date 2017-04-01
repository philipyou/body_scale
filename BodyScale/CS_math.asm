
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
; 计算两个24位数的绝对值
;==================================================
;功能：  | R_Math_A2~0 - R_Math_B2~0 | 
;        计算R_Math_A2~0 和 R_Math_B0~2 的绝对值
;		 并返回B_Math_A_bigger（A>=B 时置1 否为0） 
;输入：  R_Math_A2~0, R_Math_B2~0
;缓存：  
;输出：  R_Math_C2~0,B_Math_A_bigger
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
;功能：  把R_Math_A2~R_Math_A0中的16进制数转换成
;		 BCD码存到R_Math_C3~R_Math_C0中
;输入：  R_Math_A2~R_Math_A0 
;缓存：  R_Math_Count
;输出：  R_Math_C3~R_Math_C0
;注明：  Run cycle : 1611
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
;除法函数48位除以24位
;==================================================
;功能： （R_Math_A5~R_Math_A0）/（R_Math_B2~R_Math_B0）
;        ->商（R_Math_A2~R_Math_A0）余数(R_Math_A5~R_Math_A3)
;输入：  R_Math_A5~R_Math_A0,R_Math_B2~R_Math_B0  
;缓存：  R_Math_Count
;输出：  R_Math_A5~R_Math_A0
;==================================================
F_Div24U:
	movlw	 18h
	movwf	 R_Math_Count
	
    movlw 	 0               ;判断R_Math_A5是否为零
	xorwf	 R_Math_A5,w
	btfss	 status,z 
	goto     L_Div24_1        ;否的话进行除法
	movlw 	 0               ;判断R_Math_A4是否为零
	xorwf	 R_Math_A4,w
	btfss	 status,z 
	goto     L_Div24_1        ;否的话进行除法
	movlw 	 0               ;判断R_Math_A3是否为零
	xorwf	 R_Math_A3,w
	btfss	 status,z 
	goto     L_Div24_1        ;否的话进行除法
	movlw 	 0               ;判断R_Math_A2是否为零
	xorwf	 R_Math_A2,w
	btfss	 status,z 
	goto     L_Div24_1        ;否的话进行除法
	movlw 	 0               ;判断R_Math_A1是否为零
	xorwf	 R_Math_A1,w
	btfss	 status,z 
	goto     L_Div24_1        ;否的话进行除法
	movlw 	 0               ;判断R_Math_A0是否为零
	xorwf	 R_Math_A0,w
	btfss	 status,z 
	goto     L_Div24_1        ;否的话进行除法 
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
	movfw	 R_Math_B2		;检测是否余数大于除数
	subwf	 R_Math_A5,0
		
	btfsc    Status,Z	      ;等于0，相等进行次高位比较
	goto     L_Div24_COMP1
	btfss	 Status,C
	goto     L_Div24_3
	goto     L_Div24_2
L_Div24_COMP1:		           ;如果高位相等则检测次高位
	movfw    R_Math_B1
	subwf    R_Math_A4,0
	btfsc    Status,Z	      ;等于0，相等进行次高位比较 
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
;乘法函数 24位乘以24位
;==================================================
;功能：  (R_Math_A2~R_Math_A0)*(R_Math_B2~R_Math_B0)
;        ->R_Math_C5~R_Math_C0
;输入：  R_Math_A2~R_Math_A0 、R_Math_B2~R_Math_B0
;缓存：  R_Math_Count
;输出：  R_Math_C5~R_Math_C0
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








