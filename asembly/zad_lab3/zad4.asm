section .data
    fmt db "result %d", 10, 0

section .text
    extern printf
    global main


main:
    xor eax, eax
    mov ecx, 1

.loop:
    add eax, ecx
    inc ecx

    cmp ecx, 125
    jbe .loop

    call print
    xor eax, eax
    ret

print:
    push eax
    push fmt
    call printf
    add esp, 8
    ret