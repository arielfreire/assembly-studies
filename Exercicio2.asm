 ;Exercicio 2
section .data
EXIT_SUCCESS equ 0 
SYS_exit equ 60
stringNotPalindromo db "Nao eh palindromo!",10 
stringIsPalindromo db "Eh palindromo!",10 
palavra dq "arara",0 ;palavra finalizada com um bit Nulo
lenght dq 0
; ===================================
section .text
global _start

_start:
call _getStringLenght

mov rcx, qword [lenght]
mov rax, palavra

stackLoadLoop: ; carrega os bytes de cada letra da palavra na pilha
		mov bl, [rax]
		push rbx
		inc rax
loop stackLoadLoop

mov rcx, qword [lenght]
mov rax, palavra
compareLoop:
	pop rbx
	mov dl, [rax]
	cmp rbx, rdx ; compara a ultima com a primeira letra
	jne _printNotPalindromo ; caso não seja igual, retorna indicando que não é palindromo
	inc rax
	loop compareLoop
call _printIsPalindromo ; caso termine a iteração, significa que é palindromo.


last:
	mov rax, SYS_exit
	mov rdi, EXIT_SUCCESS
	syscall
;========================================
;procedimentos auxiliares 	

_printNotPalindromo:
mov rax, 1
mov rdi, 1
mov rsi, stringNotPalindromo
mov rdx, 19
syscall 
call last

_printIsPalindromo
mov rax, 1
mov rdi, 1
mov rsi, stringIsPalindromo
mov rdx, 15
syscall 
call last

_getStringLenght
	mov rbx, 0
	mov rax, palavra
	_getStringLenghtLoop:
		inc rax
		inc rbx
		mov cl,[rax]
		cmp cl,0 ; compara se é igual ao caracter nulo
		jne _getStringLenghtLoop ;retorna tamanho da palavra sem o caractere
		mov [lenght], rbx
		ret

