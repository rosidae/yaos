; authored by Rosidae
; boot/bootloader.asm
; bootloader for YAOS

[org 0x7c00]
mov ah, 0x0e
mov bx, var

pntstr:
    mov al, [bx]
    cmp al, 0
    je end
    int 0x10
    inc bx
    jmp pntstr


end:
    jmp $

var:
    db "this is NOT yaos", 0

times 510-($-$$) db 0
db 0x55, 0xaa