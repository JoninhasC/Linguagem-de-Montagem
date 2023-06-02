%include "asm_io.inc"

section .data
    msgIdade       db "Digite a sua idade: ", 0
    msgAnoAtual    db "Digite o ano atual: ", 0
    msgAnoNascimento db "Ano de nascimento: ", 0

section .bss
    idade resd 1
    anoAtual resd 1
    anoNascimento resd 1

section .text
    global _asm_main

_asm_main:
    enter 0, 0
    pusha

    ; Leitura da idade
    mov eax, msgIdade
    call print_string
    call read_int
    mov [idade], eax

    ; Leitura do ano atual
    mov eax, msgAnoAtual
    call print_string
    call read_int
    mov [anoAtual], eax

    ; Cálculo do ano de nascimento
    mov eax, [anoAtual]
    sub eax, [idade]
    mov [anoNascimento], eax

    ; Impressão do ano de nascimento
    mov eax, msgAnoNascimento
    call print_string
    mov eax, [anoNascimento]
    call print_int
    call print_nl

    popa
    mov eax, 0
    leave
    ret
