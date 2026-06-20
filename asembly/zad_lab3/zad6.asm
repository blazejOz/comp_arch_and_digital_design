section .data
    fmt db "result %d", 10, 0

section .text
    extern printf
    global main

main:
    mov eax, 7
    xor ebx, ebx 
    mov ecx, 32

.loop:
    ror eax, 1
    jnc .is_zero
    inc ebx

.is_zero:
    dec ecx
    jnz .loop

    mov eax, EBX
    call print

    ret


print:
    push eax
    push fmt
    call printf
    add esp, 8
    ret
