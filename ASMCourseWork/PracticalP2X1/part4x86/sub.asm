global sub

section .data
section .text
sub:
    mov   eax, [esp+4]      ; argument 1
    sub   eax, [esp+8]      ; argument 2
    sub   eax, [esp+12]     ; argument 3
    ret