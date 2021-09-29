section .data
  digit db 0, 10  ; initialize first byte to zero, and 2nd to 10 ( new line )

section .text
  global _start
  
  _start:
    ; Print 7
    mov rax, 7
    call _printDigit

    ; Exit program
    mov rax, 60           ; sys_exit
    mov rdi, 0            ; set error code to 0
    syscall



  _printDigit:
    add rax, 48           ; increment rax by 48
    mov [digit], al       ; move least significant byte into 'digit'
    mov rax, 1            ; sys_write
    mov rdi, 1            ; set file descriptor
    mov rsi, digit        ; set text
    mov rdx, 2            ; set text length ( 2 bytes since 2nd is always 10 ( new line ) )
    syscall
    ret

