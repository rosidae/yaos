all:
	nasm -f bin source/boot/bootloader.asm -o builds/yaos.bin
	nasm -f elf64 source/kernel/kernel_ent.asm -o builds/bins/kernel_ent.o
	gcc -ffreestanding -m64 -g -c -o builds/bins/kernel.o source/kernel/kernel.c
	nasm -f bin source/kernel/zeros.asm -o builds/bins/zeros.bin
	ld -o builds/bins/fkern.bin -Ttext 0x1000 builds/bins/kernel_ent.o builds/bins/kernel.o
	cat builds/yaos.bin builds/bins/fkern.bin builds/bins/zeros.bin > builds/final-yaos.img
run:
	qemu-system-x86_64.exe builds/final-yaos.img

mr: 
	nasm -f bin source/boot/bootloader.asm -o builds/yaos.bin
	nasm -f elf source/kernel/kernel_ent.asm -o builds/bins/kernel_ent.o
	gcc -ffreestanding -lgcc -m32 -g -c -o builds/bins/kernel.o source/kernel/kernel.c
	nasm -f elf source/kernel/zeros.asm -o builds/bins/zeros.bin
	ld -o builds/bins/fkern.bin -Ttext 0x1000 builds/bins/kernel.o builds/bins/kernel_ent.o
	type builds/yaos.bin builds/bins/fkern.bin builds/bins/zeros.bin > builds/final-yaos.img
	qemu-system-x86_64.exe builds/final-yaos.img