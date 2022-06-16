    ORG    $1000
START:                 
    
    LEA     text, A1    ;Loading the address of the text variable into Address Register 1
    MOVE    #4, D0      ;Moving the value 4 into Data Register 0
    TRAP    #15         ;Reading the value 4 in D0 as instruction to read a number from the user's keyboard into D1
    MOVE    #14, D0     ;Moving the value 14 into Data Register 0
    TRAP    #15         ;Reading the value 14 in D0 as instruction to display null-terminated string at the addr stored in A1
    MOVE    #3, D0      ;Moving the value 3 into Data Register 0
    TRAP    #15         ;Reading the value 3 in D0 as instruction to display a number from D1

    SIMHALT             
text dc.b   'Data Register: ', 0    ;Reserving memory for "text" variable that stores a null teriminated string.
    END    START


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
