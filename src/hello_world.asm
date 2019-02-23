%include "src/macros.asm"

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
