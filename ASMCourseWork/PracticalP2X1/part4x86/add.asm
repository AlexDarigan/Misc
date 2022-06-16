global add

section .data
section .text
add:
    mov   eax, [esp+4]      ; argument 1
    add   eax, [esp+8]      ; argument 2
    add   eax, [esp+12]     ; argument 3
    ret