section .data
    msg db "%s", 10, 0
    a dd 27
    b dd 13

section .text
    extern printf
    global main

main:
    call sum
    call print
    call substr
    call print
    call multiply
    call print
    call divide
    call print
    call modulo
    call print
    ret

sum:
    mov eax, [a]
    add eax, [b]
    ret

substr:
    mov eax, 27
    sub eax, 13
    ret

multiply:
    mov eax, [a]
    mov edx, 0
    mul dword [b]
    ret

divide:
    mov eax, [a]
    mov edx, 0
    div dword [b]
    ret

modulo:
    mov eax, [a]
    mov edx, 0
    div dword [b]
    mov eax, edx
    ret


print:
    push eax
    push msg
    call printf
    add esp, 8
    ret