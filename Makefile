all:
	nasm -f bin source/boot/bootloader.asm -o builds/yaos.bin
	nasm -f elf64 source/kernel/kernel_ent.asm -o builds/bins/kernel_ent.o
	g++ -ffreestanding -m64 -g -c -o builds/bins/kernel.o source/kernel/kernel.cpp
	nasm -f bin source/kernel/zeros.asm -o builds/bins/zeros.bin
	ld -o builds/bins/fkern.bin -Ttext 0x1000 builds/bins/kernel_ent.o builds/bins/kernel.o --oformat binary
	cat builds/yaos.bin builds/bins/fkern.bin builds/bins/zeros.bin > builds/final-yaos.img
run:
	qemu-system-x86_64.exe builds/final-yaos.img

mr: 
	nasm -f bin source/boot/bootloader.asm -o builds/yaos.bin
	nasm -f elf64 source/kernel/kernel_ent.asm -o builds/bins/kernel_ent.o
	g++ -ffreestanding -m64 -g -c -o builds/bins/kernel.o source/kernel/kernel.cpp
	nasm -f bin source/kernel/zeros.asm -o builds/bins/zeros.bin
	ld -o builds/bins/fkern.bin -Ttext 0x1000 builds/bins/kernel_ent.o builds/bins/kernel.o --oformat binary
	cat builds/yaos.bin builds/bins/fkern.bin builds/bins/zeros.bin > builds/final-yaos.img
	qemu-system-x86_64.exe builds/final-yaos.img

mrdbg: 
	nasm -f bin source/boot/bootloader.asm -o builds/yaos.bin
	nasm -f elf64 source/kernel/kernel_ent.asm -o builds/bins/kernel_ent.o
	g++ -ffreestanding -m64 -g -c -o builds/bins/kernel.o source/kernel/kernel.cpp
	nasm -f bin source/kernel/zeros.asm -o builds/bins/zeros.bin
	ld -o builds/bins/fkern.bin -Ttext 0x1000 builds/bins/kernel_ent.o builds/bins/kernel.o --oformat binary
	cat builds/yaos.bin builds/bins/fkern.bin builds/bins/zeros.bin > builds/final-yaos.img
	qemu-system-x86_64.exe -s -S builds/final-yaos.img
