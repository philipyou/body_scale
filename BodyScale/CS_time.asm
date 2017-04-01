
;==================================================
;		软件延时
;==================================================
;功能：通过指令延时
;输入：
;缓存：
;输出：
;==================================================
; INPUT	
R_ST_Delay0			 equ  R_SYS_A0					 ;延时
; OUTPUT

; 软件延时177+60*R_SYS_A0条指令 
; *177是采用function_io的函数调用方式产生的开销
F_delay_60clk:
		movlw	14
		movwf   R_SYS_A1
F_delay_60clk_L1:
		nop
		decfsz  R_SYS_A1,f
		goto    F_delay_60clk_L1
		decfsz  R_SYS_A0,f
		goto    F_delay_60clk
		return

; 软件延时177+1000*R_SYS_A0条指令
; *177是采用function_io的函数调用方式产生的开销
F_delay_1kclk:
		movlw	249
		movwf   R_SYS_A1
F_delay_1kclk_L1:
		nop
		decfsz  R_SYS_A1,f
		goto    F_delay_1kclk_L1
		decfsz  R_SYS_A0,f
		goto    F_delay_1kclk
		return
		
		
; 软件延时接近1000 000*R_SYS_A0条指令 	
F_delay_1mclk:
		movlw	10
		movwf   R_SYS_A1
F_delay_1mclk_L1:
		movlw	100
		movwf   R_SYS_A2
F_delay_1mclk_L2:
		movlw	249
		movwf   R_SYS_A3
F_delay_1mclk_L3:
		nop
		decfsz  R_SYS_A3,f
		goto    F_delay_1mclk_L3
		decfsz  R_SYS_A2,f
		goto    F_delay_1mclk_L2
		decfsz  R_SYS_A1,f
		goto    F_delay_1mclk_L1	
		decfsz  R_SYS_A0,f
		goto    F_delay_1mclk
		return
		
	



