extern "C" void kputc(int pos, const char c) {
    char* vidmem = (char*)0xB8000;
    vidmem[2+(pos*2)+1] = c;
}

extern "C" int main(){
    kputc(0, 't');
    kputc(1, 'h');
    kputc(2, 'i');
    kputc(3, 's');
    kputc(4, ' ');
    kputc(5, 'i');
    kputc(6, 's');
    kputc(7, ' ');
    kputc(8, 'y');
    kputc(9, 'a');
    kputc(10, 'o');
    kputc(11, 's');
    return 1;
}