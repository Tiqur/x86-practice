; Exit program
%macro exit 0
  mov rax, 60
  mov rdi, 0
  syscall
%endmacro

; Print string
%macro print 1              ; define macro print with args (*char)
  mov rax, %1               ; set rax to pointer to string
  push rax                  ; push pointer of string to stack ( Will need it later )
  mov rbx, 0                ; initialize index with 0 ( This will be used to count the total length of the string )

  %%loop:
    inc rax                 ; increment rax by 1 every loop
    inc rbx                 ; increment rbx by 1 every loop
    mov cl, [rax]           ; move the value of rax into register cl ( 8 bit )
    cmp cl, 0               ; compare cl register to 0 ( end of string )
    jne %%loop              ; loop if cl is not 0

  mov rax, 1                ; sys_write
  mov rdi, 1                ; set file descriptor
  pop rsi                   ; pop location of string to rsi register
  mov rdx, rbx              ; move length of string ( obtained through looping ) into rdx
  syscall                   ; call kernel
%endmacro

section .data
  filename db "data.txt", 0 ; 0 terminated string of filename

section .bss
  text resb 100             ; reserve bytes for file data

section .text
  global _start
_start:

  ; Opens file and sets rax to file descriptor
  mov rax, 2                ; sys_open
  mov rdi, filename         ; set rdi to filename
  mov rsi, 0                ; set flag to readonly
  mov rdx, 0444o            ; set file permissions
  syscall                   ; call kernel
  push rax                  ; push file descriptor onto stack for future use

  ; Reads file into filedata
  mov rdi, rax              ; move file descriptor to rdi
  mov rax, 0                ; sys_read
  mov rsi, text             ; write to reserved bytes
  mov rdx, 99               ; amount of bytes to read
  syscall                   ; call kernel

  ; Close file
  mov rax, 3                ; sys_close
  pop rdi                   ; set rdi to file descriptor
  syscall                   ; call kernel

  ; Print file data
  print text
  
  ; Exit program
  exit

