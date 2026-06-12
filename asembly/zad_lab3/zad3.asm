section .data 
    msg db "%d",10 ,0

section .text
    extern printf
    global main

main:
    mov eax, 1764
    mov ebx, 352
    mul ebx
    mov ecx, 2
    mov edx, 0
    div ecx
    cmp eax, 300000
    jl .less_then
    mov eax, 0
    call print
    ret

.less_then:
    mov eax, 1
    call print
    ret

print:
    push eax
    push msg
    call printf
    add esp, 8
    ret