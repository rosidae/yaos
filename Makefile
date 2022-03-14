all:
	nasm -f bin source/boot/bootloader.asm -o yaos.img
run:
	qemu-system-x86_64.exe .\yaos.img

mr: 
	nasm -f bin source/boot/bootloader.asm -o yaos.bin
	qemu-system-x86_64.exe .\yaos.bin