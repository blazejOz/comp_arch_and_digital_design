section .data
    fmt db "result %d", 10, 0

section .text
    extern printf
    global main


main:
    ;Addition
    mov eax, 27
    add eax, 13
    call print
    
    ;Substraction
    mov eax, 27
    sub eax, 13
    call print

    ;Multiplication
    mov eax, 27
    mov ebx, 13
    mul ebx         ; EAX* EBX solution in EBX:EAX  ->  EAX=baza  EBX=overfolow
    call print

    ;Division
    mov eax, 27     
    mov ebx, 13
    xor edx, edx 
    div ebx         ;EAX-calosci EDX-reszta,  EAX / EBX = 27/13
    call print

    ;Modulo
    mov eax, 27
    mov ebx, 13
    xor edx, edx
    div ebx
    mov eax, edx
    call print
    

    xor eax, eax
    ret


print:
    push eax
    push fmt
    call printf
    add esp, 8
    ret
