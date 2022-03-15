extern "C" void kputs(char* str) {
	char* vidmem = (char*)0xb8000;
	while (*str != '\0') {
		*vidmem = *str;
		vidmem+=2;
		str++;
	}
}

extern "C" void main(){
	// char* vidmem = (char*)0xb8000;
	// *vidmem = 'a';
	// vidmem+=2;
	// *vidmem = 'b';
	kputs("h");
    return;
}