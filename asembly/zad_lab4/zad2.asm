section .data
    fmt db "result %d", 10, 0
    my_string db "Hello World", 0   ; Nasz napis (zakończony 0)

section .text
    extern printf
    global main

main:
    push ebp
    mov ebp, esp

    push my_string
    call count_words
    add esp, 4

    push eax
    push fmt
    call printf
    add esp, 8

    xor eax, eax
    pop ebp
    ret


count_words:
    push ebp
    mov ebp, esp

    mov edx, [ebp + 8]
    xor eax, eax
    xor ecx, ecx

.loop:
    cmp byte [edx + ecx], 0
    je .done
    cmp byte [edx + ecx], 32
    jne .not_space
    inc eax
.not_space:
    inc ecx
    jmp .loop

.done:
    inc eax
    pop ebp
    ret