
;==================================================
;		IO口初始化
;==================================================
;功能：完成IO的初始化配置
;输入：无
;缓存：无
;输出：无
;==================================================
F_Init_SOC:
	 ;-------------------------	
	 ;  初始化IO
     ;-------------------------
		call	F_IO_Set
     ;-------------------------	
	 ;  初始化CPUCLK时钟
     ;-------------------------	
	 ;  10: CPUCLK=1MHz
     ;-------------------------
	    movlw   00000110b
	    movwf	MCK				;Bit2~1 M2_CK~M1_CK		
								;00：指令周期250KHz
								;01: 指令周期500KHz
	    						;10: 指令周期1MHz
	    						;11: 指令周期2MHz
	 ;-------------------------	
	 ;  初始化ram
     ;-------------------------
	    call	F_Clrf_Ram
	 ;-------------------------	
	 ;  初始化蓝牙
     ;-------------------------
	    call    Bleinit
	 ;-------------------------	
	 ;  初始化看门狗
     ;-------------------------
	    movlw   ffh
	    movwf	WDTIN			;Bit7~0 WDTIN[7:0]		
								;看门狗溢出值
	    movlw	00000000b
	    movwf	WDTCON			;Bit7 WDTEN 看门狗使能位
	    						;0:  禁止看门狗
	    						;1:  使能看门狗
	    						;Bit2~0 WDTS[2:0] WDT_CLK时钟分频
	    						;WDT_CLK = 3KHz			当WDTIN=BBH
	    						;000: WDT_CLK/256			16S
	    						;001: WDT_CLK/128			8S
								;010：WDT_CLK/64			4S
	    						;011: WDT_CLK/32			2S
	    						;100：WDT_CLK/16			1S
	    						;101: WDT_CLK/8				0.5S
	    						;110：WDT_CLK/4				0.25S
	    						;111: WDT_CLK/2				0.125S
	 ;-------------------------	
	 ;  初始化TIME0
     ;-------------------------
	    movlw   ffh
	    movwf	TM0IN			;Bit7~0 TM0IN[7:0]		
								;定时器0溢出值
	    movlw	00000000b
	    movwf	TM0CON			;Bit7 T0EN 定时器0使能位
	    						;0:  禁止定时器0
	    						;1:  使能定时器0
	    						;Bit6~4 T0RATE[2:0] 时钟分频
	    						;000: TM0CK
	    						;001: TM0CK/2
								;010：TM0CK/4
	    						;011: TM0CK/8
	    						;100：TM0CK/16
	    						;101: TM0CK/32
	    						;110：TM0CK/64
	    						;111: TM0CK/128
	    						;Bit2 T0RSTB 定时器0复位
	    						;0: 使能定时器0复位
	    						;1: 禁止定时器0复位
	    						;Bit0 T0SEL 时钟源TM0CK选择
	    						;0: CPUCLK
	    						;1: WDT（WDT打开有效）	    
	 ;-------------------------	
	 ;  初始化低电压检测
     ;-------------------------  	
	  	bcf		NETE,SILB_2		
		bcf		NETE,SILB_1	
		bcf		NETE,SILB_0		;Bit4~2 SILB[2:0]	检测条件															
								;000:	VDD>2.4V	则LBOUT=1
								;001:	VDD>2.5V
								;010:	VDD>2.6V
								;011:	VDD>2.7V
								;100:	VDD>2.8V
								;101:	VDD>3.6V
								;110:	LPD>1.20V
								;111:	VDD>3.6V
			
		bcf		NETE,LB_RST_CON	
								;Bit0   LB_RST_CON 低电复位功能
								;0: 低电复位不使能
								;1: 低电复位使能
		
		bcf		NETE,ENLB		;Bit1   ENLB 低电压检测使能信号
								;0: 低电压检测不使能
								;1: 低电压检测使能
	 ;-------------------------	
	 ;  初始化LDO (VS)
     ;-------------------------
	    bsf		NETE,LDOS_1		
	    bsf		NETE,LDOS_0		;Bit7-6	LDOS[1:0] VS电压值选择
								;00: VS=3.0V
								;01: VS=2.8V
								;10: VS=2.45V
								;11: VS=2.35V
	    
	    
	    bsf		NETF,LDOEN		;Bit5	LDOEN	VS电源使能
								;0:	不使能
								;1: 使能	  	    	
     ;-------------------------	
	 ;  初始化AD
     ;-------------------------	
	 ;  输出速率  30.5Hz
	 ;	PGA		  64
	 ;  温度补偿  90ppm
     ;-------------------------	
	 	movlw	00000000b
		movwf	NETA			;Bit7~6 SINL[1:0]
								;00：AD输入端S+ S-分别接到AIN0 AIN1
								;01：内短
								;10: 接到TEMP
								;11: AD输入端S+ S-分别接到AIN1 AIN0
			
	    						;Bit4	CM_SEL
								;0: 工作模式0
								;1: 工作模式1
			
		movlw	00000111b
		movwf	ADCON			;Bit3	ADSC	采样速率选择
								;0:	250KHz
								;1: 500KHz
								;Bit2~0	 ADM[2:0]	降采样速率（输出速率）
								;000： 3906Hz
								;001： 1953Hz
								;010： 976.5Hz
								;011： 488Hz
								;100： 244Hz
								;101： 122Hz
								;110： 61Hz
								;111： 30.5Hz
		bcf		NETF,BGID1
		bsf		NETF,BGID0		;Bit2~1	CHOPM[1:0]
								;01:  ADCON.ADSC为0时的配置
								;10:  ADCON.ADSC为1时的配置
		
		movlw	10001100b
		movwf	NETC			;Bit7~6	CHOPM[1:0]	
								;00:  ADCON.ADM[2:0]配置000 001 010时的配置
								;10:  其他情况的配置
								;Bit3~2	ADG[1:0] 输入增益
								;00:  PGA=1
								;01:  PGA=16
								;10:  PGA=64
								;11:  PGA=128
			
		movlw	01000000b
		movwf	TEMPC			;Bit7~5	TEMPC[7:5] 温度补偿选择
								;000:	0ppm
								;001:	45ppm
								;010:	90ppm
								;011:	130ppm
								;100:	0ppm
								;101:  -45ppm
								;110:  -90ppm
								;111:  -130ppm
			
			
	    bsf		NETC,ADEN       ;Bit1	ADEN
								;0: ADC不使能
								;1: ADC使能 
	    
	 ;-------------------------	
	 ;  初始化串口
     ;-------------------------
	    /*
	    movlw	01000000b		
	    movwf	SCON1			;Bit7-6	SM0 SM1 通信方式
	    						;    类型		波特率		帧长度	
								;00: 同步  cpuclk/16		  8
								;01: 异步  UARTCLK/16 /32	  10(起始、停止)	
								;10: 异步  SMOD=0 cpuclk/32   11(起始、停止、第九位)
	    						;          SMOD=1 cpuclk/16  
								;11: 异步  UARTCLK/16 /32	  11(起始、停止、第九位)
	    						;Bit4	REN 允许接收
	    						;0:  禁止接收
	    						;1： 允许接收
	    						;Bit3	TB8 发送数据第九位
	    						;Bit2	RB8 接收数据第九位，不可写
	    						;Bit0	UARTEN 串口使能
	    						;0:  不使能串口
	    						;1： 使能串口
	    movlw	00000000b		
	    movwf	SCON2			;Bit7	SMOD UARTCLK波特率选择
	    						;		ICK=16MHz
	    						;0:  9600
	    						;1： 19200
	    */						
	 ;-------------------------	
	 ;  初始化中断
     ;-------------------------	
	    
	    movlw	00000000b
	    movwf	INTF			;跟INTE相应位对应
	    movlw	10000100b		
	    movwf	INTE			;Bit7	GIE
								;0: 屏蔽中断		1: 使能中断 
								;Bit5	TM1IE
								;0: 不使能TM1中断	1: 使能TM1中断
	    						;Bit4	TM0IE
								;0: 不使能TM0中断	1: 使能TM0中断
								;Bit3	AD2IE
								;0: 不使能AD2中断	1: 使能AD2中断
	    						;Bit2	ADIE
								;0: 不使能AD中断	1: 使能AD中断
								;Bit1	E1IE
								;0: 不使能E1中断	1: 使能E1中断
	    						;Bit0	E0IE
								;0: 不使能E0中断	1: 使能E0中断
	    movlw	00000000b
	    movwf	INTF2			;跟INTE2相应位对应
	    movlw	00000001b
	    movwf	INTE2			;Bit3	RTCIE
								;0: 不使能RTC中断	1: 使能RTC中断
								;Bit1	URTIE
								;0: 不使能URT中断	1: 使能URT中断
	    						;Bit0	URRIE
								;0: 不使能URR中断	1: 使能URR中断
	 
	 ;-------------------------	
	 ;  初始化LED
     ;-------------------------	 
	    call	F_LED_init
	 
	 ;-------------------------	
	 ;  初始化1180
     ;-------------------------
	    /*
	    call	F_InitCS1180_IO
	    call	F_InitCS1180

F_TESTT:
		nop
		nop
	    call	F_ReadAdData
	    goto	F_TESTT
	    */
	    return
	    
	    
	    
;==================================================
;		IO口初始化
;==================================================
;功能：完成IO的初始化配置
;输入：无
;缓存：无
;输出：无
;==================================================
F_IO_Set:
     ;-------------------------
	 ; PT1初始化
	 ;-------------------------
	 ; PT1.3设置为数字口
	 ;
	 ;-------------------------
		/*
		movlw   1110b	
		movwf	PT1EN   		;0:输入		1:输出 
		movlw   1111b
		movwf	PT1PU   		;0:不上拉	1:上拉
		movlw	00000000b
		movwf	PT1				;0:输出低	1:输出高
		
		
		bsf		AIENB,AIENB1	;AIENB1		
								;0：定义1.3为模拟口
								;1: 定义1.3为数字口
		bcf		PT1CON,BZEN		;BZEN
								;0: PT1.2为普通IO口
								;1: PT1.2为蜂鸣器输出口
		*/
     ;-------------------------
	 ; PT2初始化
	 ;-------------------------
	 ; 
	 ;
	 ;-------------------------	
		
		movlw   11111111b
		movwf	PT2EN   		;0:输入		1:输出
		movlw   00000000b
		movwf	PT2PU   		;0:不上拉	1:上拉
		movlw	00000000b
		movwf	PT2				;0:输出低	1:输出高
		
		bsf		AIENB,AIENB2	;AIENB2		
								;0：定义2.2为模拟口
								;1: 定义2.2为数字口
		movlw	00000000b
		movwf	PT2CON			;PT2CON[X]
								;0:	 LEDEN=0 电流驱动能力3ma
								;	 LEDEN=1 电流由LED_Current控制
								;1:	         电流由LED_Current控制
		
     ;-------------------------
	 ; PT4初始化
	 ;-------------------------
	 ; 
	 ;
	 ;-------------------------	
		
		movlw   11111111b
		movwf	PT4EN   		;0:输入		1:输出
		movlw   00000000b
		movwf	PT4PU   		;0:不上拉	1:上拉
		movlw	00000000b
		movwf	PT4				;0:输出低	1:输出高
		
		bsf		AIENB,AIENB3	;AIENB3		
								;0：定义4.0/4.1为模拟口
								;1: 定义4.0/4.1为数字口	
		
		return
		
;==================================================
;		RAM初始化为00H
;==================================================
;功能：完成RAM的初始化配置(清除了488个RAM)
;输入：无
;缓存：无
;输出：无
;==================================================		
F_Clrf_Ram:
     ;-------------------------
	 ; 清零第一页80~ff的RAM
	 ;-------------------------	
		bcf		BSR,PAGE0
        bcf     BSR,IRP0
        movlw	127
	    movwf   80h
	    movlw	81h
	    movwf   FSR0	   	  	   
F_Clrf_Ram_L1:
		clrf	IND0	
	    incf    FSR0,f
	    decfsz  80h,f
	    goto    F_Clrf_Ram_L1
	 ;-------------------------
	 ; 清零第一页100~1ff的RAM
	 ;-------------------------	
	    bsf     BSR,IRP0
	    movlw	255
	    movwf   100h
	    movlw   101h
	    movwf	FSR0
F_Clrf_Ram_L2:
	  	clrf	IND0
	  	incf    FSR0,f
	  	decfsz  100h,f
	  	goto    F_Clrf_Ram_L2
	 ;-------------------------
	 ; 清零第二页80~E7的RAM
	 ;-------------------------	  	
	  	bsf		BSR,PAGE0
        bcf     BSR,IRP0
		movlw	103
	    movwf   80h
	    movlw   81h
	    movwf	FSR0
F_Clrf_Ram_L3:
	  	clrf	IND0
	  	incf    FSR0,f
	  	decfsz  80h,f
	  	goto    F_Clrf_Ram_L3
	  	
	  	bcf		BSR,PAGE0
	  	return				




