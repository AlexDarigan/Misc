    ORG    $1000
START:                  
    
    MOVE.B  #9, D1      # 1. Storing the literal value 9 in Data Register 1
    LEA     text, A1    # 2. Load effective address of the text variable into Address Register 1
    MOVE    #14, D0     # 3. Store value 14 in Data Register 0
    TRAP    #15         # 4. Read 14 in D0 as an instruction to display the null terminated string at the address stored in Address Register 1
                        * Note: It seems TRAP implicitly dereferences the address (probably because it isn't immediatly tangible to the user in this case)
                   
    
    MOVE    #3, D0      # 5. Store value 3 in Data Register 0
    TRAP    #15         # 6. Reads 3 in DO as an instruction to display the signed decimal number in D1 (in our case 9)
    SIMHALT            

text dc.b 'Data Register: ', 0  # Reserve memory for "text" variable with a null terminated string value.
    END    START

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
