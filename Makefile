all: build/hello_world.o
	ld -o build/hello_world build/hello_world.o -melf_i386

build/hello_world.o: src/hello_world.asm src/macros.asm
	nasm -f elf src/hello_world.asm -o build/hello_world.o
