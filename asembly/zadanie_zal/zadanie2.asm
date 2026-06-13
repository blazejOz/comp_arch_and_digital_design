section .data
    a1 db "A3F", 0
    a2 db "1B3", 0

    msg_error db "Invalid input", 10, 0
    msg_print db "Result: %s", 10, 0

section .bss
    result_buffer resb 64

section .text
    extern printf
    global main

main:
    push a2
    call validate_hex
    add esp, 4
    cmp eax, 0
    je .invalid_input

    push a1
    call validate_hex
    add esp, 4
    cmp eax, 0
    je .invalid_input

    push result_buffer
    push a2
    push a1
    call add_hex_strings
    add esp, 12

    push eax
    push msg_print
    call printf
    add esp, 8
    ret

.invalid_input:
    push msg_error
    call printf
    add esp, 4
    ret


validate_hex:
    push ebp
    mov ebp, esp
    mov edx, [ebp + 8]

.next_char:
    mov al, [edx]
    cmp al, 0
    je .all_valid

    cmp al, '0'
    jb .invalid
    cmp al, '9'
    jbe .valid

    cmp al, 'A'
    jb .invalid
    cmp al, 'F'
    jbe .valid

.invalid:
    mov eax, 0
    jmp .done

.valid:
    inc edx
    jmp .next_char

.all_valid:
    mov eax, 1

.done:
    mov esp, ebp
    pop ebp
    ret

add_hex_strings:
    push ebp
    mov ebp, esp

    mov esi, [ebp + 8]
    mov edi, [ebp + 12]
    mov edx, [ebp + 16]

    mov ecx, esi          
.find_end_a1:
    cmp byte [esi], 0
    je .calc_len_a1
    inc esi               
    jmp .find_end_a1
.calc_len_a1:
    mov eax, esi          
    sub eax, ecx         
    dec esi

    mov ecx, edi         
.find_end_a2:
    cmp byte [edi], 0
    je .calc_len_a2
    inc edi
    jmp .find_end_a2
.calc_len_a2:
    mov ebx, edi          
    sub ebx, ecx    
    dec edi

.move_buffer:
    mov edx, [ebp + 16]   
    add edx, 63           
    mov byte [edx], 0

    xor ecx, ecx
.add_loop:
    dec edx

    cmp esi, [ebp + 8]
    jb .a1_empty
    mov al, [esi]
    dec esi
    jmp .convert_a1
.a1_empty:
    mov al, '0'
.convert_a1:
    cmp al, '9'
    jbe .a1_is_num
    sub al, 'A'
    add al, 10
    jmp .save_a1
.a1_is_num:
    sub al, '0'
.save_a1:
    mov bl, al

    cmp edi, [ebp + 12]
    jb .a2_empty
    mov al, [edi]
    dec edi
    jmp .convert_a2
.a2_empty:
    mov al, '0'
.convert_a2:
    cmp al, '9'
    jbe .a2_is_num
    sub al, 'A'
    add al, 10
    jmp .save_a2
.a2_is_num:
    sub al, '0'
.save_a2:

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
    jmp .write_char

.to_num:
    add al, '0'
    
.write_char:
    mov [edx], al

    cmp esi, [ebp + 8]
    jae .add_loop
    cmp edi, [ebp + 12]
    jae .add_loop
    cmp ecx, 0
    jne .add_loop

    mov eax, edx

    mov esp, ebp
    pop ebp
    ret