section .data
    fmt db "result %d", 10, 0

section .text
    extern printf
    global main

main:
    mov esi, 3729583        ; ESI = Our number (Safe from DIV)
    
    ; --- Step 1: Find Integer SQRT ---
    mov ecx, 2
.find_sqrt:
    mov eax, ecx
    mul eax                 ; EAX = ecx * ecx
    cmp eax, esi
    jae .found_sqrt
    inc ecx
    jmp .find_sqrt

.found_sqrt:
    mov edi, ecx            ; EDI = SQRT limit (Safe from DIV)
    
    ; --- Step 2: Main Prime Check Loop ---
    mov ecx, 2              ; Reset counter to 2
.loop:
    cmp ecx, edi            ; Check if counter > SQRT limit
    ja .prime

    mov eax, esi            ; Reload our number into EAX for division
    xor edx, edx            ; Clear EDX before DIV
    div ecx                 ; EDX = EAX % ECX

    cmp edx, 0
    je .not_prime

    inc ecx
    jmp .loop

.not_prime:
    mov eax, 0
    jmp .done

.prime:
    mov eax, 1

.done:
    call print
    xor eax, eax
    ret

print:
    push eax
    push fmt
    call printf
    add esp, 8
    ret