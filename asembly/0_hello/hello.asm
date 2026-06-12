; hello.asm - My first NASM program!
; This program prints "Hello, Assembly!" to the console

section .data
    ; Define our message with a newline at the end
    msg db "Hello, Assembly!", 10    ; 10 is newline character '\n'
    msg_len equ $ - msg               ; Calculate length (current pos - start)

section .text
    global _start

_start:
    ; Write message to stdout
    ; syscall: sys_write (rax = 1)
    ; rdi = file descriptor (1 = stdout)
    ; rsi = pointer to message
    ; rdx = message length
    
    mov rax, 1          ; syscall number for sys_write
    mov rdi, 1          ; file descriptor 1 = stdout
    mov rsi, msg        ; address of message
    mov rdx, msg_len    ; length of message
    syscall             ; make the system call
    
    ; Exit program
    ; syscall: sys_exit (rax = 60)
    ; rdi = exit code
    
    mov rax, 60         ; syscall number for sys_exit
    xor rdi, rdi        ; exit code 0 (success)
    syscall             ; make the system call