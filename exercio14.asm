%include "asm_io.inc"

section .data
    msgSalarioAtual   db "Digite o valor do salário atual: ", 0
    msgTempoServico   db "Digite o tempo de serviço (em anos): ", 0
    msgSalarioFinal   db "O salário final reajustado é de $", 0
    msgSemAumento     db "O funcionário não tem direito a aumento.", 0

section .bss
    salarioAtual     resd 1
    tempoServico     resd 1
    salarioFinal     resd 1

section .text
    global _asm_main

_asm_main:
    enter 0, 0
    pusha

    ; Leitura do salário atual
    mov eax, msgSalarioAtual
    call print_string
    call read_int
    mov [salarioAtual], eax

    ; Leitura do tempo de serviço
    mov eax, msgTempoServico
    call print_string
    call read_int
    mov [tempoServico], eax

    ; Verificação e cálculo do salário reajustado
    mov eax, [salarioAtual]

    cmp eax, 500
    jle sem_aumento

    cmp eax, 1000
    jle reajuste_25

    cmp eax, 1500
    jle reajuste_20

    cmp eax, 2000
    jle reajuste_15

    jmp sem_aumento

reajuste_25:
    mov ebx, 25
    mul ebx
    add eax, [salarioAtual]
    mov [salarioFinal], eax
    jmp imprimir_salario

reajuste_20:
    mov ebx, 20
    mul ebx
    add eax, [salarioAtual]
    add eax, 100
    mov [salarioFinal], eax
    jmp imprimir_salario

reajuste_15:
    mov ebx, 15
    mul ebx
    add eax, [salarioAtual]
    add eax, 200
    mov [salarioFinal], eax
    jmp imprimir_salario

sem_aumento:
    mov eax, [salarioAtual]
    mov [salarioFinal], eax
    jmp imprimir_salario

imprimir_salario:
    mov eax, msgSalarioFinal
    call print_string
    mov eax, [salarioFinal]
    call print_int
    call print_nl

    popa
    mov eax, 0
    leave
    ret
