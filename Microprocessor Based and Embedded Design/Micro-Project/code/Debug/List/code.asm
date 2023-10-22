
;CodeVisionAVR C Compiler V3.14 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega32
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 512 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega32
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2048
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x085F
	.EQU __DSTACK_SIZE=0x0200
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF __lcd_x=R5
	.DEF __lcd_y=R4
	.DEF __lcd_maxx=R7

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0x20:
	.DB  0x1,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0xA,0x0,0xA,0x0
_0x0:
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x0,0x20,0x55,0x73,0x65,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x0,0x20,0x4B,0x65,0x79
	.DB  0x50,0x61,0x64,0x20,0x20,0x20,0x0,0x20
	.DB  0x54,0x65,0x6D,0x70,0x28,0x43,0x29,0x20
	.DB  0x20,0x0,0x20,0x3E,0x35,0x30,0x43,0x20
	.DB  0x20,0x20,0x20,0x20,0x0,0x20,0x25,0x64
	.DB  0x43,0x20,0x20,0x20,0x20,0x20,0x20,0x0
	.DB  0x20,0x54,0x65,0x6D,0x70,0x28,0x46,0x29
	.DB  0x20,0x20,0x0,0x20,0x3E,0x31,0x32,0x32
	.DB  0x46,0x20,0x20,0x20,0x20,0x0,0x20,0x25
	.DB  0x64,0x46,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x0,0x20,0x54,0x65,0x6D,0x70,0x28,0x4B
	.DB  0x29,0x20,0x20,0x0,0x20,0x3E,0x33,0x32
	.DB  0x33,0x4B,0x20,0x20,0x20,0x20,0x0,0x20
	.DB  0x25,0x64,0x4B,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x0,0x20,0x4C,0x69,0x67,0x68,0x74
	.DB  0x20,0x20,0x20,0x20,0x0,0x20,0x3E,0x33
	.DB  0x33,0x75,0x57,0x2F,0x63,0x6D,0x32,0x20
	.DB  0x0,0x20,0x25,0x64,0x75,0x57,0x2F,0x63
	.DB  0x6D,0x32,0x20,0x0,0x20,0x44,0x69,0x73
	.DB  0x74,0x2E,0x20,0x20,0x20,0x20,0x0,0x20
	.DB  0x3C,0x36,0x35,0x63,0x6D,0x20,0x20,0x20
	.DB  0x20,0x20,0x0,0x20,0x25,0x64,0x63,0x6D
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x0,0x20
	.DB  0x3C,0x31,0x36,0x35,0x69,0x6E,0x63,0x68
	.DB  0x20,0x0,0x20,0x25,0x64,0x69,0x6E,0x63
	.DB  0x68,0x20,0x20,0x20,0x20,0x0
_0x2020060:
	.DB  0x1
_0x2020000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0
_0x2040003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x19
	.DW  _0x36
	.DW  _0x0*2

	.DW  0x19
	.DW  _0x36+25
	.DW  _0x0*2

	.DW  0x02
	.DW  _0x36+50
	.DW  _0x0*2+23

	.DW  0x01
	.DW  __seed_G101
	.DW  _0x2020060*2

	.DW  0x02
	.DW  __base_y_G102
	.DW  _0x2040003*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x260

	.CSEG
;/*******************************************************
;This program was created by the
;CodeWizardAVR V3.14 Advanced
;Automatic Program Generator
;� Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project : Micro - Final Project
;Version :
;Date    : 28/Jun/2023
;Author  : Mahdi Abdolhosseini - Javad Shamsaei
;Company :
;Comments:
;
;
;Chip type               : ATmega32
;Program type            : Application
;AVR Core Clock frequency: 8.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 512
;*******************************************************/
;
;#include <mega32.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;#include <stdio.h>
;#include <stdlib.h>
;#include <alcd.h> // Alphanumeric LCD functions
;
;// Voltage Reference: Int., cap. on AREF
;#define ADC_VREF_TYPE ((1<<REFS1) | (1<<REFS0) | (0<<ADLAR))
;
;//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= Read the AD conversion result
;unsigned char read_adc(unsigned char adc_input)
; 0000 0023 {

	.CSEG
_read_adc:
; .FSTART _read_adc
; 0000 0024     ADMUX=adc_input | ADC_VREF_TYPE;
	ST   -Y,R26
;	adc_input -> Y+0
	LD   R30,Y
	ORI  R30,LOW(0xC0)
	OUT  0x7,R30
; 0000 0025     // Delay needed for the stabilization of the ADC input voltage
; 0000 0026     delay_us(10);
	__DELAY_USB 27
; 0000 0027     // Start the AD conversion
; 0000 0028     ADCSRA|=(1<<ADSC);
	SBI  0x6,6
; 0000 0029     // Wait for the AD conversion to complete
; 0000 002A     while ((ADCSRA & (1<<ADIF))==0);
_0x3:
	SBIS 0x6,4
	RJMP _0x3
; 0000 002B     ADCSRA|=(1<<ADIF);
	SBI  0x6,4
; 0000 002C     return ADCW;
	IN   R30,0x4
	IN   R31,0x4+1
	ADIW R28,1
	RET
; 0000 002D }
; .FEND
;
;//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= keyboard handler:
;int keyboard(){
; 0000 0030 int keyboard(){
_keyboard:
; .FSTART _keyboard
; 0000 0031     int key=20;
; 0000 0032     //---- ROW1 ----
; 0000 0033     PORTD.3=0;
	ST   -Y,R17
	ST   -Y,R16
;	key -> R16,R17
	__GETWRN 16,17,20
	CBI  0x12,3
; 0000 0034     delay_ms(2);
	CALL SUBOPT_0x0
; 0000 0035     if(PIND.0==0) key=1;
	SBIC 0x10,0
	RJMP _0x8
	__GETWRN 16,17,1
; 0000 0036     if(PIND.1==0) key=2;
_0x8:
	SBIC 0x10,1
	RJMP _0x9
	__GETWRN 16,17,2
; 0000 0037     if(PIND.2==0) key=3;
_0x9:
	SBIC 0x10,2
	RJMP _0xA
	__GETWRN 16,17,3
; 0000 0038     PORTD.3=1;
_0xA:
	SBI  0x12,3
; 0000 0039     //---- ROW2 ----
; 0000 003A     PORTD.4=0;
	CBI  0x12,4
; 0000 003B     delay_ms(2);
	CALL SUBOPT_0x0
; 0000 003C     if(PIND.0==0) key=4;
	SBIC 0x10,0
	RJMP _0xF
	__GETWRN 16,17,4
; 0000 003D     if(PIND.1==0) key=5;
_0xF:
	SBIC 0x10,1
	RJMP _0x10
	__GETWRN 16,17,5
; 0000 003E     if(PIND.2==0) key=6;
_0x10:
	SBIC 0x10,2
	RJMP _0x11
	__GETWRN 16,17,6
; 0000 003F     PORTD.4=1;
_0x11:
	SBI  0x12,4
; 0000 0040     //---- ROW3 ----
; 0000 0041     PORTD.5=0;
	CBI  0x12,5
; 0000 0042     delay_ms(2);
	CALL SUBOPT_0x0
; 0000 0043     if(PIND.0==0) key=7;
	SBIC 0x10,0
	RJMP _0x16
	__GETWRN 16,17,7
; 0000 0044     if(PIND.1==0) key=8;
_0x16:
	SBIC 0x10,1
	RJMP _0x17
	__GETWRN 16,17,8
; 0000 0045     if(PIND.2==0) key=9;
_0x17:
	SBIC 0x10,2
	RJMP _0x18
	__GETWRN 16,17,9
; 0000 0046     PORTD.5=1;
_0x18:
	SBI  0x12,5
; 0000 0047     //---- ROW4 ----
; 0000 0048     PORTD.6=0;
	CBI  0x12,6
; 0000 0049     delay_ms(2);
	CALL SUBOPT_0x0
; 0000 004A     if(PIND.1==0) key=0;
	SBIC 0x10,1
	RJMP _0x1D
	__GETWRN 16,17,0
; 0000 004B     PORTD.6=1;
_0x1D:
	SBI  0x12,6
; 0000 004C 
; 0000 004D     return key;
	MOVW R30,R16
	LD   R16,Y+
	LD   R17,Y+
	RET
; 0000 004E } //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; .FEND
;
;#define LCD_WIDTH 16 // LCD has 16 columns
;
;void main(void){
; 0000 0052 void main(void){
_main:
; .FSTART _main
; 0000 0053     // Declare your local variables here
; 0000 0054     unsigned char temp;
; 0000 0055     unsigned char light;
; 0000 0056     unsigned char distance;
; 0000 0057 
; 0000 0058     char s[15];
; 0000 0059     int key = 20;
; 0000 005A     int flag = 10;
; 0000 005B     int backupFlag = 10;
; 0000 005C 
; 0000 005D     int doAnimate = 0;
; 0000 005E     int doLEDanimate = 0;
; 0000 005F     int x = 0; // Initial x position
; 0000 0060     int y = 0; // Initial y position
; 0000 0061     int direction = 1; // Initial direction (1: right, -1: left)
; 0000 0062 
; 0000 0063     // Input/Output Ports initialization
; 0000 0064     // Port A initialization
; 0000 0065     // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0066     DDRA = (0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
	SBIW R28,29
	LDI  R24,14
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x20*2)
	LDI  R31,HIGH(_0x20*2)
	CALL __INITLOCB
;	temp -> R17
;	light -> R16
;	distance -> R19
;	s -> Y+14
;	key -> R20,R21
;	flag -> Y+12
;	backupFlag -> Y+10
;	doAnimate -> Y+8
;	doLEDanimate -> Y+6
;	x -> Y+4
;	y -> Y+2
;	direction -> Y+0
	__GETWRN 20,21,20
	LDI  R30,LOW(0)
	OUT  0x1A,R30
; 0000 0067     // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0068     PORTA = (0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0 ...
	OUT  0x1B,R30
; 0000 0069 
; 0000 006A     // Port B initialization
; 0000 006B     // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 006C     DDRB = (0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	OUT  0x17,R30
; 0000 006D     // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 006E     PORTB = (0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0 ...
	OUT  0x18,R30
; 0000 006F 
; 0000 0070     // Port C initialization
; 0000 0071     // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=In Bit2=Out Bit1=Out Bit0=Out
; 0000 0072     DDRC = (1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (0<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
	LDI  R30,LOW(247)
	OUT  0x14,R30
; 0000 0073     // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=T Bit2=0 Bit1=0 Bit0=0
; 0000 0074     PORTC = (0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0 ...
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0000 0075 
; 0000 0076     // Port D initialization
; 0000 0077     // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0078     DDRD = (0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	OUT  0x11,R30
; 0000 0079     // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 007A     PORTD = (0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0 ...
	OUT  0x12,R30
; 0000 007B 
; 0000 007C     // Timer/Counter 0 initialization
; 0000 007D     // Clock source: System Clock
; 0000 007E     // Clock value: Timer 0 Stopped
; 0000 007F     // Mode: Normal top=0xFF
; 0000 0080     // OC0 output: Disconnected
; 0000 0081     TCCR0 = (0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (0<<CS01) | (0<<CS00);
	OUT  0x33,R30
; 0000 0082     TCNT0 = 0x00;
	OUT  0x32,R30
; 0000 0083     OCR0 = 0x00;
	OUT  0x3C,R30
; 0000 0084 
; 0000 0085     // Timer/Counter 1 initialization
; 0000 0086     // Clock source: System Clock
; 0000 0087     // Clock value: Timer1 Stopped
; 0000 0088     // Mode: Normal top=0xFFFF
; 0000 0089     // OC1A output: Disconnected
; 0000 008A     // OC1B output: Disconnected
; 0000 008B     // Noise Canceler: Off
; 0000 008C     // Input Capture on Falling Edge
; 0000 008D     // Timer1 Overflow Interrupt: Off
; 0000 008E     // Input Capture Interrupt: Off
; 0000 008F     // Compare A Match Interrupt: Off
; 0000 0090     // Compare B Match Interrupt: Off
; 0000 0091     TCCR1A = (0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	OUT  0x2F,R30
; 0000 0092     TCCR1B = (0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
	OUT  0x2E,R30
; 0000 0093     TCNT1H = 0x00;
	OUT  0x2D,R30
; 0000 0094     TCNT1L = 0x00;
	OUT  0x2C,R30
; 0000 0095     ICR1H = 0x00;
	OUT  0x27,R30
; 0000 0096     ICR1L = 0x00;
	OUT  0x26,R30
; 0000 0097     OCR1AH = 0x00;
	OUT  0x2B,R30
; 0000 0098     OCR1AL = 0x00;
	OUT  0x2A,R30
; 0000 0099     OCR1BH = 0x00;
	OUT  0x29,R30
; 0000 009A     OCR1BL = 0x00;
	OUT  0x28,R30
; 0000 009B 
; 0000 009C     // Timer/Counter 2 initialization
; 0000 009D     // Clock source: System Clock
; 0000 009E     // Clock value: Timer2 Stopped
; 0000 009F     // Mode: Normal top=0xFF
; 0000 00A0     // OC2 output: Disconnected
; 0000 00A1     ASSR = 0<<AS2;
	OUT  0x22,R30
; 0000 00A2     TCCR2 = (0<<PWM2) | (0<<COM21) | (0<<COM20) | (0<<CTC2) | (0<<CS22) | (0<<CS21) | (0<<CS20);
	OUT  0x25,R30
; 0000 00A3     TCNT2 = 0x00;
	OUT  0x24,R30
; 0000 00A4     OCR2 = 0x00;
	OUT  0x23,R30
; 0000 00A5 
; 0000 00A6     // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 00A7     TIMSK = (0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);
	OUT  0x39,R30
; 0000 00A8 
; 0000 00A9     // External Interrupt(s) initialization
; 0000 00AA     // INT0: Off
; 0000 00AB     // INT1: Off
; 0000 00AC     // INT2: Off
; 0000 00AD     MCUCR = (0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	OUT  0x35,R30
; 0000 00AE     MCUCSR = (0<<ISC2);
	OUT  0x34,R30
; 0000 00AF 
; 0000 00B0     // USART initialization
; 0000 00B1     // USART disabled
; 0000 00B2     UCSRB = (0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
	OUT  0xA,R30
; 0000 00B3 
; 0000 00B4     // Analog Comparator initialization
; 0000 00B5     // Analog Comparator: Off
; 0000 00B6     // The Analog Comparator's positive input is
; 0000 00B7     // connected to the AIN0 pin
; 0000 00B8     // The Analog Comparator's negative input is
; 0000 00B9     // connected to the AIN1 pin
; 0000 00BA     ACSR = (1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 00BB 
; 0000 00BC     // ADC initialization
; 0000 00BD     // ADC Clock frequency: 125.000 kHz
; 0000 00BE     // ADC Voltage Reference: Int., cap. on AREF
; 0000 00BF     // ADC Auto Trigger Source: ADC Stopped
; 0000 00C0     ADMUX = ADC_VREF_TYPE;
	LDI  R30,LOW(192)
	OUT  0x7,R30
; 0000 00C1     ADCSRA = (1<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (1<<ADPS2) | (1<<ADPS1) | (0<<ADPS0);
	LDI  R30,LOW(134)
	OUT  0x6,R30
; 0000 00C2     SFIOR = (0<<ADTS2) | (0<<ADTS1) | (0<<ADTS0);
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 00C3 
; 0000 00C4     // SPI initialization
; 0000 00C5     // SPI disabled
; 0000 00C6     SPCR = (0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	OUT  0xD,R30
; 0000 00C7 
; 0000 00C8     // TWI initialization
; 0000 00C9     // TWI disabled
; 0000 00CA     TWCR = (0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);
	OUT  0x36,R30
; 0000 00CB 
; 0000 00CC     // Alphanumeric LCD initialization
; 0000 00CD     // Connections are specified in the
; 0000 00CE     // Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
; 0000 00CF     // RS - PORTC Bit 0
; 0000 00D0     // RD - PORTC Bit 1
; 0000 00D1     // EN - PORTC Bit 2
; 0000 00D2     // D4 - PORTC Bit 4
; 0000 00D3     // D5 - PORTC Bit 5
; 0000 00D4     // D6 - PORTC Bit 6
; 0000 00D5     // D7 - PORTC Bit 7
; 0000 00D6     // Characters/line: 16
; 0000 00D7     lcd_init(16);
	LDI  R26,LOW(16)
	CALL _lcd_init
; 0000 00D8 
; 0000 00D9     PORTC = 0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0000 00DA     DDRC = 0xF7;
	LDI  R30,LOW(247)
	OUT  0x14,R30
; 0000 00DB     ADMUX = ADC_VREF_TYPE & 0xff;
	LDI  R30,LOW(192)
	OUT  0x7,R30
; 0000 00DC     ADCSRA = 0x83;
	LDI  R30,LOW(131)
	OUT  0x6,R30
; 0000 00DD 
; 0000 00DE     DDRD = 0xf8;
	LDI  R30,LOW(248)
	OUT  0x11,R30
; 0000 00DF     PORTD = 0xf8;
	OUT  0x12,R30
; 0000 00E0     DDRB = 0xff;
	LDI  R30,LOW(255)
	OUT  0x17,R30
; 0000 00E1     PORTB = 0xf8;
	LDI  R30,LOW(248)
	OUT  0x18,R30
; 0000 00E2     DDRA.3 = 1;
	SBI  0x1A,3
; 0000 00E3     DDRA.4 = 1;
	SBI  0x1A,4
; 0000 00E4     DDRA.5 = 1;
	SBI  0x1A,5
; 0000 00E5     DDRA.6 = 1;
	SBI  0x1A,6
; 0000 00E6 
; 0000 00E7     DDRA.7 = 1;
	SBI  0x1A,7
; 0000 00E8     DDRD.7 = 1;
	SBI  0x11,7
; 0000 00E9     DDRC.3 = 1;
	SBI  0x14,3
; 0000 00EA 
; 0000 00EB     while (1){
_0x2F:
; 0000 00EC 
; 0000 00ED         // analog signals input
; 0000 00EE         temp = read_adc(0);
	LDI  R26,LOW(0)
	RCALL _read_adc
	MOV  R17,R30
; 0000 00EF         light = read_adc(1);
	LDI  R26,LOW(1)
	RCALL _read_adc
	MOV  R16,R30
; 0000 00F0         distance = read_adc(2);
	LDI  R26,LOW(2)
	RCALL _read_adc
	MOV  R19,R30
; 0000 00F1 
; 0000 00F2         key=keyboard(); // keypad input
	RCALL _keyboard
	MOVW R20,R30
; 0000 00F3 
; 0000 00F4         //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= handle keypad input:
; 0000 00F5         if (key != 20){
	LDI  R30,LOW(20)
	LDI  R31,HIGH(20)
	CP   R30,R20
	CPC  R31,R21
	BRNE PC+2
	RJMP _0x32
; 0000 00F6             if (key == 7 || key == 8 || key == 9) {backupFlag = flag;}
	LDI  R30,LOW(7)
	LDI  R31,HIGH(7)
	CP   R30,R20
	CPC  R31,R21
	BREQ _0x34
	CALL SUBOPT_0x1
	BREQ _0x34
	CALL SUBOPT_0x2
	BRNE _0x33
_0x34:
	LDD  R30,Y+12
	LDD  R31,Y+12+1
	STD  Y+10,R30
	STD  Y+10+1,R31
; 0000 00F7 
; 0000 00F8             flag = key;
_0x33:
	__PUTWSR 20,21,12
; 0000 00F9 
; 0000 00FA             lcd_gotoxy(0, 0);
	LDI  R30,LOW(0)
	CALL SUBOPT_0x3
; 0000 00FB             lcd_puts("                        ");
	__POINTW2MN _0x36,0
	CALL _lcd_puts
; 0000 00FC             lcd_gotoxy(0, 1);
	LDI  R30,LOW(0)
	CALL SUBOPT_0x4
; 0000 00FD             lcd_puts("                        ");
	__POINTW2MN _0x36,25
	CALL _lcd_puts
; 0000 00FE 
; 0000 00FF             PORTB = 0x00;
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0000 0100             PORTA.3 = 0;
	CBI  0x1B,3
; 0000 0101             PORTA.4 = 0;
	CBI  0x1B,4
; 0000 0102             PORTA.5 = 0;
	CBI  0x1B,5
; 0000 0103             PORTA.6 = 0;
	CBI  0x1B,6
; 0000 0104 
; 0000 0105             // update 7-segments
; 0000 0106             if (key == 1) { PORTA.6 = 1;}
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R20
	CPC  R31,R21
	BREQ _0xBF
; 0000 0107             else if (key == 2) {PORTA.5 = 1;}
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CP   R30,R20
	CPC  R31,R21
	BRNE _0x43
	SBI  0x1B,5
; 0000 0108             else if (key == 3) {PORTA.5 = 1; PORTA.6 = 1;}
	RJMP _0x46
_0x43:
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	CP   R30,R20
	CPC  R31,R21
	BRNE _0x47
	SBI  0x1B,5
	RJMP _0xBF
; 0000 0109             else if (key == 4) {PORTA.4 = 1;}
_0x47:
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	CP   R30,R20
	CPC  R31,R21
	BRNE _0x4D
	SBI  0x1B,4
; 0000 010A             else if (key == 5) {PORTA.4 = 1; PORTA.6 = 1;}
	RJMP _0x50
_0x4D:
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	CP   R30,R20
	CPC  R31,R21
	BRNE _0x51
	SBI  0x1B,4
	RJMP _0xBF
; 0000 010B             else if (key == 6) {PORTA.4 = 1; PORTA.5 = 1;}
_0x51:
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	CP   R30,R20
	CPC  R31,R21
	BRNE _0x57
	SBI  0x1B,4
	SBI  0x1B,5
; 0000 010C             else if (key == 7) {PORTA.4 = 1; PORTA.5 = 1; PORTA.6 = 1;}
	RJMP _0x5C
_0x57:
	LDI  R30,LOW(7)
	LDI  R31,HIGH(7)
	CP   R30,R20
	CPC  R31,R21
	BRNE _0x5D
	SBI  0x1B,4
	SBI  0x1B,5
	RJMP _0xBF
; 0000 010D             else if (key == 8) {PORTA.3 = 1;}
_0x5D:
	CALL SUBOPT_0x1
	BRNE _0x65
	SBI  0x1B,3
; 0000 010E             else if (key == 9) {PORTA.3 = 1; PORTA.6 = 1;}
	RJMP _0x68
_0x65:
	CALL SUBOPT_0x2
	BRNE _0x69
	SBI  0x1B,3
_0xBF:
	SBI  0x1B,6
; 0000 010F         }
_0x69:
_0x68:
_0x5C:
_0x50:
_0x46:
; 0000 0110 
; 0000 0111         //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= handle LCD:
; 0000 0112         if (flag == 10 || flag == 0){
_0x32:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	SBIW R26,10
	BREQ _0x6F
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	SBIW R26,0
	BRNE _0x6E
_0x6F:
; 0000 0113             sprintf(s, " Use      ");
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,25
	CALL SUBOPT_0x6
; 0000 0114             lcd_gotoxy(x, 0);
	CALL SUBOPT_0x3
; 0000 0115             lcd_puts(s);
	CALL SUBOPT_0x7
; 0000 0116             sprintf(s, " KeyPad   ");
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,36
	CALL SUBOPT_0x6
; 0000 0117             lcd_gotoxy(x, 1);
	CALL SUBOPT_0x4
; 0000 0118             lcd_puts(s);
	CALL SUBOPT_0x7
; 0000 0119         } //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; 0000 011A         else if(flag == 1){
	RJMP _0x71
_0x6E:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	SBIW R26,1
	BRNE _0x72
; 0000 011B             if( temp/4 > 49){
	CALL SUBOPT_0x8
	SBIW R30,50
	BRLT _0x73
; 0000 011C                 sprintf(s, " Temp(C)  ");
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,47
	CALL SUBOPT_0x6
; 0000 011D                 lcd_gotoxy(x, 0);
	CALL SUBOPT_0x3
; 0000 011E                 lcd_puts(s);
	CALL SUBOPT_0x7
; 0000 011F                 sprintf(s, " >50C     ");
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,58
	CALL SUBOPT_0x9
; 0000 0120                 lcd_gotoxy(x, 1);
	RJMP _0xC0
; 0000 0121                 lcd_puts(s);
; 0000 0122             }
; 0000 0123             else{
_0x73:
; 0000 0124                 sprintf(s, " Temp(C)  ");
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,47
	CALL SUBOPT_0x6
; 0000 0125                 lcd_gotoxy(x, 0);
	CALL SUBOPT_0x3
; 0000 0126                 lcd_puts(s);
	CALL SUBOPT_0x7
; 0000 0127                 sprintf(s, " %dC      ", temp/4);
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,69
	CALL SUBOPT_0xA
	CALL SUBOPT_0xB
; 0000 0128                 lcd_gotoxy(x, 1);
_0xC0:
	LDD  R30,Y+4
	CALL SUBOPT_0x4
; 0000 0129                 lcd_puts(s);
	CALL SUBOPT_0x7
; 0000 012A                 }
; 0000 012B                 PORTB.2 = 1;
	SBI  0x18,2
; 0000 012C         } //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; 0000 012D         else if(flag == 2){
	RJMP _0x77
_0x72:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	SBIW R26,2
	BRNE _0x78
; 0000 012E             if( temp/4 > 49){
	CALL SUBOPT_0x8
	SBIW R30,50
	BRLT _0x79
; 0000 012F                 sprintf(s, " Temp(F)  ");
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,80
	CALL SUBOPT_0x6
; 0000 0130                 lcd_gotoxy(x, 0);
	CALL SUBOPT_0x3
; 0000 0131                 lcd_puts(s);
	CALL SUBOPT_0x7
; 0000 0132                 sprintf(s, " >122F    ");
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,91
	CALL SUBOPT_0x9
; 0000 0133                 lcd_gotoxy(x, 1);
	RJMP _0xC1
; 0000 0134                 lcd_puts(s);
; 0000 0135             }
; 0000 0136             else{
_0x79:
; 0000 0137                 sprintf(s, " Temp(F)  ");
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,80
	CALL SUBOPT_0x6
; 0000 0138                 lcd_gotoxy(x, 0);
	CALL SUBOPT_0x3
; 0000 0139                 lcd_puts(s);
	CALL SUBOPT_0x7
; 0000 013A                 sprintf(s, " %dF      ", ((temp/4)*(9))/5 + 32);
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,102
	CALL SUBOPT_0xA
	LDI  R26,LOW(9)
	LDI  R27,HIGH(9)
	CALL __MULW12
	MOVW R26,R30
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	CALL __DIVW21
	ADIW R30,32
	CALL SUBOPT_0xB
; 0000 013B                 lcd_gotoxy(x, 1);
_0xC1:
	LDD  R30,Y+4
	CALL SUBOPT_0x4
; 0000 013C                 lcd_puts(s);
	CALL SUBOPT_0x7
; 0000 013D             }
; 0000 013E             PORTB.2 = 1;
	SBI  0x18,2
; 0000 013F         } //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; 0000 0140         else if(flag == 3){
	RJMP _0x7D
_0x78:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	SBIW R26,3
	BRNE _0x7E
; 0000 0141             if( temp/4 > 49){
	CALL SUBOPT_0x8
	SBIW R30,50
	BRLT _0x7F
; 0000 0142                 sprintf(s, " Temp(K)  ");
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,113
	CALL SUBOPT_0x6
; 0000 0143                 lcd_gotoxy(x, 0);
	CALL SUBOPT_0x3
; 0000 0144                 lcd_puts(s);
	CALL SUBOPT_0x7
; 0000 0145                 sprintf(s, " >323K    ");
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,124
	CALL SUBOPT_0x9
; 0000 0146                 lcd_gotoxy(x, 1);
	RJMP _0xC2
; 0000 0147                 lcd_puts(s);
; 0000 0148             }
; 0000 0149             else{
_0x7F:
; 0000 014A                 sprintf(s, " Temp(K)  ");
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,113
	CALL SUBOPT_0x6
; 0000 014B                 lcd_gotoxy(x, 0);
	CALL SUBOPT_0x3
; 0000 014C                 lcd_puts(s);
	CALL SUBOPT_0x7
; 0000 014D                 sprintf(s, " %dK      ", (temp/4) + 273);
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,135
	CALL SUBOPT_0xA
	SUBI R30,LOW(-273)
	SBCI R31,HIGH(-273)
	CALL SUBOPT_0xB
; 0000 014E                 lcd_gotoxy(x, 1);
_0xC2:
	LDD  R30,Y+4
	CALL SUBOPT_0x4
; 0000 014F                 lcd_puts(s);
	CALL SUBOPT_0x7
; 0000 0150             }
; 0000 0151             PORTB.2=1;
	SBI  0x18,2
; 0000 0152         } //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; 0000 0153         else if(flag == 4){
	RJMP _0x83
_0x7E:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	SBIW R26,4
	BRNE _0x84
; 0000 0154             if( light/6 > 32){
	CALL SUBOPT_0xC
	SBIW R30,33
	BRLT _0x85
; 0000 0155                 sprintf(s, " Light    ");
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,146
	CALL SUBOPT_0x6
; 0000 0156                 lcd_gotoxy(x, 0);
	CALL SUBOPT_0x3
; 0000 0157                 lcd_puts(s);
	CALL SUBOPT_0x7
; 0000 0158                 sprintf(s, " >33uW/cm2 ");
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,157
	CALL SUBOPT_0x9
; 0000 0159                 lcd_gotoxy(x, 1);
	RJMP _0xC3
; 0000 015A                 lcd_puts(s);
; 0000 015B             }
; 0000 015C             else{
_0x85:
; 0000 015D                 sprintf(s, " Light    ");
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,146
	CALL SUBOPT_0x6
; 0000 015E                 lcd_gotoxy(x, 0);
	CALL SUBOPT_0x3
; 0000 015F                 lcd_puts(s);
	CALL SUBOPT_0x7
; 0000 0160                 sprintf(s, " %duW/cm2 ", light/6);
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,169
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xC
	CALL SUBOPT_0xB
; 0000 0161                 lcd_gotoxy(x, 1);
_0xC3:
	LDD  R30,Y+4
	CALL SUBOPT_0x4
; 0000 0162                 lcd_puts(s);
	CALL SUBOPT_0x7
; 0000 0163             }
; 0000 0164             PORTB.1 = 1;
	SBI  0x18,1
; 0000 0165         } //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; 0000 0166         else if(flag == 5){
	RJMP _0x89
_0x84:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	SBIW R26,5
	BRNE _0x8A
; 0000 0167             if ( 161 - distance/2 < 65){
	CALL SUBOPT_0xD
	SUB  R26,R30
	SBC  R27,R31
	CPI  R26,LOW(0x41)
	LDI  R30,HIGH(0x41)
	CPC  R27,R30
	BRGE _0x8B
; 0000 0168                 sprintf(s, " Dist.    ");
	CALL SUBOPT_0x5
	CALL SUBOPT_0xE
; 0000 0169                 lcd_gotoxy(x, 0);
	CALL SUBOPT_0x3
; 0000 016A                 lcd_puts(s);
	CALL SUBOPT_0x7
; 0000 016B                 sprintf(s, " <65cm     ");
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,191
	CALL SUBOPT_0x9
; 0000 016C                 lcd_gotoxy(x, 1);
	RJMP _0xC4
; 0000 016D                 lcd_puts(s);
; 0000 016E             }
; 0000 016F             else{
_0x8B:
; 0000 0170                 sprintf(s," Dist.    ");
	CALL SUBOPT_0x5
	CALL SUBOPT_0xE
; 0000 0171                 lcd_gotoxy(x, 0);
	CALL SUBOPT_0x3
; 0000 0172                 lcd_puts(s);
	CALL SUBOPT_0x7
; 0000 0173                 sprintf(s, " %dcm      ", 161 - distance/2);
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,203
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xD
	CALL __SWAPW12
	SUB  R30,R26
	SBC  R31,R27
	CALL SUBOPT_0xB
; 0000 0174                 lcd_gotoxy(x, 1);
_0xC4:
	LDD  R30,Y+4
	CALL SUBOPT_0x4
; 0000 0175                 lcd_puts(s);
	CALL SUBOPT_0x7
; 0000 0176             }
; 0000 0177             PORTB.0 = 1;
	SBI  0x18,0
; 0000 0178         } //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; 0000 0179         else if(flag == 6){
	RJMP _0x8F
_0x8A:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	SBIW R26,6
	BRNE _0x90
; 0000 017A             if ( 161 - distance/2 < 65){
	CALL SUBOPT_0xD
	SUB  R26,R30
	SBC  R27,R31
	CPI  R26,LOW(0x41)
	LDI  R30,HIGH(0x41)
	CPC  R27,R30
	BRGE _0x91
; 0000 017B                 sprintf(s, " Dist.    ");
	CALL SUBOPT_0x5
	CALL SUBOPT_0xE
; 0000 017C                 lcd_gotoxy(x, 0);
	CALL SUBOPT_0x3
; 0000 017D                 lcd_puts(s);
	CALL SUBOPT_0x7
; 0000 017E                 sprintf(s, " <165inch ");
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,215
	CALL SUBOPT_0x9
; 0000 017F                 lcd_gotoxy(x, 1);
	RJMP _0xC5
; 0000 0180                 lcd_puts(s);
; 0000 0181             }
; 0000 0182             else{
_0x91:
; 0000 0183             sprintf(s, " Dist.    ");
	CALL SUBOPT_0x5
	CALL SUBOPT_0xE
; 0000 0184             lcd_gotoxy(x, 0);
	CALL SUBOPT_0x3
; 0000 0185             lcd_puts(s);
	CALL SUBOPT_0x7
; 0000 0186             sprintf(s, " %dinch    ", ((161 - distance/2)*254)/100 );
	CALL SUBOPT_0x5
	__POINTW1FN _0x0,226
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xD
	SUB  R26,R30
	SBC  R27,R31
	LDI  R30,LOW(254)
	LDI  R31,HIGH(254)
	CALL __MULW12
	MOVW R26,R30
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	CALL __DIVW21
	CALL SUBOPT_0xB
; 0000 0187             lcd_gotoxy(x, 1);
_0xC5:
	LDD  R30,Y+4
	CALL SUBOPT_0x4
; 0000 0188             lcd_puts(s);
	CALL SUBOPT_0x7
; 0000 0189             }
; 0000 018A             PORTB.0 = 1;
	SBI  0x18,0
; 0000 018B         } //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; 0000 018C         else if(flag == 7){
	RJMP _0x95
_0x90:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	SBIW R26,7
	BRNE _0x96
; 0000 018D             doLEDanimate=1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STD  Y+6,R30
	STD  Y+6+1,R31
; 0000 018E             flag = backupFlag;
	RJMP _0xC6
; 0000 018F         } //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; 0000 0190         else if (key == 8){
_0x96:
	CALL SUBOPT_0x1
	BRNE _0x98
; 0000 0191             doAnimate = 1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STD  Y+8,R30
	STD  Y+8+1,R31
; 0000 0192             flag = backupFlag;
	RJMP _0xC6
; 0000 0193         } //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; 0000 0194         else if (key == 9){
_0x98:
	CALL SUBOPT_0x2
	BRNE _0x9A
; 0000 0195             doAnimate = 0;
	LDI  R30,LOW(0)
	STD  Y+8,R30
	STD  Y+8+1,R30
; 0000 0196             doLEDanimate = 0;
	STD  Y+6,R30
	STD  Y+6+1,R30
; 0000 0197             flag = backupFlag;
_0xC6:
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	STD  Y+12,R30
	STD  Y+12+1,R31
; 0000 0198         }
; 0000 0199 
; 0000 019A         //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= handle LCD animation
; 0000 019B         if (doAnimate == 1){
_0x9A:
_0x95:
_0x8F:
_0x89:
_0x83:
_0x7D:
_0x77:
_0x71:
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x9B
; 0000 019C             lcd_gotoxy(x, y);
	LDD  R30,Y+4
	ST   -Y,R30
	LDD  R26,Y+3
	CALL _lcd_gotoxy
; 0000 019D             lcd_puts(" ");
	__POINTW2MN _0x36,50
	CALL _lcd_puts
; 0000 019E             x += direction; // Update x position
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+4,R30
	STD  Y+4+1,R31
; 0000 019F             // Check collision with screen edges
; 0000 01A0             if (x >= LCD_WIDTH-7){
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	SBIW R26,9
	BRLT _0x9C
; 0000 01A1                 x = LCD_WIDTH-7 - 1; // Adjust x to prevent overflow
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	STD  Y+4,R30
	STD  Y+4+1,R31
; 0000 01A2                 direction = -1; // Change direction to left
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0xC7
; 0000 01A3             }
; 0000 01A4             else if (x < 0){
_0x9C:
	LDD  R26,Y+5
	TST  R26
	BRPL _0x9E
; 0000 01A5                 x = 0; // Adjust x to prevent underflow
	LDI  R30,LOW(0)
	STD  Y+4,R30
	STD  Y+4+1,R30
; 0000 01A6                 direction = 1; // Change direction to right
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
_0xC7:
	ST   Y,R30
	STD  Y+1,R31
; 0000 01A7             }
; 0000 01A8 
; 0000 01A9             if (y == 0) y = 1;
_0x9E:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	SBIW R30,0
	BRNE _0x9F
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STD  Y+2,R30
	STD  Y+2+1,R31
; 0000 01AA             else y = 0;
	RJMP _0xA0
_0x9F:
	LDI  R30,LOW(0)
	STD  Y+2,R30
	STD  Y+2+1,R30
; 0000 01AB         }
_0xA0:
; 0000 01AC 
; 0000 01AD         //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= handle LEDs animation
; 0000 01AE         if (doLEDanimate==1){
_0x9B:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SBIW R26,1
	BRNE _0xA1
; 0000 01AF             PORTB.3 = rand() % 2;
	CALL SUBOPT_0xF
	BRNE _0xA2
	CBI  0x18,3
	RJMP _0xA3
_0xA2:
	SBI  0x18,3
_0xA3:
; 0000 01B0             PORTB.4 = rand() % 2;
	CALL SUBOPT_0xF
	BRNE _0xA4
	CBI  0x18,4
	RJMP _0xA5
_0xA4:
	SBI  0x18,4
_0xA5:
; 0000 01B1             PORTB.5 = rand() % 2;
	CALL SUBOPT_0xF
	BRNE _0xA6
	CBI  0x18,5
	RJMP _0xA7
_0xA6:
	SBI  0x18,5
_0xA7:
; 0000 01B2             PORTB.6 = rand() % 2;
	CALL SUBOPT_0xF
	BRNE _0xA8
	CBI  0x18,6
	RJMP _0xA9
_0xA8:
	SBI  0x18,6
_0xA9:
; 0000 01B3             PORTB.7 = rand() % 2;
	CALL SUBOPT_0xF
	BRNE _0xAA
	CBI  0x18,7
	RJMP _0xAB
_0xAA:
	SBI  0x18,7
_0xAB:
; 0000 01B4         }
; 0000 01B5 
; 0000 01B6         //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= handle critical situation:
; 0000 01B7         if(161 - distance/2 < 70) {PORTD.7 = ~PORTD.7;}
_0xA1:
	CALL SUBOPT_0xD
	SUB  R26,R30
	SBC  R27,R31
	CPI  R26,LOW(0x46)
	LDI  R30,HIGH(0x46)
	CPC  R27,R30
	BRGE _0xAC
	SBIS 0x12,7
	RJMP _0xAD
	CBI  0x12,7
	RJMP _0xAE
_0xAD:
	SBI  0x12,7
_0xAE:
; 0000 01B8         else {PORTD.7 = 0;}
	RJMP _0xAF
_0xAC:
	CBI  0x12,7
_0xAF:
; 0000 01B9 
; 0000 01BA         if(temp/4 > 45) {PORTA.7 = ~PORTA.7;}
	CALL SUBOPT_0x8
	SBIW R30,46
	BRLT _0xB2
	SBIS 0x1B,7
	RJMP _0xB3
	CBI  0x1B,7
	RJMP _0xB4
_0xB3:
	SBI  0x1B,7
_0xB4:
; 0000 01BB         else {PORTA.7 = 0;}
	RJMP _0xB5
_0xB2:
	CBI  0x1B,7
_0xB5:
; 0000 01BC 
; 0000 01BD         if(light/6 > 30) {PORTC.3 = ~PORTC.3;}
	CALL SUBOPT_0xC
	SBIW R30,31
	BRLT _0xB8
	SBIS 0x15,3
	RJMP _0xB9
	CBI  0x15,3
	RJMP _0xBA
_0xB9:
	SBI  0x15,3
_0xBA:
; 0000 01BE         else { PORTC.3 = 0;}
	RJMP _0xBB
_0xB8:
	CBI  0x15,3
_0xBB:
; 0000 01BF 
; 0000 01C0 
; 0000 01C1 
; 0000 01C2     } //while(){}
	RJMP _0x2F
; 0000 01C3 
; 0000 01C4 
; 0000 01C5 
; 0000 01C6 } //main(){}
_0xBE:
	RJMP _0xBE
; .FEND

	.DSEG
_0x36:
	.BYTE 0x34
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
_put_buff_G100:
; .FSTART _put_buff_G100
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	CALL __GETW1P
	SBIW R30,0
	BREQ _0x2000010
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,4
	CALL __GETW1P
	MOVW R16,R30
	SBIW R30,0
	BREQ _0x2000012
	__CPWRN 16,17,2
	BRLO _0x2000013
	MOVW R30,R16
	SBIW R30,1
	MOVW R16,R30
	__PUTW1SNS 2,4
_0x2000012:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+4
	STD  Z+0,R26
_0x2000013:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CALL __GETW1P
	TST  R31
	BRMI _0x2000014
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
_0x2000014:
	RJMP _0x2000015
_0x2000010:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	ST   X+,R30
	ST   X,R31
_0x2000015:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,5
	RET
; .FEND
__print_G100:
; .FSTART __print_G100
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x2000016:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2000018
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x200001C
	CPI  R18,37
	BRNE _0x200001D
	LDI  R17,LOW(1)
	RJMP _0x200001E
_0x200001D:
	CALL SUBOPT_0x10
_0x200001E:
	RJMP _0x200001B
_0x200001C:
	CPI  R30,LOW(0x1)
	BRNE _0x200001F
	CPI  R18,37
	BRNE _0x2000020
	CALL SUBOPT_0x10
	RJMP _0x20000CC
_0x2000020:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2000021
	LDI  R16,LOW(1)
	RJMP _0x200001B
_0x2000021:
	CPI  R18,43
	BRNE _0x2000022
	LDI  R20,LOW(43)
	RJMP _0x200001B
_0x2000022:
	CPI  R18,32
	BRNE _0x2000023
	LDI  R20,LOW(32)
	RJMP _0x200001B
_0x2000023:
	RJMP _0x2000024
_0x200001F:
	CPI  R30,LOW(0x2)
	BRNE _0x2000025
_0x2000024:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x2000026
	ORI  R16,LOW(128)
	RJMP _0x200001B
_0x2000026:
	RJMP _0x2000027
_0x2000025:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x200001B
_0x2000027:
	CPI  R18,48
	BRLO _0x200002A
	CPI  R18,58
	BRLO _0x200002B
_0x200002A:
	RJMP _0x2000029
_0x200002B:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x200001B
_0x2000029:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x200002F
	CALL SUBOPT_0x11
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	CALL SUBOPT_0x12
	RJMP _0x2000030
_0x200002F:
	CPI  R30,LOW(0x73)
	BRNE _0x2000032
	CALL SUBOPT_0x11
	CALL SUBOPT_0x13
	CALL _strlen
	MOV  R17,R30
	RJMP _0x2000033
_0x2000032:
	CPI  R30,LOW(0x70)
	BRNE _0x2000035
	CALL SUBOPT_0x11
	CALL SUBOPT_0x13
	CALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2000033:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x2000036
_0x2000035:
	CPI  R30,LOW(0x64)
	BREQ _0x2000039
	CPI  R30,LOW(0x69)
	BRNE _0x200003A
_0x2000039:
	ORI  R16,LOW(4)
	RJMP _0x200003B
_0x200003A:
	CPI  R30,LOW(0x75)
	BRNE _0x200003C
_0x200003B:
	LDI  R30,LOW(_tbl10_G100*2)
	LDI  R31,HIGH(_tbl10_G100*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(5)
	RJMP _0x200003D
_0x200003C:
	CPI  R30,LOW(0x58)
	BRNE _0x200003F
	ORI  R16,LOW(8)
	RJMP _0x2000040
_0x200003F:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x2000071
_0x2000040:
	LDI  R30,LOW(_tbl16_G100*2)
	LDI  R31,HIGH(_tbl16_G100*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(4)
_0x200003D:
	SBRS R16,2
	RJMP _0x2000042
	CALL SUBOPT_0x11
	CALL SUBOPT_0x14
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2000043
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x2000043:
	CPI  R20,0
	BREQ _0x2000044
	SUBI R17,-LOW(1)
	RJMP _0x2000045
_0x2000044:
	ANDI R16,LOW(251)
_0x2000045:
	RJMP _0x2000046
_0x2000042:
	CALL SUBOPT_0x11
	CALL SUBOPT_0x14
_0x2000046:
_0x2000036:
	SBRC R16,0
	RJMP _0x2000047
_0x2000048:
	CP   R17,R21
	BRSH _0x200004A
	SBRS R16,7
	RJMP _0x200004B
	SBRS R16,2
	RJMP _0x200004C
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x200004D
_0x200004C:
	LDI  R18,LOW(48)
_0x200004D:
	RJMP _0x200004E
_0x200004B:
	LDI  R18,LOW(32)
_0x200004E:
	CALL SUBOPT_0x10
	SUBI R21,LOW(1)
	RJMP _0x2000048
_0x200004A:
_0x2000047:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x200004F
_0x2000050:
	CPI  R19,0
	BREQ _0x2000052
	SBRS R16,3
	RJMP _0x2000053
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2000054
_0x2000053:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x2000054:
	CALL SUBOPT_0x10
	CPI  R21,0
	BREQ _0x2000055
	SUBI R21,LOW(1)
_0x2000055:
	SUBI R19,LOW(1)
	RJMP _0x2000050
_0x2000052:
	RJMP _0x2000056
_0x200004F:
_0x2000058:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x200005A:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x200005C
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x200005A
_0x200005C:
	CPI  R18,58
	BRLO _0x200005D
	SBRS R16,3
	RJMP _0x200005E
	SUBI R18,-LOW(7)
	RJMP _0x200005F
_0x200005E:
	SUBI R18,-LOW(39)
_0x200005F:
_0x200005D:
	SBRC R16,4
	RJMP _0x2000061
	CPI  R18,49
	BRSH _0x2000063
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2000062
_0x2000063:
	RJMP _0x20000CD
_0x2000062:
	CP   R21,R19
	BRLO _0x2000067
	SBRS R16,0
	RJMP _0x2000068
_0x2000067:
	RJMP _0x2000066
_0x2000068:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x2000069
	LDI  R18,LOW(48)
_0x20000CD:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x200006A
	ANDI R16,LOW(251)
	ST   -Y,R20
	CALL SUBOPT_0x12
	CPI  R21,0
	BREQ _0x200006B
	SUBI R21,LOW(1)
_0x200006B:
_0x200006A:
_0x2000069:
_0x2000061:
	CALL SUBOPT_0x10
	CPI  R21,0
	BREQ _0x200006C
	SUBI R21,LOW(1)
_0x200006C:
_0x2000066:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x2000059
	RJMP _0x2000058
_0x2000059:
_0x2000056:
	SBRS R16,0
	RJMP _0x200006D
_0x200006E:
	CPI  R21,0
	BREQ _0x2000070
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	CALL SUBOPT_0x12
	RJMP _0x200006E
_0x2000070:
_0x200006D:
_0x2000071:
_0x2000030:
_0x20000CC:
	LDI  R17,LOW(0)
_0x200001B:
	RJMP _0x2000016
_0x2000018:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	CALL __GETW1P
	CALL __LOADLOCR6
	ADIW R28,20
	RET
; .FEND
_sprintf:
; .FSTART _sprintf
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	CALL __SAVELOCR4
	CALL SUBOPT_0x15
	SBIW R30,0
	BRNE _0x2000072
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x20C0002
_0x2000072:
	MOVW R26,R28
	ADIW R26,6
	CALL __ADDW2R15
	MOVW R16,R26
	CALL SUBOPT_0x15
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R30,LOW(0)
	STD  Y+8,R30
	STD  Y+8+1,R30
	MOVW R26,R28
	ADIW R26,10
	CALL __ADDW2R15
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_buff_G100)
	LDI  R31,HIGH(_put_buff_G100)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,10
	RCALL __print_G100
	MOVW R18,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
	MOVW R30,R18
_0x20C0002:
	CALL __LOADLOCR4
	ADIW R28,10
	POP  R15
	RET
; .FEND

	.CSEG

	.DSEG

	.CSEG
_rand:
; .FSTART _rand
	LDS  R30,__seed_G101
	LDS  R31,__seed_G101+1
	LDS  R22,__seed_G101+2
	LDS  R23,__seed_G101+3
	__GETD2N 0x41C64E6D
	CALL __MULD12U
	__ADDD1N 30562
	STS  __seed_G101,R30
	STS  __seed_G101+1,R31
	STS  __seed_G101+2,R22
	STS  __seed_G101+3,R23
	movw r30,r22
	andi r31,0x7F
	RET
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G102:
; .FSTART __lcd_write_nibble_G102
	ST   -Y,R26
	IN   R30,0x15
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LD   R30,Y
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x15,R30
	__DELAY_USB 13
	SBI  0x15,2
	__DELAY_USB 13
	CBI  0x15,2
	__DELAY_USB 13
	RJMP _0x20C0001
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G102
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G102
	__DELAY_USB 133
	RJMP _0x20C0001
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G102)
	SBCI R31,HIGH(-__base_y_G102)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R5,Y+1
	LDD  R4,Y+0
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	CALL SUBOPT_0x16
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	CALL SUBOPT_0x16
	LDI  R30,LOW(0)
	MOV  R4,R30
	MOV  R5,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2040005
	CP   R5,R7
	BRLO _0x2040004
_0x2040005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	INC  R4
	MOV  R26,R4
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2040007
	RJMP _0x20C0001
_0x2040007:
_0x2040004:
	INC  R5
	SBI  0x15,0
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x15,0
	RJMP _0x20C0001
; .FEND
_lcd_puts:
; .FSTART _lcd_puts
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2040008:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x204000A
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2040008
_0x204000A:
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
	IN   R30,0x14
	ORI  R30,LOW(0xF0)
	OUT  0x14,R30
	SBI  0x14,2
	SBI  0x14,0
	SBI  0x14,1
	CBI  0x15,2
	CBI  0x15,0
	CBI  0x15,1
	LDD  R7,Y+0
	LD   R30,Y
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G102,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G102,3
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _delay_ms
	CALL SUBOPT_0x17
	CALL SUBOPT_0x17
	CALL SUBOPT_0x17
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G102
	__DELAY_USW 200
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x20C0001:
	ADIW R28,1
	RET
; .FEND

	.CSEG

	.CSEG
_strlen:
; .FSTART _strlen
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
; .FEND
_strlenf:
; .FSTART _strlenf
	ST   -Y,R27
	ST   -Y,R26
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret
; .FEND

	.CSEG

	.DSEG
__seed_G101:
	.BYTE 0x4
__base_y_G102:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x0:
	LDI  R26,LOW(2)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1:
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	CP   R30,R20
	CPC  R31,R21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2:
	LDI  R30,LOW(9)
	LDI  R31,HIGH(9)
	CP   R30,R20
	CPC  R31,R21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 14 TIMES, CODE SIZE REDUCTION:23 WORDS
SUBOPT_0x3:
	ST   -Y,R30
	LDI  R26,LOW(0)
	JMP  _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x4:
	ST   -Y,R30
	LDI  R26,LOW(1)
	JMP  _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 26 TIMES, CODE SIZE REDUCTION:47 WORDS
SUBOPT_0x5:
	MOVW R30,R28
	ADIW R30,14
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 14 TIMES, CODE SIZE REDUCTION:62 WORDS
SUBOPT_0x6:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _sprintf
	ADIW R28,4
	LDD  R30,Y+4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 20 TIMES, CODE SIZE REDUCTION:35 WORDS
SUBOPT_0x7:
	MOVW R26,R28
	ADIW R26,14
	JMP  _lcd_puts

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x8:
	MOV  R26,R17
	LDI  R27,0
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	CALL __DIVW21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x9:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _sprintf
	ADIW R28,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA:
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0x8

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0xB:
	CALL __CWD1
	CALL __PUTPARD1
	LDI  R24,4
	CALL _sprintf
	ADIW R28,8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xC:
	MOV  R26,R16
	LDI  R27,0
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	CALL __DIVW21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0xD:
	MOV  R26,R19
	LDI  R27,0
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CALL __DIVW21
	LDI  R26,LOW(161)
	LDI  R27,HIGH(161)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xE:
	__POINTW1FN _0x0,180
	RJMP SUBOPT_0x6

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0xF:
	CALL _rand
	LDI  R26,LOW(1)
	LDI  R27,HIGH(1)
	CALL __MANDW12
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x10:
	ST   -Y,R18
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x11:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x12:
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x13:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x14:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x15:
	MOVW R26,R28
	ADIW R26,12
	CALL __ADDW2R15
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x16:
	CALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x17:
	LDI  R26,LOW(48)
	CALL __lcd_write_nibble_G102
	__DELAY_USW 200
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0x7D0
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__MULD12U:
	MUL  R23,R26
	MOV  R23,R0
	MUL  R22,R27
	ADD  R23,R0
	MUL  R31,R24
	ADD  R23,R0
	MUL  R30,R25
	ADD  R23,R0
	MUL  R22,R26
	MOV  R22,R0
	ADD  R23,R1
	MUL  R31,R27
	ADD  R22,R0
	ADC  R23,R1
	MUL  R30,R24
	ADD  R22,R0
	ADC  R23,R1
	CLR  R24
	MUL  R31,R26
	MOV  R31,R0
	ADD  R22,R1
	ADC  R23,R24
	MUL  R30,R27
	ADD  R31,R0
	ADC  R22,R1
	ADC  R23,R24
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	ADC  R22,R24
	ADC  R23,R24
	RET

__MULW12:
	RCALL __CHKSIGNW
	RCALL __MULW12U
	BRTC __MULW121
	RCALL __ANEGW1
__MULW121:
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__MANDW12:
	CLT
	SBRS R31,7
	RJMP __MANDW121
	RCALL __ANEGW1
	SET
__MANDW121:
	AND  R30,R26
	AND  R31,R27
	BRTC __MANDW122
	RCALL __ANEGW1
__MANDW122:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__INITLOCB:
__INITLOCW:
	ADD  R26,R28
	ADC  R27,R29
__INITLOC0:
	LPM  R0,Z+
	ST   X+,R0
	DEC  R24
	BRNE __INITLOC0
	RET

;END OF CODE MARKER
__END_OF_CODE:
