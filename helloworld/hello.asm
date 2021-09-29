section .text
  global _start ;Entry point for linker / loader

section .data ;Immutable data
  msg db "Hello, world!", 10
  len equ $ -msg  ;length of string

section .text
_start:

mov edx, len
mov ecx, msg
mov ebx, 1
mov eax, 4
int 0x80

mov ebx, 0
mov eax, 1
int 0x80
