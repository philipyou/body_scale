/************************************************************/
DataReadFlag			equ	    4
HistoryReadFlag         equ     5
BleConnectFlag		    equ		6	
BleDisconnecFlag		equ     7

CS_Rx_Cnt        equ    1b1h          ;���յ����ݸ���
CS_RDATALength   equ    1b2h
Num              equ    1b3h      





RECDATASTART     EQU    1C0H          ;�������ݻ�������ʼ��ַ
RECDATAEND       EQU    1DFH          ;�������ݻ��������յ�ַ


RPDATA1					equ		1BAH  ;Ӧ������BUFFER
RPDATA2					equ		1BBH
RPDATA3					equ		1BCH
RPDATA4					equ		1BDH
RPDATA5					equ		1BEH
RPDATA6					equ		1BFH

BLES					equ		1A0h
	TS					equ		0                   ;1����ִ�гɹ�
	TF					equ		1                   ;1����ִ��ʧ��
	CSF                 equ		2					;1����У�����
	BLESTATE			equ		3
     ScalesFlag              EQU     4	
	RS					equ		7                   ;1��ʾ�û����ڶ�ȡ���ݣ���ˢ������