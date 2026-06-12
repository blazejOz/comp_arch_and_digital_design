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

    move esp, ebp
    pop ebp
    ret