section .data
    fmt db "result %d", 10, 0

section .text
    extern printf
    global main

main:
    ; 6 2 - 3 7 + +
    push 6
    push 2
    pop ebx
    pop eax
    sub eax, ebx
    push eax
    push 3
    push 7
    pop ebx
    pop eax
    add eax, ebx
    push eax
    pop ebx
    pop eax
    add eax, ebx
    call print

    xor eax, eax
    ret

print:
    push eax
    push fmt
    call printf
    add esp, 8
    ret