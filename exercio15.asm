%include "asm_io.inc"

section .data
    msgTotal      db "Digite o valor total: ", 0
    msgGanhador1  db "Valor a ser recebido pelo primeiro ganhador: $", 0
    msgGanhador2  db "Valor a ser recebido pelo segundo ganhador: $", 0
    msgGanhador3  db "Valor a ser recebido pelo terceiro ganhador: $", 0

section .bss
    total resd 1
    ganhador1 resd 1
    ganhador2 resd 1
    ganhador3 resd 1

section .text
    global _asm_main

_asm_main:
    enter 0, 0
    pusha

    ; Leitura do valor total
    mov eax, msgTotal
    call print_string
    call read_int
    mov [total], eax

    ; Cálculo do valor para cada ganhador
    mov eax, [total]
    mov ebx, 100

    ; Primeiro ganhador: 46% do valor total
    mov ecx, 46
    mul ecx
    div ebx
    mov [ganhador1], eax

    ; Segundo ganhador: 32% do valor total
    mov ecx, 32
    mul ecx
    div ebx
    mov [ganhador2], eax

    ; Terceiro ganhador: restante do valor total
    mov ecx, [total]
    sub ecx, [ganhador1]
    sub ecx, [ganhador2]
    mov [ganhador3], ecx

    ; Impressão dos valores para cada ganhador
    mov eax, msgGanhador1
    call print_string
    mov eax, [ganhador1]
    call print_int
    call print_nl

    mov eax, msgGanhador2
    call print_string
    mov eax, [ganhador2]
    call print_int
    call print_nl

    mov eax, msgGanhador3
    call print_string
    mov eax, [ganhador3]
    call print_int
    call print_nl

    popa
    mov eax, 0
    leave
    ret
