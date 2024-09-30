all:
	mkdir -p build
	i686-elf-as src/boot.s -o build/boot.o
	i686-elf-gcc -c src/kernel.c -o build/kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
	i686-elf-gcc -T linker.ld -o build/myos.bin -ffreestanding -O2 -nostdlib build/boot.o build/kernel.o -lgcc
	mkdir -p isodir/boot/grub
	cp build/myos.bin isodir/boot/myos.bin
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o build/myos.iso isodir

run:
	qemu-system-i386 -cdrom build/myos.iso

# compile and run
mr: all run