To assemble, link, and run the program, run these three commands

Assemble: nasm -f elf32 -g -F dwarf -o translate2ascii.o translate2ascii.asm
Link: ld -m elf_i386 -o translate2ascii translate2ascii.o
Run: ./translate2ascii
