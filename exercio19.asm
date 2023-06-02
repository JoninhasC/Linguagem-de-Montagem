%include "asm_io.inc"

section .data
    msgDegrau       db "Digite a altura do degrau (em centímetros): ", 0
    msgAltura       db "Digite a altura desejada (em centímetros): ", 0
    msgNumDegraus   db "Número de degraus necessários: ", 0

section .bss
    degrau resd 1
    altura resd 1
    numDegraus resd 1

section .text
    global _asm_main

_asm_main:
    enter 0, 0
    pusha

    ; Leitura da altura do degrau
    mov eax, msgDegrau
    call print_string
    call read_int
    mov [degrau], eax

    ; Leitura da altura desejada
    mov eax, msgAltura
    call print_string
    call read_int
    mov [altura], eax

    ; Cálculo do número de degraus
    mov eax, [altura]
    mov ebx, [degrau]
    xor edx, edx
    div ebx
    mov [numDegraus], eax

    ; Impressão do número de degraus necessários
    mov eax, msgNumDegraus
    call print_string
    mov eax, [numDegraus]
    call print_int
    call print_nl

    popa
    mov eax, 0
    leave
    ret
