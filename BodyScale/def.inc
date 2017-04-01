
DEF_SYS_CALIDOT1	equ  1600			;第一段标定点对应的内码个数		
DEF_SYS_CALIDOT2	equ  1600			;第二段标定点对应的内码个数	
DEF_SYS_CALIDOT3	equ	 1600			;第三段标定点对应的内码个数	


;============================================
;   LED 用到的变量
;============================================
; PAGE0	前面128个RAM的分布 80H~FFH
;--------------------------------------------
; 分配到CS_function_io.asm第一段的RAM地址和大小
;--------------------------------------------
; private
R_RAM_ALC_FIO_S1	 equ  80h
R_RAM_ALC_FIO_E1	 equ  bdh

;--------------------------------------------
;   PAGE0	后面256个RAM的分布 100H~1FFH
;--------------------100h--------------------
;--------------------------------------------
; A、B、C缓存的RAM地址（特殊）
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
; 分配到CS_function_io.asm第二段的RAM地址和大小
;--------------------------------------------
R_RAM_ALC_FIO_S		equ  100h
R_RAM_ALC_FIO_E		equ  10fh
;--------------------------------------------
; 分配到CS_math.asm的RAM地址和大小
;--------------------------------------------
; private
R_RAM_ALC_MH_S		equ	  100h
R_RAM_ALC_MH_E		equ	  10fh
;--------------------------------------------
; 分配到CS_ad.asm的RAM地址和大小
;--------------------------------------------
; private
R_RAM_ALC_AD_S		equ	  110h
R_RAM_ALC_AD_E		equ	  R_RAM_ALC_AD_S+33

;--------------------------------------------
;	缓存
;--------------------------------------------
R_TEMP1				equ	  140h
R_TEMP2				equ	  141h
R_TEMP3				equ	  142h
R_TEMP4				equ	  143h

R_TEMP				equ	  144h

R_SYS_ADbufL		equ	  145h		;AD缓存
R_SYS_ADbufH		equ	  146h

R_SYS_Count			equ   147h

R_SYS_CalDot1L		equ	  148h		;标定点1低8位
R_SYS_CalDot1H		equ	  149h		;标定点1高8位
R_SYS_CalDot2L		equ	  14ah		;标定点2低8位
R_SYS_CalDot2H		equ	  14bh		;标定点2高8位
R_SYS_CalDot3L		equ	  14ch		;标定点3低8位
R_SYS_CalDot3H		equ	  14dh		;标定点3高8位

;--------------------------------------------
;   中断用到的变量
;--------------------------------------------
; public
R_RAM_ALC_INT_S		equ  170h
R_INT_AdL		 	equ  R_RAM_ALC_INT_S	;中断采集出来的原始AD低8位（用于查询）
R_INT_AdM			equ  R_RAM_ALC_INT_S+1	;中断采集出来的原始AD中8位（用于查询）
R_INT_AdH			equ  R_RAM_ALC_INT_S+2	;中断采集出来的原始AD高8位（用于查询）
R_RAM_ALC_INT_E		equ  172h
; private

;--------------------------------------------
;   全局标志位
;--------------------------------------------
R_RAM_ALC_GLOBAL_S  equ	 173h
R_INT_AD_FLAG		equ	 R_RAM_ALC_GLOBAL_S+0
	B_GetAdc		equ	 0					;中断采集完一笔AD的标志（用于查询）

;--------------------------------------------
;	分配到CS_weight.asm的RAM地址和大小
;--------------------------------------------
; private
R_RAM_ALC_WT_S		equ	  17Ah
R_RAM_ALC_WT_E		equ	  R_RAM_ALC_WT_S+5
		
		
;--------------------------------------------
;   分配到CS_led_drv.asm的RAM地址和大小
;--------------------------------------------
; private
R_RAM_ALC_LD_S		equ	  180h
R_RAM_ALC_LD_E		equ	  R_RAM_ALC_WT_S+2

;--------------------------------------------
;	分配到CS_led_mapping.asm的RAM地址和大小
;--------------------------------------------
; private
R_RAM_ALC_LM_S		equ	  183h
R_RAM_ALC_LM_E		equ	  R_RAM_ALC_WT_S+6
; public
R_RAM_ALC_LM_S1		equ   18ah
R_LED_BUFFER1		equ   R_RAM_ALC_LM_S1+0		;存放显示内容的缓存-数码管1
R_LED_BUFFER2		equ   R_RAM_ALC_LM_S1+1		;存放显示内容的缓存-数码管2
R_LED_BUFFER3		equ   R_RAM_ALC_LM_S1+2		;存放显示内容的缓存-数码管3
R_LED_BUFFER4		equ   R_RAM_ALC_LM_S1+3		;存放显示内容的缓存-数码管4
R_LED_BUFFER5		equ   R_RAM_ALC_LM_S1+4		;存放显示内容的缓存-单位符号
R_LED_BUFFER6		equ   R_RAM_ALC_LM_S1+5
R_LED_BUFFER7		equ   R_RAM_ALC_LM_S1+6	
R_RAM_ALC_LM_E1		equ   190h

;--------------------------------------------
;	分配到CS_1180_com.asm的RAM地址和大小
;--------------------------------------------
; private
R_RAM_ALC_1180_S	equ   191h
R_RAM_ALC_1180_E	equ   R_RAM_ALC_1180_S+1



;--------------------------------------------
;	乘除法用到的变量
;--------------------------------------------
;-------------------------25
;--------------------20



;**************************************************		//50个*分割	用于文件说明
;==================================================		//50个=分割 用于函数分割
     ;---------------------------------------------		//45个-分割 用于功能分割
     ;-------------------------							//25个-分割 用于函数或者功能模块内部分段
	 ;----------										//指令的操作数参考位置
	 ;--												//指令的参考位置

;--------------------20
;-------------------------25











  
