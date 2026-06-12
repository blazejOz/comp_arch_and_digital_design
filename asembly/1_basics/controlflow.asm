section .data
    msg db "%s", 10 , 0
    true_string db "true", 0
    false_string db "false", 0

section .text
    extern printf
    global main

main:
    call if_statment
    call loop
    ret

if_statment:
    mov eax, 1
    cmp eax, 1
    je .if_true

.if_false:
    mov eax, false_string
    call print
    jmp .end

.if_true:
    mov eax, true_string
    call print

.end:
    ret

loop:
    mov ecx, 5

.loop_start:
    mov eax, ecx
    call print
    dec ecx
    jnz .loop_start
    jmp .end

.end: 
    ret


print:
    push eax
    push msg
    call printf
    add esp, 8
    ret
    
