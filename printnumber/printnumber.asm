; Exit program
%macro exit 0
  mov rax, 60
  mov rdi, 0
  syscall
%endmacro

; Print ascii character
%macro printASCII 1
    mov rax, %1
    mov [digit], al    ; move least significant byte into 'digit'
    mov rax, 1         ; sys_write
    mov rdi, 1         ; set file descriptor
    mov rsi, digit     ; set text
    mov rdx, 2         ; set text length ( 2 bytes since 2nd is always 10 ( new line ) )
    syscall
%endmacro

; Print arbitrary length integer
%macro printInteger 1  ; (int)
  mov r8, 0            ; initialize length ( amount of bytes in integer )
  mov rax, %1

  ; Evalulate and push digits to stack
  %%_loop:
    inc r8            ; increment length
    xor rdx, rdx      ; set rdx register to 0 ( to avoid SIGFPE )
    mov rsi, 10       ; move 10 into rsi
    div rsi           ; rax = (rax / 10) rdx = (rax % 10)

    add rdx, 48       ; increment rdx by 48
    push rdx          ; push digit to stack

    cmp rax, 0        ; compare rax and 0
  jne %%_loop         ; jump to _loop if rax != 0

  ; Print each digit
  %%_printLoop:
      pop rax         ; pop stack into rax
      printASCII rax  ; call printDigit
      dec r8          ; ( cl = cl - 1 )
      cmp r8, 0       ; compare cl and 0
    jg %%_printLoop   ; jump to _printLoop if rax >= 0

    printASCII 10     ; Print newline

%endmacro

section .data
  digit db 0      ; initialize first byte to zero

section .text
  global _start
  
  _start:
    printInteger 123456789
    exit
