section .data
    msg db "%s", 10, 0
    error_msg db "error", 10, 0
    string_a1 db "A6", 0
    string_a2 db "1DD", 0

section .bss
    result resb 10

section .text
    extern printf
    global main

main:
    mov esi, string_a1
    mov edi, string_a2
    call validate
    call calculate_fib
    call print
    ret

validate:
.check_a1:
    mov al, [esi]
    cmp al, 0
    je .check_a2
    cmp al, '0'
    jl .error
    cmp al, '9'
    jle .ok_char_a1
    cmp al, 'A'
    jl .error
    cmp al, 'F'
    jle .ok_char_a1
    jmp .error
.ok_char_a1:
    inc esi
    jmp .check_a1

.check_a2:
    mov al, [edi]
    cmp al, 0
    je .done
    cmp al, '0'
    jl .error
    cmp al, '9'
    jle .ok_char_a2
    cmp al, 'A'
    jl .error
    cmp al, 'F'
    jle .ok_char_a2
    jmp .error
.ok_char_a2:
    inc edi
    jmp .check_a2

.done:
    ret

.error:
    mov eax, error_msg
    call print
    add esp, 4
    ret

calculate_fib:
    dec esi
    dec edi
    mov ebx, result
    add ebx, 9
    mov byte [ebx], 0
    dec ebx
    xor ah, ah

.loop_add:
    cmp esi, string_a1
    jl .check_edi
    mov al, [esi]
    cmp al, '9'
    jle .digit1
    sub al, 'A'
    add al, 10
    jmp .add_edi
.digit1:
    sub al, '0'
    jmp .add_edi
.skip_esi:
    xor al, al

.add_edi:
    cmp edi, string_a2
    jl .do_sum
    mov dl, [edi]
    cmp dl, '9'
    jle .digit2
    sub dl, 'A'
    add dl, 10
    jmp .do_sum
.digit2:
    sub dl, '0'

.do_sum:
    add al, dl
    add al, ah
    xor ah, ah
    cmp al, 15
    jbe .no_carry
    sub al, 16
    mov ah, 1

.no_carry:
    cmp al, 9
    jbe .to_digit
    add al, 'A'
    sub al, 10
    jmp .save
.to_digit:
    add al, '0'

.save:
    mov [ebx], al
    dec ebx
    dec esi
    dec edi
    
    cmp esi, string_a1
    jae .loop_add
    cmp edi, string_a2
    jae .loop_add
    cmp ah, 0
    jne .loop_add

    inc ebx
    mov eax, ebx
    ret

.check_edi:
    jmp .skip_esi

print:
    push eax
    push msg
    call printf
    add esp, 8
    ret