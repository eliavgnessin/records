; Macros program example
; Eliav Gnessin, Fall 2002
; ===============================================
; This is an example program in 8086 Assembly
; ===============================================
TITLE MACROS
; This instruction defines the memory model that MASM or TASM use
.model small
; Define the stack size. This instruction initializes the SP
.stack 160h

SWAP MACRO First,Second,Reg
LOCAL CON
	mov Reg,First
	cmp Reg,Second
	jbe CON
	xchg Reg,Second
	mov First,Reg
CON: 	nop
ENDM

; Variables & other definitions section
.data
m1 dw ?
m2 dw ?
m3 dw ?

; This is the program itself
.code
start: 	mov ax,@data ; Since the .data instruction doesn't initialize
	mov ds,ax ; the ds register we have to do it manually

	SWAP m1,m2,cx
	SWAP m2,m3,dx
	SWAP m1,m2,ax

	mov ax,4c00h ; This is the program terminator
	int 21h ; just like putting "return 0" in C
end start