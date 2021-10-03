; Exit program
%macro exit 0
  mov rax, 60
  mov rdi, 0
  syscall
%endmacro


section .data
  filename db "data.txt", 0     ; 0 terminated string of filename

section .bss
  filedata resb 100          ; reserve bytes for file data

section .text
  global _start
_start:

  ; Opens file and sets rax to file descriptor
  mov rax, 3                ; sys_open
  mov rdi, filename         ; set rdi to filename
  mov rsi, 0                ; set flag to readonly
  mov rdx, 0444o            ; set file permissions
  syscall                   ; call kernel
  push rax                  ; push file descriptor onto stack for future use

  ; Reads file into filedata
  mov rdi, rax              ; move file descriptor to rdi
  mov rax, 0                ; sys_read
  mov rsi, filedata         ; write to filedata
  mov rdx, 100              ; amount of bytes to read
  syscall                   ; call kernel

  ; Close file
  mov rax, 3                ; sys_close
  pop rdi                   ; set rdi to file descriptor
  syscall                   ; call kernel
  
  exit

