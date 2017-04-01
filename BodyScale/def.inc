
DEF_SYS_CALIDOT1	equ  1600			;��һ�α궨���Ӧ���������		
DEF_SYS_CALIDOT2	equ  1600			;�ڶ��α궨���Ӧ���������	
DEF_SYS_CALIDOT3	equ	 1600			;�����α궨���Ӧ���������	


;============================================
;   LED �õ��ı���
;============================================
; PAGE0	ǰ��128��RAM�ķֲ� 80H~FFH
;--------------------------------------------
; ���䵽CS_function_io.asm��һ�ε�RAM��ַ�ʹ�С
;--------------------------------------------
; private
R_RAM_ALC_FIO_S1	 equ  80h
R_RAM_ALC_FIO_E1	 equ  bdh

;--------------------------------------------
;   PAGE0	����256��RAM�ķֲ� 100H~1FFH
;--------------------100h--------------------
;--------------------------------------------
; A��B��C�����RAM��ַ�����⣩
;--------------------------------------------
R_SYS_ABC_S			equ  100h
R_SYS_A_S			equ	 R_SYS_ABC_S+0
R_SYS_A0			equ	 R_SYS_ABC_S+0
R_SYS_A1			equ  R_SYS_ABC_S+1
R_SYS_A2			equ  R_SYS_ABC_S+2
R_SYS_A3			equ	 R_SYS_ABC_S+3
R_SYS_A4			equ  R_SYS_ABC_S+4
R_SYS_A5			equ  R_SYS_ABC_S+5

R_SYS_B_S			equ	 R_SYS_ABC_S+6
R_SYS_B0			equ	 R_SYS_ABC_S+6
R_SYS_B1			equ  R_SYS_ABC_S+7
R_SYS_B2			equ  R_SYS_ABC_S+8

R_SYS_C_S			equ	 R_SYS_ABC_S+9
R_SYS_C0			equ	 R_SYS_ABC_S+9
R_SYS_C1			equ  R_SYS_ABC_S+10
R_SYS_C2			equ  R_SYS_ABC_S+11
R_SYS_C3			equ	 R_SYS_ABC_S+12
R_SYS_C4			equ  R_SYS_ABC_S+13
R_SYS_C5			equ  R_SYS_ABC_S+14

R_SYS_RET			equ	 R_SYS_ABC_S+15
R_SYS_ABC_E			equ	 10fh
;--------------------------------------------
; ���䵽CS_function_io.asm�ڶ��ε�RAM��ַ�ʹ�С
;--------------------------------------------
R_RAM_ALC_FIO_S		equ  100h
R_RAM_ALC_FIO_E		equ  10fh
;--------------------------------------------
; ���䵽CS_math.asm��RAM��ַ�ʹ�С
;--------------------------------------------
; private
R_RAM_ALC_MH_S		equ	  100h
R_RAM_ALC_MH_E		equ	  10fh
;--------------------------------------------
; ���䵽CS_ad.asm��RAM��ַ�ʹ�С
;--------------------------------------------
; private
R_RAM_ALC_AD_S		equ	  110h
R_RAM_ALC_AD_E		equ	  R_RAM_ALC_AD_S+33

;--------------------------------------------
;	����
;--------------------------------------------
R_TEMP1				equ	  140h
R_TEMP2				equ	  141h
R_TEMP3				equ	  142h
R_TEMP4				equ	  143h

R_TEMP				equ	  144h

R_SYS_ADbufL		equ	  145h		;AD����
R_SYS_ADbufH		equ	  146h

R_SYS_Count			equ   147h

R_SYS_CalDot1L		equ	  148h		;�궨��1��8λ
R_SYS_CalDot1H		equ	  149h		;�궨��1��8λ
R_SYS_CalDot2L		equ	  14ah		;�궨��2��8λ
R_SYS_CalDot2H		equ	  14bh		;�궨��2��8λ
R_SYS_CalDot3L		equ	  14ch		;�궨��3��8λ
R_SYS_CalDot3H		equ	  14dh		;�궨��3��8λ

;--------------------------------------------
;   �ж��õ��ı���
;--------------------------------------------
; public
R_RAM_ALC_INT_S		equ  170h
R_INT_AdL		 	equ  R_RAM_ALC_INT_S	;�жϲɼ�������ԭʼAD��8λ�����ڲ�ѯ��
R_INT_AdM			equ  R_RAM_ALC_INT_S+1	;�жϲɼ�������ԭʼAD��8λ�����ڲ�ѯ��
R_INT_AdH			equ  R_RAM_ALC_INT_S+2	;�жϲɼ�������ԭʼAD��8λ�����ڲ�ѯ��
R_RAM_ALC_INT_E		equ  172h
; private

;--------------------------------------------
;   ȫ�ֱ�־λ
;--------------------------------------------
R_RAM_ALC_GLOBAL_S  equ	 173h
R_INT_AD_FLAG		equ	 R_RAM_ALC_GLOBAL_S+0
	B_GetAdc		equ	 0					;�жϲɼ���һ��AD�ı�־�����ڲ�ѯ��

;--------------------------------------------
;	���䵽CS_weight.asm��RAM��ַ�ʹ�С
;--------------------------------------------
; private
R_RAM_ALC_WT_S		equ	  17Ah
R_RAM_ALC_WT_E		equ	  R_RAM_ALC_WT_S+5
		
		
;--------------------------------------------
;   ���䵽CS_led_drv.asm��RAM��ַ�ʹ�С
;--------------------------------------------
; private
R_RAM_ALC_LD_S		equ	  180h
R_RAM_ALC_LD_E		equ	  R_RAM_ALC_WT_S+2

;--------------------------------------------
;	���䵽CS_led_mapping.asm��RAM��ַ�ʹ�С
;--------------------------------------------
; private
R_RAM_ALC_LM_S		equ	  183h
R_RAM_ALC_LM_E		equ	  R_RAM_ALC_WT_S+6
; public
R_RAM_ALC_LM_S1		equ   18ah
R_LED_BUFFER1		equ   R_RAM_ALC_LM_S1+0		;�����ʾ���ݵĻ���-�����1
R_LED_BUFFER2		equ   R_RAM_ALC_LM_S1+1		;�����ʾ���ݵĻ���-�����2
R_LED_BUFFER3		equ   R_RAM_ALC_LM_S1+2		;�����ʾ���ݵĻ���-�����3
R_LED_BUFFER4		equ   R_RAM_ALC_LM_S1+3		;�����ʾ���ݵĻ���-�����4
R_LED_BUFFER5		equ   R_RAM_ALC_LM_S1+4		;�����ʾ���ݵĻ���-��λ����
R_LED_BUFFER6		equ   R_RAM_ALC_LM_S1+5
R_LED_BUFFER7		equ   R_RAM_ALC_LM_S1+6	
R_RAM_ALC_LM_E1		equ   190h

;--------------------------------------------
;	���䵽CS_1180_com.asm��RAM��ַ�ʹ�С
;--------------------------------------------
; private
R_RAM_ALC_1180_S	equ   191h
R_RAM_ALC_1180_E	equ   R_RAM_ALC_1180_S+1



;--------------------------------------------
;	�˳����õ��ı���
;--------------------------------------------
;-------------------------25
;--------------------20



;**************************************************		//50��*�ָ�	�����ļ�˵��
;==================================================		//50��=�ָ� ���ں����ָ�
     ;---------------------------------------------		//45��-�ָ� ���ڹ��ָܷ�
     ;-------------------------							//25��-�ָ� ���ں������߹���ģ���ڲ��ֶ�
	 ;----------										//ָ��Ĳ������ο�λ��
	 ;--												//ָ��Ĳο�λ��

;--------------------20
;-------------------------25











  