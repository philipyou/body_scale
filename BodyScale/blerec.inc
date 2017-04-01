/************************************************************/
DataReadFlag			equ	    4
HistoryReadFlag         equ     5
BleConnectFlag		    equ		6	
BleDisconnecFlag		equ     7

CS_Rx_Cnt        equ    1b1h          ;接收的数据个数
CS_RDATALength   equ    1b2h
Num              equ    1b3h      





RECDATASTART     EQU    1C0H          ;接收数据缓存区起始地址
RECDATAEND       EQU    1DFH          ;接收数据缓存区接收地址


RPDATA1					equ		1BAH  ;应答数据BUFFER
RPDATA2					equ		1BBH
RPDATA3					equ		1BCH
RPDATA4					equ		1BDH
RPDATA5					equ		1BEH
RPDATA6					equ		1BFH

BLES					equ		1A0h
	TS					equ		0                   ;1命令执行成功
	TF					equ		1                   ;1命令执行失败
	CSF                 equ		2					;1命令校验错误
	BLESTATE			equ		3
     ScalesFlag              EQU     4	
	RS					equ		7                   ;1表示用户正在读取数据，不刷新数据