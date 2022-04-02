section .text
    [bits 32]
    [extern puts]
    [extern main]
    call main
    jmp $