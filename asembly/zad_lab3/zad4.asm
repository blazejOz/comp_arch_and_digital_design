section .data
    msg db "%d",10 ,0

section .text
    extern printf
    global main

main:
    mov ecx, 3
    mov eax, 0

.loop_start:
    add eax, ecx
    dec ecx
    jnz .loop_start
    call print
    ret

print:
    push eax
    push msg
    call printf
    add esp, 8
    ret
