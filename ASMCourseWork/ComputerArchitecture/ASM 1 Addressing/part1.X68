    ORG    $1000
START:                  
                        ; 0. All of these instructions move the value 9 from various locations
    MOVE.B  #9, D1      ; 1. Storing the literal value 9 in Data Register 1
    MOVE.B  D1, D2      ; 2. Moving the value (9) into from Data Register 1 to Data Register 2
    MOVE.B  D1, 1100    ; 3. Storing value of D1 in memory location 44C (1100 in decimal)
    MOVE.B  1100, D2    ; 4. Moving the value at memory location 44C into Data Register 2
    MOVE.B  1100, 100   ; 5. Moving the value at memory location 44C into memory location 64 (100 in decimal)
    SIMHALT             



    END    START


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
