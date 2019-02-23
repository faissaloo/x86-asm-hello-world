section	.data
  message db `Hello world!\n`
  message_length equ $ - message

  stdout equ 1

  sys_exit equ 1
  sys_write equ 4

; print_clobber string, length, return_address
; Writes a string to stdout, clobbering registers in the process for efficiency
%macro print_clobber 3
  mov eax, sys_write
  mov ebx, stdout
  mov ecx, %1
  mov edx, %2
  push %3
  lea ebp, [esp-12]
  sysenter
%endmacro

; exit
%macro exit 0
  mov eax, sys_exit
  mov ebp, esp
  sysenter
%endmacro

section	.text
  global _start

_start:
  print_clobber message, message_length, _exit

_exit:
  exit
