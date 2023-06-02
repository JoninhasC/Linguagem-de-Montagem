%include "asm_io.inc"

section .data
    msgPrompt       db "Digite um valor inteiro em segundos: ", 0
    msgHoras        db "Horas: ", 0
    msgMinutos      db "Minutos: ", 0
    msgSegundos     db "Segundos: ", 0

section .bss
    segundos resd 1
    horas resd 1
    minutos resd 1

section .text
    global _asm_main

_asm_main:
    enter 0, 0
    pusha

    ; Leitura do valor em segundos
    mov eax, msgPrompt
    call print_string
    call read_int
    mov [segundos], eax

    ; Cálculo das horas, minutos e segundos
    mov eax, [segundos]

    ; Cálculo das horas
    mov ebx, 3600
    div ebx
    mov [horas], eax

    ; Cálculo dos minutos
    mov eax, edx
    mov ebx, 60
    div ebx
    mov [minutos], eax

    ; O valor restante em edx é o número de segundos
    mov eax, edx

    ; Impressão das horas, minutos e segundos
    mov eax, [horas]
    mov edx, msgHoras
    call print_string
    mov eax, [horas]
    call print_int
    call print_nl

    mov eax, [minutos]
    mov edx, msgMinutos
    call print_string
    mov eax, [minutos]
    call print_int
    call print_nl

    mov eax, edx
    mov edx, msgSegundos
    call print_string
    mov eax, edx
    call print_int
    call print_nl

    popa
    mov eax, 0
    leave
    ret
