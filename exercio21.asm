%include "asm_io.inc"

section .data
    msgMenu         db "Escolha a figura geométrica:", 0
    msgOpcao1       db "1. Círculo", 0
    msgOpcao2       db "2. Triângulo", 0
    msgOpcao3       db "3. Quadrado", 0
    msgOpcao4       db "4. Retângulo", 0
    msgEscolha      db "Digite a opção desejada: ", 0
    msgRaio         db "Digite o raio do círculo: ", 0
    msgBase         db "Digite a base do triângulo: ", 0
    msgAltura       db "Digite a altura do triângulo: ", 0
    msgLado         db "Digite o lado do quadrado: ", 0
    msgBaseRet      db "Digite a base do retângulo: ", 0
    msgAlturaRet    db "Digite a altura do retângulo: ", 0
    msgArea         db "A área da figura geométrica é: ", 0

section .bss
    opcao resb 1
    raio resd 1
    base resd 1
    altura resd 1
    lado resd 1
    baseRet resd 1
    alturaRet resd 1
    area resd 1

section .text
    global _asm_main

_asm_main:
    enter 0, 0
    pusha

    ; Exibição do menu e leitura da opção escolhida pelo usuário
    mov eax, msgMenu
    call print_string
    mov eax, msgOpcao1
    call print_string
    mov eax, msgOpcao2
    call print_string
    mov eax, msgOpcao3
    call print_string
    mov eax, msgOpcao4
    call print_string

    mov eax, msgEscolha
    call print_string
    call read_char
    mov [opcao], al

    ; Verificação da opção escolhida e cálculo da área correspondente
    cmp byte [opcao], '1'
    je calcular_circulo
    cmp byte [opcao], '2'
    je calcular_triangulo
    cmp byte [opcao], '3'
    je calcular_quadrado
    cmp byte [opcao], '4'
    je calcular_retangulo
    jmp finalizar

calcular_circulo:
    ; Leitura do raio do círculo
    mov eax, msgRaio
    call print_string
    call read_int
    mov [raio], eax

    ; Cálculo da área do círculo: 3 * raio^2
    mov eax, [raio]
    imul eax, eax
    imul eax, 3
    mov [area], eax
    jmp exibir_area

calcular_triangulo:
    ; Leitura da base do triângulo
    mov eax, msgBase
    call print_string
    call read_int
    mov [base], eax

    ; Leitura da altura do triângulo
    mov eax, msgAltura
    call print_string
    call read_int
    mov [altura], eax

    ; Cálculo da área do triângulo: base * altura / 2
    mov eax, [base]
    imul eax, [altura]
    mov edx, 2
    idiv edx
    mov [area], eax
    jmp exibir_area

calcular_quadrado:
    ; Leitura do lado do quadrado
    mov eax, msgLado
    call print_string
    call read_int
    mov [lado], eax

    ; Cálculo da área do quadrado: lado^2
    mov eax, [lado]
    imul eax, eax
    mov [area], eax
    jmp exibir_area

calcular_retangulo:
    ; Leitura da base do retângulo
    mov eax, msgBaseRet
    call print_string
    call read_int
    mov [baseRet], eax

    ; Leitura da altura do retângulo
    mov eax, msgAlturaRet
    call print_string
    call read_int
    mov [alturaRet], eax

    ; Cálculo da área do retângulo: base * altura
    mov eax, [baseRet]
    imul eax, [alturaRet]
    mov [area], eax
    jmp exibir_area

exibir_area:
    ; Exibição da área calculada
    mov eax, msgArea
    call print_string
    mov eax, [area]
    call print_int
    call print_nl
    jmp finalizar

finalizar:
    popa
    mov eax, 0
    leave
    ret
