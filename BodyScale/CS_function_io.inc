;--------------------------------------------
;				Լ��
;--------------------------------------------
; 1.���ݴ洢��С��ģʽ�����ֽڸߵ�ַ�����ֽڵ͵�ַ��
; 2.���������������������100h~1ffh����
; 3.�ж���ò�Ҫ���ú���
; 4.����170��ָ��clk��ʱ�俪��

;--------------------------------------------
;	����������������õ��ı���
;--------------------------------------------
R_FIO_SEG_S			 equ  R_RAM_ALC_FIO_S
; public
R_FUNC_A0			 equ  R_FIO_SEG_S+0		 ;��������ӿڱ���A0
R_FUNC_A1			 equ  R_FIO_SEG_S+1		 ;��������ӿڱ���A1
R_FUNC_A2			 equ  R_FIO_SEG_S+2		 ;��������ӿڱ���A2
R_FUNC_A3			 equ  R_FIO_SEG_S+3		 ;��������ӿڱ���A3
R_FUNC_A4			 equ  R_FIO_SEG_S+4		 ;��������ӿڱ���A4
R_FUNC_A5			 equ  R_FIO_SEG_S+5		 ;��������ӿڱ���A5

R_FUNC_B0			 equ  R_FIO_SEG_S+6		 ;��������ӿڱ���B0
R_FUNC_B1			 equ  R_FIO_SEG_S+7		 ;��������ӿڱ���B1
R_FUNC_B2			 equ  R_FIO_SEG_S+8		 ;��������ӿڱ���B2

R_FUNC_C0			 equ  R_FIO_SEG_S+9		 ;��������ӿڱ���C0
R_FUNC_C1			 equ  R_FIO_SEG_S+10	 ;��������ӿڱ���C1
R_FUNC_C2			 equ  R_FIO_SEG_S+11	 ;��������ӿڱ���C2
R_FUNC_C3			 equ  R_FIO_SEG_S+12	 ;��������ӿڱ���C3
R_FUNC_C4			 equ  R_FIO_SEG_S+13	 ;��������ӿڱ���C4
R_FUNC_C5			 equ  R_FIO_SEG_S+14	 ;��������ӿڱ���C5
R_FUNC_RET			 equ  R_FIO_SEG_S+15	 ;��������ֵ

; private
R_FIO_SEG_S1		 equ  R_RAM_ALC_FIO_S1
R_FUNC_L1_A0		 equ  R_FIO_SEG_S1+0	 ;������һ��Ƕ�׵��ñ��ݱ���A0
R_FUNC_L1_A1		 equ  R_FIO_SEG_S1+1	 ;������һ��Ƕ�׵��ñ��ݱ���A1
R_FUNC_L1_A2		 equ  R_FIO_SEG_S1+2	 ;������һ��Ƕ�׵��ñ��ݱ���A2
R_FUNC_L1_A3		 equ  R_FIO_SEG_S1+3	 ;������һ��Ƕ�׵��ñ��ݱ���A3
R_FUNC_L1_A4		 equ  R_FIO_SEG_S1+4	 ;������һ��Ƕ�׵��ñ��ݱ���A4
R_FUNC_L1_A5		 equ  R_FIO_SEG_S1+5	 ;������һ��Ƕ�׵��ñ��ݱ���A5
R_FUNC_L1_B0		 equ  R_FIO_SEG_S1+6	 ;������һ��Ƕ�׵��ñ��ݱ���B0
R_FUNC_L1_B1		 equ  R_FIO_SEG_S1+7	 ;������һ��Ƕ�׵��ñ��ݱ���B1
R_FUNC_L1_B2		 equ  R_FIO_SEG_S1+8	 ;������һ��Ƕ�׵��ñ��ݱ���B2

R_FUNC_L2_A0		 equ  R_FIO_SEG_S1+9	 ;�����ڶ���Ƕ�׵��ñ��ݱ���A0
R_FUNC_L2_A1		 equ  R_FIO_SEG_S1+10	 ;�����ڶ���Ƕ�׵��ñ��ݱ���A1
R_FUNC_L2_A2		 equ  R_FIO_SEG_S1+11	 ;�����ڶ���Ƕ�׵��ñ��ݱ���A2
R_FUNC_L2_A3		 equ  R_FIO_SEG_S1+12	 ;�����ڶ���Ƕ�׵��ñ��ݱ���A3
R_FUNC_L2_A4		 equ  R_FIO_SEG_S1+13	 ;�����ڶ���Ƕ�׵��ñ��ݱ���A4
R_FUNC_L2_A5		 equ  R_FIO_SEG_S1+14	 ;�����ڶ���Ƕ�׵��ñ��ݱ���A5
R_FUNC_L2_B0		 equ  R_FIO_SEG_S1+15	 ;�����ڶ���Ƕ�׵��ñ��ݱ���B0
R_FUNC_L2_B1		 equ  R_FIO_SEG_S1+16	 ;�����ڶ���Ƕ�׵��ñ��ݱ���B1
R_FUNC_L2_B2		 equ  R_FIO_SEG_S1+17	 ;�����ڶ���Ƕ�׵��ñ��ݱ���B2

R_FUNC_L3_A0		 equ  R_FIO_SEG_S1+18	 ;����������Ƕ�׵��ñ��ݱ���A0
R_FUNC_L3_A1		 equ  R_FIO_SEG_S1+19	 ;����������Ƕ�׵��ñ��ݱ���A1
R_FUNC_L3_A2		 equ  R_FIO_SEG_S1+20	 ;����������Ƕ�׵��ñ��ݱ���A2
R_FUNC_L3_A3		 equ  R_FIO_SEG_S1+21	 ;����������Ƕ�׵��ñ��ݱ���A3
R_FUNC_L3_A4		 equ  R_FIO_SEG_S1+22	 ;����������Ƕ�׵��ñ��ݱ���A4
R_FUNC_L3_A5		 equ  R_FIO_SEG_S1+23	 ;����������Ƕ�׵��ñ��ݱ���A5
R_FUNC_L3_B0		 equ  R_FIO_SEG_S1+24	 ;����������Ƕ�׵��ñ��ݱ���B0
R_FUNC_L3_B1		 equ  R_FIO_SEG_S1+25	 ;����������Ƕ�׵��ñ��ݱ���B1
R_FUNC_L3_B2		 equ  R_FIO_SEG_S1+26	 ;����������Ƕ�׵��ñ��ݱ���B2

R_FUNC_L4_A0		 equ  R_FIO_SEG_S1+27	 ;�������Ĳ�Ƕ�׵��ñ��ݱ���A0
R_FUNC_L4_A1		 equ  R_FIO_SEG_S1+28	 ;�������Ĳ�Ƕ�׵��ñ��ݱ���A1
R_FUNC_L4_A2		 equ  R_FIO_SEG_S1+29	 ;�������Ĳ�Ƕ�׵��ñ��ݱ���A2
R_FUNC_L4_A3		 equ  R_FIO_SEG_S1+30	 ;�������Ĳ�Ƕ�׵��ñ��ݱ���A3
R_FUNC_L4_A4		 equ  R_FIO_SEG_S1+31	 ;�������Ĳ�Ƕ�׵��ñ��ݱ���A4
R_FUNC_L4_A5		 equ  R_FIO_SEG_S1+32	 ;�������Ĳ�Ƕ�׵��ñ��ݱ���A5
R_FUNC_L4_B0		 equ  R_FIO_SEG_S1+33	 ;�������Ĳ�Ƕ�׵��ñ��ݱ���B0
R_FUNC_L4_B1		 equ  R_FIO_SEG_S1+34	 ;�������Ĳ�Ƕ�׵��ñ��ݱ���B1
R_FUNC_L4_B2		 equ  R_FIO_SEG_S1+35	 ;�������Ĳ�Ƕ�׵��ñ��ݱ���B2

R_FUNC_L5_A0		 equ  R_FIO_SEG_S1+36	 ;���������Ƕ�׵��ñ��ݱ���A0
R_FUNC_L5_A1		 equ  R_FIO_SEG_S1+37	 ;���������Ƕ�׵��ñ��ݱ���A1
R_FUNC_L5_A2		 equ  R_FIO_SEG_S1+38	 ;���������Ƕ�׵��ñ��ݱ���A2
R_FUNC_L5_A3		 equ  R_FIO_SEG_S1+39	 ;���������Ƕ�׵��ñ��ݱ���A3
R_FUNC_L5_A4		 equ  R_FIO_SEG_S1+40	 ;���������Ƕ�׵��ñ��ݱ���A4
R_FUNC_L5_A5		 equ  R_FIO_SEG_S1+41	 ;���������Ƕ�׵��ñ��ݱ���A5
R_FUNC_L5_B0		 equ  R_FIO_SEG_S1+42	 ;���������Ƕ�׵��ñ��ݱ���B0
R_FUNC_L5_B1		 equ  R_FIO_SEG_S1+43	 ;���������Ƕ�׵��ñ��ݱ���B1
R_FUNC_L5_B2		 equ  R_FIO_SEG_S1+44	 ;���������Ƕ�׵��ñ��ݱ���B2

R_FUNC_L6_A0		 equ  R_FIO_SEG_S1+45	 ;����������Ƕ�׵��ñ��ݱ���A0
R_FUNC_L6_A1		 equ  R_FIO_SEG_S1+46	 ;����������Ƕ�׵��ñ��ݱ���A1
R_FUNC_L6_A2		 equ  R_FIO_SEG_S1+47	 ;����������Ƕ�׵��ñ��ݱ���A2
R_FUNC_L6_A3		 equ  R_FIO_SEG_S1+48	 ;����������Ƕ�׵��ñ��ݱ���A3
R_FUNC_L6_A4		 equ  R_FIO_SEG_S1+49	 ;����������Ƕ�׵��ñ��ݱ���A4
R_FUNC_L6_A5		 equ  R_FIO_SEG_S1+50	 ;����������Ƕ�׵��ñ��ݱ���A5
R_FUNC_L6_B0		 equ  R_FIO_SEG_S1+51	 ;����������Ƕ�׵��ñ��ݱ���B0
R_FUNC_L6_B1		 equ  R_FIO_SEG_S1+52	 ;����������Ƕ�׵��ñ��ݱ���B1
R_FUNC_L6_B2		 equ  R_FIO_SEG_S1+53	 ;����������Ƕ�׵��ñ��ݱ���B2

R_FUNC_BAK_A0		 equ  R_FIO_SEG_S1+54	 ;�������A0��Ӱ�ӼĴ���
R_FUNC_BAK_A1		 equ  R_FIO_SEG_S1+55	 ;�������A1��Ӱ�ӼĴ���
R_FUNC_BAK_A2		 equ  R_FIO_SEG_S1+56	 ;�������A2��Ӱ�ӼĴ���
R_FUNC_BAK_A3		 equ  R_FIO_SEG_S1+57	 ;�������A3��Ӱ�ӼĴ���
R_FUNC_BAK_A4		 equ  R_FIO_SEG_S1+58	 ;�������A4��Ӱ�ӼĴ���
R_FUNC_BAK_A5		 equ  R_FIO_SEG_S1+59	 ;�������A5��Ӱ�ӼĴ���

R_FUNC_LEVEL		 equ  R_FIO_SEG_S1+60	 ;���溯�����ò�����1��ʼ
R_FUNC_COUNT		 equ  R_FIO_SEG_S1+61	 ;�������������������

;==================================================
;		��_���뺯����ڲ���
;==================================================
;���ܣ������׵�ַram_add_s����len��������R_FUNC_A0~5
;	   ram_add_s��ַ����
;	   ����˳�����δ�R_FUNC_A0��R_FUNC_A5
;
;������ram_add_s	�������ݵ��׵�ַ
;	   len			��������ݵĸ���
;==================================================
mcinA	macro	ram_add_s , len
		movlw	ram_add_s
		movwf	FSR0
		movlw	len
		call	F_Input_ParameterA
		endm

;==================================================
;		��_���뺯����ڲ���
;==================================================
;���ܣ������׵�ַram_add_s����len��������R_FUNC_A0~5
;	   ram_add_s��ַ����
;	   ����˳�����δ�R_FUNC_A0��R_FUNC_A5
;
;������ram_add_s	�������ݵ��׵�ַ
;	   len			��������ݵĸ���
;==================================================
mcinB	macro	ram_add_s , len
		movlw	ram_add_s
		movwf	FSR0
		movlw	len
		call	F_Input_ParameterB
		endm

;==================================================
;		��_�����������ڲ���
;==================================================
;���ܣ�����R_FUNC_C0~5���׵�ַram_add_s��len��������
;	   ram_add_s��ַ����
;	   ����˳�����δ�R_FUNC_C0��R_FUNC_C5
;
;������ram_add_s	�������ݵ��׵�ַ
;	   len			���������ݵĸ���
;==================================================
mcout   macro	ram_add_s , len
		movlw	ram_add_s
		movwf	FSR0
		movlw	len
		call	F_Output_ParameterC
		endm


;==================================================
;		��_����������ĺ�������
;==================================================
;���ܣ������������������
;
;������f_fuc	���ú�����
;	   f_in		��������׵�ַ
;	   len_in   ��������ĳ��ȣ��ֽڣ�
;==================================================
fcall	macro	f_fuc,f_in,len_in
		call	F_Input_ParameterBakup
		mcinA	f_in,len_in		
		call	f_fuc
		call	F_Input_ParameterRestore
		endm

;==================================================
;		��_���������ĺ�������
;==================================================
;���ܣ�������������ĺ�������
;
;������f_fuc	���ú�����
;	   f1		��һ��������
;	   f2		��һ��������
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
;		��_��������������ĺ�������
;==================================================
;���ܣ����������������������
;
;������f_fuc	���ú�����
;	   f_in		��������׵�ַ
;	   len_in   ��������ĳ��ȣ��ֽڣ�
;      f_out    ��������׵�ַ
;	   len_out  ��������ĳ��ȣ��ֽڣ�
;==================================================
fcall1	macro	f_fuc,f_in,len_in,f_out,len_out
		call	F_Input_ParameterBakup
		mcinA	f_in,len_in
		call	f_fuc
		call	F_Input_ParameterRestore
		mcout	f_out,len_out
		endm

;==================================================
;		��_��������������ĺ�������
;==================================================
;���ܣ����������������������
;
;������f_fuc	���ú�����
;	   f_in		�������A�׵�ַ
;	   len_in   �������A�ĳ��ȣ��ֽڣ�
;	   f_in1	�������B�׵�ַ
;	   len_in1  �������B�ĳ��ȣ��ֽ�
;      f_out    ��������׵�ַ
;	   len_out  ��������ĳ��ȣ��ֽڣ�
;==================================================
fcall2	macro	f_fuc,f_in,len_in,f_in1,len_in1,f_out,len_out
		call	F_Input_ParameterBakup
		mcinA	f_in,len_in
		mcinB	f_in1,len_in1
		call	f_fuc
		call	F_Input_ParameterRestore
		mcout	f_out,len_out
		endm


