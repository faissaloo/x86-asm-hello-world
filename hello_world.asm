; define_string label string
; Defines the string and saves the length in a macro called <label>_length
%macro define_string 2
  %1 db %2
  %strlen %1_length %2
%endmacro

; print_clobber string, length, return_address
; Writes a string to stdout, clobbering registers in the process for efficiency
%macro print_clobber 2
  mov eax, sys_write
  mov ebx, stdout
  mov ecx, %1
  mov edx, %1_length
  push %2
  lea ebp, [esp-12]
  sysenter
%endmacro

; exit
%macro exit 0
  mov eax, sys_exit
  xor ebx, ebx
  mov ebp, esp
  sysenter
%endmacro

section	.data
  define_string message, `Hello world!\n`

  stdout equ 1

  sys_exit equ 1
  sys_write equ 4

section	.text
  global _start

_start:
  print_clobber message, _exit

_exit:
  exit
