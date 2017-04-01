;--------------------------------------------
;				约定
;--------------------------------------------
; 1.数据存储按小端模式（高字节高地址，低字节低地址）
; 2.函数的输入输出变量均在100h~1ffh区域
; 3.中断最好不要调用函数
; 4.增加170条指令clk的时间开销

;--------------------------------------------
;	函数输入输出参数用到的变量
;--------------------------------------------
R_FIO_SEG_S			 equ  R_RAM_ALC_FIO_S
; public
R_FUNC_A0			 equ  R_FIO_SEG_S+0		 ;函数输入接口变量A0
R_FUNC_A1			 equ  R_FIO_SEG_S+1		 ;函数输入接口变量A1
R_FUNC_A2			 equ  R_FIO_SEG_S+2		 ;函数输入接口变量A2
R_FUNC_A3			 equ  R_FIO_SEG_S+3		 ;函数输入接口变量A3
R_FUNC_A4			 equ  R_FIO_SEG_S+4		 ;函数输入接口变量A4
R_FUNC_A5			 equ  R_FIO_SEG_S+5		 ;函数输入接口变量A5

R_FUNC_B0			 equ  R_FIO_SEG_S+6		 ;函数输入接口变量B0
R_FUNC_B1			 equ  R_FIO_SEG_S+7		 ;函数输入接口变量B1
R_FUNC_B2			 equ  R_FIO_SEG_S+8		 ;函数输入接口变量B2

R_FUNC_C0			 equ  R_FIO_SEG_S+9		 ;函数输出接口变量C0
R_FUNC_C1			 equ  R_FIO_SEG_S+10	 ;函数输出接口变量C1
R_FUNC_C2			 equ  R_FIO_SEG_S+11	 ;函数输出接口变量C2
R_FUNC_C3			 equ  R_FIO_SEG_S+12	 ;函数输出接口变量C3
R_FUNC_C4			 equ  R_FIO_SEG_S+13	 ;函数输出接口变量C4
R_FUNC_C5			 equ  R_FIO_SEG_S+14	 ;函数输出接口变量C5
R_FUNC_RET			 equ  R_FIO_SEG_S+15	 ;函数返回值

; private
R_FIO_SEG_S1		 equ  R_RAM_ALC_FIO_S1
R_FUNC_L1_A0		 equ  R_FIO_SEG_S1+0	 ;函数第一层嵌套调用备份变量A0
R_FUNC_L1_A1		 equ  R_FIO_SEG_S1+1	 ;函数第一层嵌套调用备份变量A1
R_FUNC_L1_A2		 equ  R_FIO_SEG_S1+2	 ;函数第一层嵌套调用备份变量A2
R_FUNC_L1_A3		 equ  R_FIO_SEG_S1+3	 ;函数第一层嵌套调用备份变量A3
R_FUNC_L1_A4		 equ  R_FIO_SEG_S1+4	 ;函数第一层嵌套调用备份变量A4
R_FUNC_L1_A5		 equ  R_FIO_SEG_S1+5	 ;函数第一层嵌套调用备份变量A5
R_FUNC_L1_B0		 equ  R_FIO_SEG_S1+6	 ;函数第一层嵌套调用备份变量B0
R_FUNC_L1_B1		 equ  R_FIO_SEG_S1+7	 ;函数第一层嵌套调用备份变量B1
R_FUNC_L1_B2		 equ  R_FIO_SEG_S1+8	 ;函数第一层嵌套调用备份变量B2

R_FUNC_L2_A0		 equ  R_FIO_SEG_S1+9	 ;函数第二层嵌套调用备份变量A0
R_FUNC_L2_A1		 equ  R_FIO_SEG_S1+10	 ;函数第二层嵌套调用备份变量A1
R_FUNC_L2_A2		 equ  R_FIO_SEG_S1+11	 ;函数第二层嵌套调用备份变量A2
R_FUNC_L2_A3		 equ  R_FIO_SEG_S1+12	 ;函数第二层嵌套调用备份变量A3
R_FUNC_L2_A4		 equ  R_FIO_SEG_S1+13	 ;函数第二层嵌套调用备份变量A4
R_FUNC_L2_A5		 equ  R_FIO_SEG_S1+14	 ;函数第二层嵌套调用备份变量A5
R_FUNC_L2_B0		 equ  R_FIO_SEG_S1+15	 ;函数第二层嵌套调用备份变量B0
R_FUNC_L2_B1		 equ  R_FIO_SEG_S1+16	 ;函数第二层嵌套调用备份变量B1
R_FUNC_L2_B2		 equ  R_FIO_SEG_S1+17	 ;函数第二层嵌套调用备份变量B2

R_FUNC_L3_A0		 equ  R_FIO_SEG_S1+18	 ;函数第三层嵌套调用备份变量A0
R_FUNC_L3_A1		 equ  R_FIO_SEG_S1+19	 ;函数第三层嵌套调用备份变量A1
R_FUNC_L3_A2		 equ  R_FIO_SEG_S1+20	 ;函数第三层嵌套调用备份变量A2
R_FUNC_L3_A3		 equ  R_FIO_SEG_S1+21	 ;函数第三层嵌套调用备份变量A3
R_FUNC_L3_A4		 equ  R_FIO_SEG_S1+22	 ;函数第三层嵌套调用备份变量A4
R_FUNC_L3_A5		 equ  R_FIO_SEG_S1+23	 ;函数第三层嵌套调用备份变量A5
R_FUNC_L3_B0		 equ  R_FIO_SEG_S1+24	 ;函数第三层嵌套调用备份变量B0
R_FUNC_L3_B1		 equ  R_FIO_SEG_S1+25	 ;函数第三层嵌套调用备份变量B1
R_FUNC_L3_B2		 equ  R_FIO_SEG_S1+26	 ;函数第三层嵌套调用备份变量B2

R_FUNC_L4_A0		 equ  R_FIO_SEG_S1+27	 ;函数第四层嵌套调用备份变量A0
R_FUNC_L4_A1		 equ  R_FIO_SEG_S1+28	 ;函数第四层嵌套调用备份变量A1
R_FUNC_L4_A2		 equ  R_FIO_SEG_S1+29	 ;函数第四层嵌套调用备份变量A2
R_FUNC_L4_A3		 equ  R_FIO_SEG_S1+30	 ;函数第四层嵌套调用备份变量A3
R_FUNC_L4_A4		 equ  R_FIO_SEG_S1+31	 ;函数第四层嵌套调用备份变量A4
R_FUNC_L4_A5		 equ  R_FIO_SEG_S1+32	 ;函数第四层嵌套调用备份变量A5
R_FUNC_L4_B0		 equ  R_FIO_SEG_S1+33	 ;函数第四层嵌套调用备份变量B0
R_FUNC_L4_B1		 equ  R_FIO_SEG_S1+34	 ;函数第四层嵌套调用备份变量B1
R_FUNC_L4_B2		 equ  R_FIO_SEG_S1+35	 ;函数第四层嵌套调用备份变量B2

R_FUNC_L5_A0		 equ  R_FIO_SEG_S1+36	 ;函数第五层嵌套调用备份变量A0
R_FUNC_L5_A1		 equ  R_FIO_SEG_S1+37	 ;函数第五层嵌套调用备份变量A1
R_FUNC_L5_A2		 equ  R_FIO_SEG_S1+38	 ;函数第五层嵌套调用备份变量A2
R_FUNC_L5_A3		 equ  R_FIO_SEG_S1+39	 ;函数第五层嵌套调用备份变量A3
R_FUNC_L5_A4		 equ  R_FIO_SEG_S1+40	 ;函数第五层嵌套调用备份变量A4
R_FUNC_L5_A5		 equ  R_FIO_SEG_S1+41	 ;函数第五层嵌套调用备份变量A5
R_FUNC_L5_B0		 equ  R_FIO_SEG_S1+42	 ;函数第五层嵌套调用备份变量B0
R_FUNC_L5_B1		 equ  R_FIO_SEG_S1+43	 ;函数第五层嵌套调用备份变量B1
R_FUNC_L5_B2		 equ  R_FIO_SEG_S1+44	 ;函数第五层嵌套调用备份变量B2

R_FUNC_L6_A0		 equ  R_FIO_SEG_S1+45	 ;函数第六层嵌套调用备份变量A0
R_FUNC_L6_A1		 equ  R_FIO_SEG_S1+46	 ;函数第六层嵌套调用备份变量A1
R_FUNC_L6_A2		 equ  R_FIO_SEG_S1+47	 ;函数第六层嵌套调用备份变量A2
R_FUNC_L6_A3		 equ  R_FIO_SEG_S1+48	 ;函数第六层嵌套调用备份变量A3
R_FUNC_L6_A4		 equ  R_FIO_SEG_S1+49	 ;函数第六层嵌套调用备份变量A4
R_FUNC_L6_A5		 equ  R_FIO_SEG_S1+50	 ;函数第六层嵌套调用备份变量A5
R_FUNC_L6_B0		 equ  R_FIO_SEG_S1+51	 ;函数第六层嵌套调用备份变量B0
R_FUNC_L6_B1		 equ  R_FIO_SEG_S1+52	 ;函数第六层嵌套调用备份变量B1
R_FUNC_L6_B2		 equ  R_FIO_SEG_S1+53	 ;函数第六层嵌套调用备份变量B2

R_FUNC_BAK_A0		 equ  R_FIO_SEG_S1+54	 ;输入参数A0的影子寄存器
R_FUNC_BAK_A1		 equ  R_FIO_SEG_S1+55	 ;输入参数A1的影子寄存器
R_FUNC_BAK_A2		 equ  R_FIO_SEG_S1+56	 ;输入参数A2的影子寄存器
R_FUNC_BAK_A3		 equ  R_FIO_SEG_S1+57	 ;输入参数A3的影子寄存器
R_FUNC_BAK_A4		 equ  R_FIO_SEG_S1+58	 ;输入参数A4的影子寄存器
R_FUNC_BAK_A5		 equ  R_FIO_SEG_S1+59	 ;输入参数A5的影子寄存器

R_FUNC_LEVEL		 equ  R_FIO_SEG_S1+60	 ;保存函数调用层数从1开始
R_FUNC_COUNT		 equ  R_FIO_SEG_S1+61	 ;函数输入输出参数个数

;==================================================
;		宏_导入函数入口参数
;==================================================
;功能：导入首地址ram_add_s处的len个变量到R_FUNC_A0~5
;	   ram_add_s地址递增
;	   导入顺序依次从R_FUNC_A0到R_FUNC_A5
;
;参数：ram_add_s	导入数据的首地址
;	   len			导入的数据的个数
;==================================================
mcinA	macro	ram_add_s , len
		movlw	ram_add_s
		movwf	FSR0
		movlw	len
		call	F_Input_ParameterA
		endm

;==================================================
;		宏_导入函数入口参数
;==================================================
;功能：导入首地址ram_add_s处的len个变量到R_FUNC_A0~5
;	   ram_add_s地址递增
;	   导入顺序依次从R_FUNC_A0到R_FUNC_A5
;
;参数：ram_add_s	导入数据的首地址
;	   len			导入的数据的个数
;==================================================
mcinB	macro	ram_add_s , len
		movlw	ram_add_s
		movwf	FSR0
		movlw	len
		call	F_Input_ParameterB
		endm

;==================================================
;		宏_导出函数出口参数
;==================================================
;功能：导出R_FUNC_C0~5到首地址ram_add_s的len个变量处
;	   ram_add_s地址递增
;	   导出顺序依次从R_FUNC_C0到R_FUNC_C5
;
;参数：ram_add_s	导出数据的首地址
;	   len			导出的数据的个数
;==================================================
mcout   macro	ram_add_s , len
		movlw	ram_add_s
		movwf	FSR0
		movlw	len
		call	F_Output_ParameterC
		endm


;==================================================
;		宏_带输入参数的函数调用
;==================================================
;功能：带输入参数函数调用
;
;参数：f_fuc	调用函数名
;	   f_in		输入参数首地址
;	   len_in   输入参数的长度（字节）
;==================================================
fcall	macro	f_fuc,f_in,len_in
		call	F_Input_ParameterBakup
		mcinA	f_in,len_in		
		call	f_fuc
		call	F_Input_ParameterRestore
		endm

;==================================================
;		宏_带立即数的函数调用
;==================================================
;功能：带立即数输入的函数调用
;
;参数：f_fuc	调用函数名
;	   f1		第一个立即数
;	   f2		第一个立即数
;==================================================
fcall0	macro	f_fuc,f1,f2
		call	F_Input_ParameterBakup
		movlw	f1
		movwf	R_FUNC_A0
		movlw	f2
		movwf	R_FUNC_A1
		call	f_fuc
		call	F_Input_ParameterRestore
		endm

;==================================================
;		宏_带输入输出参数的函数调用
;==================================================
;功能：带输入输出参数函数调用
;
;参数：f_fuc	调用函数名
;	   f_in		输入参数首地址
;	   len_in   输入参数的长度（字节）
;      f_out    输出参数首地址
;	   len_out  输出参数的长度（字节）
;==================================================
fcall1	macro	f_fuc,f_in,len_in,f_out,len_out
		call	F_Input_ParameterBakup
		mcinA	f_in,len_in
		call	f_fuc
		call	F_Input_ParameterRestore
		mcout	f_out,len_out
		endm

;==================================================
;		宏_带输入输出参数的函数调用
;==================================================
;功能：带输入输出参数函数调用
;
;参数：f_fuc	调用函数名
;	   f_in		输入参数A首地址
;	   len_in   输入参数A的长度（字节）
;	   f_in1	输入参数B首地址
;	   len_in1  输入参数B的长度（字节
;      f_out    输出参数首地址
;	   len_out  输出参数的长度（字节）
;==================================================
fcall2	macro	f_fuc,f_in,len_in,f_in1,len_in1,f_out,len_out
		call	F_Input_ParameterBakup
		mcinA	f_in,len_in
		mcinB	f_in1,len_in1
		call	f_fuc
		call	F_Input_ParameterRestore
		mcout	f_out,len_out
		endm



