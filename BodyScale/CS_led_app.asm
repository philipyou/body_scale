;======================================
;	LED��bufferλ���壨һ�㲻�޸ģ�
;======================================
LED_BUF_BIT0	EQU		00000001B
LED_BUF_BIT1	EQU		00000010B
LED_BUF_BIT2	EQU		00000100B
LED_BUF_BIT3	EQU		00001000B
LED_BUF_BIT4	EQU		00010000B
LED_BUF_BIT5	EQU		00100000B
LED_BUF_BIT6	EQU		01000000B
LED_BUF_BIT7	EQU		10000000B

;======================================
;	����ܵ�A~G�κ���ʾ�����λ��Ӧ��ϵ
;======================================
;  __	   A		0			
; |  |	 F	 B 	  5	  1 	
;  __	   G		6		
; |  |	 E	 C	  4   2		
;  __  	   D		3		
;--------------------------------------
S_A		  EQU		LED_BUF_BIT0	
S_B		  EQU		LED_BUF_BIT1
S_C		  EQU		LED_BUF_BIT2	
S_D		  EQU		LED_BUF_BIT3
S_E		  EQU		LED_BUF_BIT4		
S_F		  EQU		LED_BUF_BIT5
S_G		  EQU		LED_BUF_BIT6	

;======================================
;	���ַ��ű����
;======================================
;  __		A			
; |  | 	  F	  B 	
;  __		G		
; |  |    E   C		
;  __  		D
;--------------------------------------
Lcdch0    EQU   S_A+S_B+S_C+S_D+S_E+S_F
Lcdch1    EQU   S_B+S_C
Lcdch2    EQU   S_A+S_B+S_D+S_E+S_G
Lcdch3    EQU   S_A+S_B+S_C+S_D+S_G
Lcdch4    EQU   S_B+S_C+S_F+S_G
Lcdch5    EQU   S_A+S_C+S_D+S_F+S_G
Lcdch6    EQU   S_A+S_C+S_D+S_E+S_F+S_G
Lcdch7    EQU   S_A+S_B+S_C
Lcdch8    EQU   S_A+S_B+S_C+S_D+S_E+S_F+S_G
Lcdch9    EQU   S_A+S_B+S_C+S_D+S_F+S_G

LcdchA    EQU   S_A+S_B+S_C+S_E+S_F+S_G
Lcdchb    EQU   S_C+S_D+S_E+S_F+S_G
LcdchC    EQU   S_A+S_D+S_E+S_F
Lcdchd    EQU   S_B+S_C+S_D+S_E+S_G
LcdchE    EQU   S_A+S_D+S_E+S_F+S_G
LcdchF    EQU   S_A+S_E+S_F+S_G
                             
LcdchL    EQU   S_D+S_E+S_F
Lcdcho    EQU   S_C+S_D+S_E+S_G
LcdchP    EQU   S_A+S_B+S_E+S_F+S_G
Lcdchn    EQU   S_C+S_E+S_G
Lcdchr    EQU   S_E+S_G


;==================================================
;		LED��ʼ��
;==================================================
;���ܣ����LED�ĳ�ʼ������
;���룺��
;���棺��
;�������
;==================================================
F_LED_init:
	 ;-------------------------	
	 ;  ��ʼ��LED
     ;-------------------------					
		movlw	00111000b
		movwf	LEDCON1			;Bit7~5 LED_CURRENT[2:0] 		
								;LED��������ѡ��
								;000: 50mA
								;001: 40mA
								;010: 30mA
								;011: 25mA
								;100: 20mA
								;101: 15mA
								;110: 10mA
								;111: 10mA
								;Bit4~3 LED_DUTY[1:0] 
								;LEDɨ��ռ�ձ�ѡ��
								;11: 100%
								;10: 75%
								;01: 50%
								;00: 25%
								;Bit2~1 LEDCLKS[1:0] LEDʱ��ѡ��
								;00: ICLK/32
								;01: ICLK/64
								;10: ICLK/128
								;11: ICLK/256
								;Bit0 LED_PMODE LED������Դ����
								;0�� VDD��Ϊ������Դ
								;1�� CHPEN=1	3.8V pump
								;	 CHPEN=0    �ⲿ�����Դ
		movlw	00000000b			
		movwf	LEDCON2			;Bit0 LEDEN		LEDӲ������ʹ��
								;0�� LED������ʹ��
								;1:	 LED����ʹ��
								
		movlw	00000000b
		movwf	CHPCON			;Bit4 CHPVS	 charge pump �����ѹѡ��
								;0�� �����ѹ3.8V
								;1�� �����ѹ3.6V
								;Bit2~1 CHPCLKS[1:0] charge pump ʱ��ѡ��
								;00: 500KHz
								;01: 250KHz
								;10: 125KHz
								;11: 62.5KHz
								;Bit0 CHPEN charge pump ʹ��λ
								;0�� charge pump ��ʹ��
								;1�� charge pump ʹ��
		movlw	26H
		movwf	7DH				;����Ĵ���7DH
								;26h: ʹ�ܴ�������� 
								;00h: �رմ��������
		movlw	ffH		
		movwf	PT2EN			;0:����		1:���

	 ;-------------------------	
	 ;  ��ʼ��TIME1
     ;-------------------------
		movlw	240
		movwf	TM1IN			;Bit7~0 TM1IN[7:0]		
								;��ʱ��1���ֵ		
		movlw	10110000b
		movwf	TM1CON			;Bit7 T1EN ��ʱ��1ʹ��λ
	    						;0:  ��ֹ��ʱ��1
	    						;1:  ʹ�ܶ�ʱ��1
	    						;Bit6~4 T1RATE[2:0] ʱ�ӷ�Ƶ
	    						;000: CPUCLK
	    						;001: CPUCLK/2
								;010��CPUCLK/4
	    						;011: CPUCLK/8
	    						;100��CPUCLK/16
	    						;101: CPUCLK/32
	    						;110��CPUCLK/64
	    						;111: CPUCLK/128
								;Bit3 T1CKS ��ʱ��1ʱ��Դѡ��
								;0: CPUCLK�ķ�Ƶʱ��
	    						;1: PT4.0��Ϊʱ��
	    						;Bit2 T1RSTB ��ʱ��1��λ
	    						;0: ʹ�ܶ�ʱ��1��λ
	    						;1: ��ֹ��ʱ��1��λ
	    						;Bit1~0 T1OUT PWM1OUT PT4.1���������
								;PT4.1������ƣ�����PT4.1����Ϊ�����Ч
	    						;00: IO���
	    						;10: ���������	
								;01: PWM1���
	    						;11: PWM1ȡ�����
		bsf		INTE,TM1IE
		bsf		INTE,GIE
		return

		
;==================================================
;		�����
;==================================================
;���ܣ������
;���룺��
;���棺��
;�������
;==================================================
F_Dsp_Table:
		addpcw	       
		retlw	Lcdch0	;0	(work=0)
		retlw	Lcdch1	;1	(work=1)
		retlw	Lcdch2	;2	(work=2)
		retlw	Lcdch3	;3	(work=3)
		retlw	Lcdch4	;4	(work=4)
		retlw	Lcdch5	;5	(work=5)
		retlw	Lcdch6	;6	(work=6)
		retlw	Lcdch7	;7	(work=7)
		retlw	Lcdch8	;8	(work=8)
		retlw	Lcdch9	;9	(work=9)
		retlw	LcdchA	;A	(work=a)
		retlw	Lcdchb	;b	(work=b)
		retlw	LcdchC	;C	(work=c)
		retlw	Lcdchd	;d	(work=d)
		retlw	LcdchE	;E	(work=e)
		retlw	LcdchF	;F	(work=f)		
		

	
		
		
		
