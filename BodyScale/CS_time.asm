
;==================================================
;		�����ʱ
;==================================================
;���ܣ�ͨ��ָ����ʱ
;���룺
;���棺
;�����
;==================================================
; INPUT	
R_ST_Delay0			 equ  R_SYS_A0					 ;��ʱ
; OUTPUT

; �����ʱ177+60*R_SYS_A0��ָ�� 
; *177�ǲ���function_io�ĺ������÷�ʽ�����Ŀ���
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

; �����ʱ177+1000*R_SYS_A0��ָ��
; *177�ǲ���function_io�ĺ������÷�ʽ�����Ŀ���
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
		
		
; �����ʱ�ӽ�1000 000*R_SYS_A0��ָ�� 	
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
		
	



