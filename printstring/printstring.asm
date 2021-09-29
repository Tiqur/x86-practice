section .data
  msg db "An arbitrary length string", 10, 0

section .text
global _start
_start:
  mov rax, msg
  call _print

  ; exit
  mov rax, 60
  mov rdi, 0
  syscall

_print:           ; print string of any length
  push rax        ; push pointer of strint to stack ( Will need it later )
  mov rbx, 0      ; initialize index with 0 ( This will be used to count the total length of the string )

_printLoop:
  inc rax         ; increment rax by 1 every loop
  inc rbx         ; increment rbx by 1 every loop
  mov cl, [rax]   ; move the value of rax into register cl ( 8 bit )
  cmp cl, 0       ; compare cl register to 0 ( end of string )
  jne _printLoop  ; loop if cl is not 0

  mov rax, 1      ; sys_write
  mov rdi, 1      ; set file descriptor
  pop rsi         ; pop location of string to rsi register
  mov rdx, rbx     ; move length of string ( obtained through looping ) into rdx
  syscall         ; call kernel
  ret
