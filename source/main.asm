[org 0x7c00]
char:
    db 0
mov ah, 0
int 0x16
mov al, [char]
int 0x10


jmp $


times 510-($-$$) db 0
db 0x55, 0xaa