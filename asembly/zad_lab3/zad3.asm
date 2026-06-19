section .data
    fmt db "result %d", 10, 0

section .text
    extern printf
    global main

main:
    mov eax, 17
    mov ebx, 35
    mul ebx
    mov ebx, 2
    xor edx, edx
    div ebx
    cmp eax, 300000
    jb .below
    mov eax, 0
    call print
    ret

.below:
    mov eax, 1
    call print
    ret

print:
    push eax
    push fmt
    call printf
    add esp, 8
    ret