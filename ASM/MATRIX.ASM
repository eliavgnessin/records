; Matrix example program
; Eliav Gnessin, Fall 2002
; ===========================================
; This is an example program in 8086 Assembly
; Multiply two matrices
; D=D*M
; ===========================================

TITLE MATRIX

; This instruction defines the memory model that MASM or TASM use
.model small

; Define the stack size. This instruction initializes the SP.
.stack 100h

; Variables & other definitions section
.data
M db 1,2,3,4,5,6,7,8,9 ; M is a 3X3 matrix
N dw 3                 ; N is the parameter for the matrix size
D db 1,2,1,2,1,2,1,2,1 ; D is the destination matrix

; This is the program itself
.code
start:	mov ax,@data          ; Since the .data instruction doesn't initialize
	mov ds,ax             ; the ds register we have to do it manually
        
	mov bx,0              ; bx will count the rows
        mov cx,N              
loop2:  push cx               ; save row count and start counting columns
        mov cx,N
        mov si,0              ; si will count the columns
loop1:  mov al,M[bx+si]       ; use MUL in byte format
        mul D[bx+si]          ;     ax=al*byte
	mov D[bx+si],al       ; since destination is size of byte, use only al
        inc si
        loop loop1
        pop cx                ; get row count from stack
        add bx,N
        loop loop2
	mov ax,4c00h          ; This is the program terminator
	int 21h               ; just like putting "return 0" in C

; End of program
end start
