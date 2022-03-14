all:
	nasm -f bin source/main.asm -o yaos.bin

run:
	qemu-system-x86_64.exe .\yaos.bin

mr: 
	nasm -f bin source/main.asm -o yaos.bin
	qemu-system-x86_64.exe .\yaos.bin