%include "asm_io.inc"

section .data
    msgPrompt       db "Digite um número inteiro de 4 dígitos (1000 a 9999): ", 0
    msgDigit        db "Dígito: ", 0

section .bss
    numero resd 1
    digito resb 1

section .text
    global _asm_main

_asm_main:
    enter 0, 0
    pusha

    ; Leitura do número de 4 dígitos
    mov eax, msgPrompt
    call print_string
    call read_int
    mov [numero], eax

    ; Impressão de cada dígito em uma linha separada
    mov ecx, 4  ; contador para o número de dígitos
    mov eax, [numero]

loop_imprimir_digitos:
    ; Extração do dígito mais à direita
    mov edx, 0
    mov ebx, 10
    div ebx
    movzx eax, dl
    add eax, '0'  ; converte para o valor ASCII

    ; Impressão do dígito
    mov [digito], al
    mov eax, msgDigit
    call print_string
    mov eax, [digito]
    call print_char
    call print_nl

    ; Atualização do número para o próximo dígito
    mov eax, [numero]
    mov ebx, 10
    div ebx
    mov [numero], eax

    ; Decremento do contador
    loop loop_imprimir_digitos

    popa
    mov eax, 0
    leave
    ret
