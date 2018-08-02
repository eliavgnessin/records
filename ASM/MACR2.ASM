; Macros program example
; Eliav Gnessin, Fall 2002
; ===============================================
; This is an example program in 8086 Assembly
; ===============================================

TITLE MACROS2

; This instruction defines the memory model that MASM or TASM use
.model small

; Define the stack size. This instruction initializes the SP
.stack 160h

; Define the MACRO for the loop
FORDO MACRO Low,Reg,Upper,condition,Sof,Begin
	mov Reg,Low
Begin:  cmp Reg,Upper
	Condition Sof
ENDM

ENDFOR MACRO Argument,Reg,Begin,Sof
	add Reg,Argument
	jmp Begin
Sof:	nop
ENDM

; Variables & other definitions section
.data
X dw 200 dup(?)

; This is the program itself
.code
start:	mov ax,@data        ; Since the .data instruction doesn't initialize
	mov ds,ax           ; the ds register we have to do it manually

	mov ax,0
	FORDO 0,bx,200,jge,Sof1,Begin1 ; Use loop macro
	add ax,X[bx]
	ENDFOR 2,bx,Begin1,Sof1 ; We are using Begin1,Sof1 to connect the two
				; macros

	mov ax,4c00h        ; This is the program terminator
	int 21h             ; just like putting "return 0" in C

end start
