section .text
  global _start ;Entry point for linker / loader

section .data ;Immutable data
  msg db "Hello, world!", 10
  len equ $ -msg  ;length of string

section .text
  _start:
    
    call _printHello

    mov rax, 60
    mov rdi, 0
    syscall

  _printHello:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, len
    syscall
    ret
