%include "asm_io.inc"

section .data
    msgHoraInicio    db "Digite a hora de início: ", 0
    msgMinutoInicio  db "Digite o minuto de início: ", 0
    msgSegundoInicio db "Digite o segundo de início: ", 0
    msgDuracao       db "Digite a duração em segundos: ", 0
    msgHoraTermino   db "Horário de término: ", 0
    msgSeparador     db ":", 0

section .bss
    horaInicio resd 1
    minutoInicio resd 1
    segundoInicio resd 1
    duracao resd 1
    horaTermino resd 1
    minutoTermino resd 1
    segundoTermino resd 1

section .text
    global _asm_main

_asm_main:
    enter 0, 0
    pusha

    ; Leitura do horário de início
    mov eax, msgHoraInicio
    call print_string
    call read_int
    mov [horaInicio], eax

    mov eax, msgMinutoInicio
    call print_string
    call read_int
    mov [minutoInicio], eax

    mov eax, msgSegundoInicio
    call print_string
    call read_int
    mov [segundoInicio], eax

    ; Leitura da duração em segundos
    mov eax, msgDuracao
    call print_string
    call read_int
    mov [duracao], eax

    ; Cálculo do horário de término
    mov eax, [horaInicio]
    add eax, [duracao]
    mov [horaTermino], eax

    mov eax, [minutoInicio]
    mov ebx, 60
    div ebx
    add eax, [minutoTermino]
    mov [minutoTermino], eax

    mov eax, [segundoInicio]
    mov ebx, 60
    div ebx
    add eax, [segundoTermino]
    mov [segundoTermino], eax

    ; Impressão do horário de término
    mov eax, msgHoraTermino
    call print_string
    mov eax, [horaTermino]
    call print_int
    mov edx, msgSeparador
    call print_string
    mov eax, [minutoTermino]
    call print_int
    mov edx, msgSeparador
    call print_string
    mov eax, [segundoTermino]
    call print_int
    call print_nl

    popa
    mov eax, 0
    leave
    ret
