; zero register
; Sets a register to zero, note that this will affect CFLAGS
%macro zero 1
  xor %1, %1
%endmacro

; define_string label string
; Defines the string and saves the length in a macro called <label>.length
%macro define_string 2
  %1 db %2
  %strlen %1.length %2
%endmacro

; print_clobber string, length, return_address
; Writes a string to stdout, clobbering registers in the process for efficiency
%macro print_clobber 2
  mov eax, sys_write
  mov ebx, stdout
  mov ecx, %1
  mov edx, %1.length
  mov ebp, _clobberField-12
  sysenter
_clobberField:
  dd _exit
%endmacro

; exit
%macro exit 0
  mov eax, sys_exit
  zero ebx
  mov ebp, esp
  sysenter
%endmacro
