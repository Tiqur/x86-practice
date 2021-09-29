section .data
  text1 db "What is your name? "
  len1 equ $ -text1

  text2 db "Hello, "
  len2 equ $ -text2

  name_len equ 16     ; length of "name" input

section .bss
  name resb name_len  ; reserve 16 bytes of memory 

section .text
  global _start

_start:
  call _printText1
  call _getName
  call _printText2
  call _printName

  mov rax, 60     ; sys_exit
  mov rdi, 0      ; set error_code
  syscall

_printText1:
  mov rax, 1      ; sys_write
  mov rdi, 1      ; set file descriptor
  mov rsi, text1  ; set text
  mov rdx, len1   ; set text length
  syscall
  ret
  

_printText2:
  mov rax, 1      ; sys_write
  mov rdi, 1      ; set file descriptor
  mov rsi, text2  ; set text
  mov rdx, len2   ; set text length
  syscall
  ret

_getName:
  mov rax, 0      ; sys_read
  mov rdi, 0      ; set file descriptor
  mov rsi, name   ; store input into "name"
  mov rdx, name_len ; set read length ( bytes )
  syscall
  ret

_printName:
  mov rax, 1      ; sys_write
  mov rdi, 1      ; set file descriptor
  mov rsi, name   ; set text to "name"
  mov rdx, name_len ; set output len to "name_len"
  syscall
  ret
