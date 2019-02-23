all: hello_world.o
	ld -o hello_world hello_world.o -melf_i386

hello_world.o: hello_world.asm
	nasm -f elf hello_world.asm
