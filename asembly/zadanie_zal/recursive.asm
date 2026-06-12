section .data
    a1 db "111", 0
    a2 db "FFF", 0
    msg_print db "Result: %s", 10, 0

section .bss
    result_buffer resb 64

section .text
    extern printf
    global main

main:
    mov esi, a1
.find_end_a1:
    cmp byte [esi], 0
    je .calc_len_a1
    inc esi
    jmp .find_end_a1
.calc_len_a1:
    dec esi

    mov edi, a2
.find_end_a2:
    cmp byte [edi], 0
    je .calc_len_a2
    inc edi
    jmp .find_end_a2
.calc_len_a2:
    dec edi

    mov edx, result_buffer
    add edx, 63
    mov byte [edx], 0
    dec edx

    push 0
    push edx
    push edi
    push esi
    call add_recursive
    add esp, 16

    push eax
    push msg_print
    call printf
    add esp, 8
    ret

add_recursive:
    push ebp
    mov ebp, esp

    mov esi, [ebp + 8]
    mov edi, [ebp + 12]
    mov edx, [ebp + 16]
    mov ecx, [ebp + 20]

    cmp esi, a1
    jb .check_edi_empty
    mov al, [esi]
    dec esi
    jmp .conv_a1

.check_edi_empty:
    cmp edi, a2
    jb .check_carry_empty
    mov al, '0'
    jmp .conv_a1

.check_carry_empty:
    cmp ecx, 0
    je .base_case
    mov al, '0'

.conv_a1:
    cmp al, '9'
    jbe .a1_num
    sub al, 'A'
    add al, 10
    jmp .get_a2
.a1_num:
    sub al, '0'

.get_a2:
    mov bl, al
    cmp edi, a2
    jb .a2_empty
    mov al, [edi]
    dec edi
    jmp .conv_a2
.a2_empty:
    mov al, '0'

.conv_a2:
    cmp al, '9'
    jbe .a2_num
    sub al, 'A'
    add al, 10
    jmp .do_math
.a2_num:
    sub al, '0'

.do_math:
    add al, bl
    add al, cl
    xor ecx, ecx

    cmp al, 16
    jb .no_carry
    sub al, 16
    mov ecx, 1
.no_carry:

    cmp al, 9
    jbe .to_num
    add al, 'A'
    sub al, 10
    jmp .write
.to_num:
    add al, '0'

.write:
    mov [edx], al
    dec edx

    push ecx
    push edx
    push edi
    push esi
    call add_recursive
    add esp, 16
    jmp .done

.base_case:
    inc edx
    mov eax, edx

.done:
    mov esp, ebp
    pop ebp
    ret