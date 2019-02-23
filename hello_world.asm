; zero register
; Sets a register to zero, note that this will affect CFLAGS
%macro zero 1
  xor %1, %1
%endmacro

; set
; Sets a register to a constant in the most efficient way possible
%macro set 2
  %if %2==0
    zero %1
  %else
    mov %1, %2
  %endif
%endmacro

; define_string label string
; Defines the string and saves the length in a macro called <label>_length
%macro define_string 2
  %1 db %2
  %strlen %1_length %2
%endmacro

; print_clobber string, length, return_address
; Writes a string to stdout, clobbering registers in the process for efficiency
%macro print_clobber 2
  set eax, sys_write
  set ebx, stdout
  set ecx, %1
  set edx, %1_length
  push %2
  lea ebp, [esp-12]
  sysenter
%endmacro

; exit
%macro exit 0
  set eax, sys_exit
  set ebx, 0
  set ebp, esp
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
