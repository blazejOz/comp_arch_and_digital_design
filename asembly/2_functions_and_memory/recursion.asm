;function that recursivly decrements a value and prints it until its 0

section .data
    fmt db "Result: %d", 10,0
    number dd 3

section .text
    extern printf
    global main

main:
    mov eax, [number]
    push eax
    call sum_recursive
    add esp, 4

    push eax
    push fmt 
    call printf
    add esp, 8
    ret

sum_recursive:
    push ebp
    mov ebp, esp
    push ebx

    mov ebx, [ebp + 8]

    cmp ebx, 0
    je .base_case

    dec ebx
    push ebx
    call sum_recursive
    add esp, 4

    add eax, [ebp + 8]
    jmp .done

.base_case:
    mov eax, 0
.done:
    pop ebx
    mov esp, ebp
    pop ebp
    ret