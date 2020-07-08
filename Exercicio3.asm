 ;Exercicio 3
section .data
EXIT_SUCCESS equ 0 
SYS_exit equ 60
stringNotPalindromo db "Nao eh palindromo!",10 
stringIsPalindromo db "Eh palindromo!",10 
palavra dq "AnotAram a Data dA maRatOna?",0; Frase finalizada com um bit Nulo
lenght dq 0
; ===================================
section .text
global _start

_start:

call _getStringLenght 

mov rcx, qword [lenght]
mov rax, palavra
mov rsi, 0
upperCaseAllLetters: ; Loop para tornar todas as letras da frase maiúsculas
		mov bl, [rax]
		cmp bl, 95
		jl skipStep
		sub bl, 32
		mov byte[palavra+rsi],bl 
		skipStep:
		inc rax
		inc rsi
		loop upperCaseAllLetters
mov rcx, qword [lenght]
mov rax, palavra

stackLoadLoop: ; Compara o valor ASCII de cada bit da frase
		mov bl, [rax]
		cmp bl, 65 ; Verifica se é menor que 65 (caracteres especiais)
		jl jumpStepLoop1
		cmp bl ,95 ; Verifica se é maior que 96 (caracteres minúsculos) 
		jg jumpStepLoop1
		push rbx
		jumpStepLoop1:
		inc rax
		loop stackLoadLoop

mov rcx, qword [lenght]
mov rax, palavra
compareLoop:
	mov bl, [rax]
	cmp bl, 65
	jl jumpStepLoop2
	cmp bl ,95
	jg jumpStepLoop2
	pop rdx
	cmp rbx, rdx ; compara a ultima com a primeira letra
	jne _printNotPalindromo ; caso não seja igual, retorna indicando que não é palindromo
	jumpStepLoop2:
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

