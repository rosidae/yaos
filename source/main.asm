; authored by Rosidae
; main.asm
; main file for YAOS

[org 0x7c00]
call cls
mov ah, 0x0e
mov bx, var

print:
    mov al, [bx]
    cmp al, 0
    je end
    int 0x10
    inc bx
    jmp print
end:
    jmp $
var:
    db "Welcome to YAOS, this is the bios", 0
cls:
    pusha
    mov ah, 0x00
    mov al, 0x03  ; text mode 80x25 16 colours
    int 0x10
    popa
    ret


times 510-($-$$) db 0
db 0x55, 0xaa