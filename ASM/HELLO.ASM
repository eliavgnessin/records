; Hello world program
; Eliav Gnessin, Fall 2002
; ===========================================
; This is an example program in 8086 Assembly
; ===========================================

TITLE HELLO

; This instruction defines the memory model that MASM or TASM use
.model small

; Define the stack size. This instruction initializes the SP.
.stack 160h

; Variables & other definitions section
.data
infor	  db "Hello world!",10,12+1  ; infor is the string to be printed
inforlen  equ 14		     ; this is the string's length

; This is the program itself
.code
start:	mov ax,@data        ; Since the .data instruction doesn't initialize the ds register
	mov ds,ax           ; we have to do it manually

	mov cx,inforlen	    ; This is the string's length for our loop
	mov si,0            ; This will be the index of the string pointer
again:	mov al,infor[si]    ; Get char from loop
	call printch        ; Print it
	inc si              ; Increment our index
	loop again          ; Do it for all the chars in the string
	
	mov ax,4c00h        ; This is the program terminator
	int 21h             ; just like putting "return 0" in C

; =================================================
; Procedure definitions
; =================================================

; =================================================
; Procedure name: printch - Print a char to console
; Input:          AL - the char's ASCII code
; Output:         None
; =================================================
printch proc near
	mov bx,0            ; No color definitions
	mov ah,0Eh          ; Print char to TTY function code
	int 10h             ; Call
	ret
printch endp

; End of program
end start
