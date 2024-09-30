#include <stdbool.h>
const int VGA_WIDTH = 80;
const int VGA_HEIGHT = 25;

// VGA text mode buffer
char* video_memory = (char*)0xB8000;

int col, row;

struct v2 {
	int x;
	int y;
};

void outb(unsigned short port, unsigned char data) {
	asm volatile(
		"outb %0, %1"
		:
		: "a"(data), "Nd"(port)
	);
}

void move_cursor(struct v2 position) {
	outb(0x3D4, 14);
	outb(0x3D5, (position.y * VGA_WIDTH + position.x) >> 8);
	outb(0x3D4, 15);
	outb(0x3D5, position.y * VGA_WIDTH + position.x);
}

void cls() {
	for (int i = 0; i < VGA_HEIGHT * VGA_WIDTH; i++) {
		video_memory[i * 2] = ' ';
		video_memory[i * 2 + 1] = 0x0F;
	}
}

void putc(char c, bool puts) {
	if (c == '\n') {
		col = 0;
		row++;
	} else {
		video_memory[(row * VGA_WIDTH + col) * 2] = c;
		video_memory[(row * VGA_WIDTH + col) * 2 + 1] = 0x0F;
		col++;
	}
	if (col >= VGA_WIDTH) {
		col = 0;
		row++;
	}
	if (row >= VGA_HEIGHT) {
		row = 0;
	}
	if(!puts)
		move_cursor((struct v2){col, row});
}

void puts(const char* str) {
	for (int i = 0; str[i] != '\0'; i++) {
		putc(str[i], true);
	}
	move_cursor((struct v2){col, row});
}

void initialize() {
	col = 0;
	row = 0;
	cls();
	move_cursor((struct v2){0, 0});
	puts("initialized\n");
}

void kernel_main() {
	initialize();
	puts("Welcome to the YAOS kernel");
}