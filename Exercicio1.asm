 ;Exercicio 1
section .data
EXIT_SUCCESS equ 0 
SYS_exit equ 60 

String1 db "Lista:"
String2 db "Lista invertida:"
values dq "1", "2", "3", "4", "5","6","7","8","9","10",10 ; 10 valores e o caracter 10 para pular a linha
lenght dq 10
; ===================================
section .text
global _start

_start:
mov rcx, qword [lenght]
mov rsi, 0
mov rax, 0

stackLoadLoop:
push qword [values+rsi*8]
inc rsi
loop stackLoadLoop


mov rbx, values
call _printString1
call _printRBX
mov rcx, qword [lenght]
mov rsi, 0

valuesInvertLoop:
pop rax
mov qword [values+rsi*8], rax
inc rsi
loop valuesInvertLoop

last:
	call _printString2
	call _printRBX
	mov rax, SYS_exit
	mov rdi, EXIT_SUCCESS
	syscall
;========================================
;procedimentos auxiliares 	
_printRBX:
mov rax, 1
mov rdi, 1
mov rsi, rbx
mov rdx, 96
syscall 
ret

_printString1:
mov rax, 1
mov rdi, 1
mov rsi, String1
mov rdx, 6
syscall 
ret

_printString2:
mov rax, 1
mov rdi, 1
mov rsi, String2
mov rdx, 16
syscall 
ret
