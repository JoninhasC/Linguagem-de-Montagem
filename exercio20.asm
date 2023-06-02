%include "asm_io.inc"

section .data
    msgCelsius      db "Digite a temperatura em graus Celsius: ", 0
    msgFahrenheit   db "Temperatura em graus Fahrenheit: ", 0

section .bss
    celsius resd 1
    fahrenheit resd 1

section .text
    global _asm_main

_asm_main:
    enter 0, 0
    pusha

    ; Leitura da temperatura em Celsius
    mov eax, msgCelsius
    call print_string
    call read_int
    mov [celsius], eax

    ; Conversão para Fahrenheit
    mov eax, [celsius]
    mov ebx, 9
    sub ebx, 5
    imul eax, ebx
    add eax, 32
    mov [fahrenheit], eax

    ; Impressão da temperatura em Fahrenheit
    mov eax, msgFahrenheit
    call print_string
    mov eax, [fahrenheit]
    call print_int
    call print_nl

    popa
    mov eax, 0
    leave
    ret
