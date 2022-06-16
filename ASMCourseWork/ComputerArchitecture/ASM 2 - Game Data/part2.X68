*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:
    LEA Comma,  A1      ; Loading Comma for tidying display
    LEA Health, A2
    
    MOVE.B  #100,Health
    
    MOVE.B  Health,D1     ; Moving Health value into D1
    MOVE.B  #100,D1       ; Initializing health to #100
    MOVE.B  #100,Health   ; Setting Health to initial value in memory location
    MOVE.B  #3,D0         ; Displaying signed number in D1
    TRAP    #15
    
    LEA     Health,A2                     
    MOVE.B  (A2),D3
    ADD.B   #5,D3         ; Add $5 to current value of Health
    MOVE.B  D3,Health     ; Set Health to new calculated value
    
                        ; Display Current Value (as decimal)
    MOVE.B  #6,D0       ; Task 6: Display single character in D1
    MOVE.B  (A1),D1     ; Placing comma in D1 to print
    TRAP    #15         ; Displaying Comma
    
    MOVE.B  Health,D1   ; Moving current calculated value into D1
    MOVE.B  #3,D0       ; Task 6 - Display numeric value in D1
    TRAP    #15         ; Displaying modified value in D1
    
    LEA     Health,A2                     
    MOVE.B  (A2),D3
    SUB.B   #5,D3       ; Subtract $5 from current value
    MOVE.B  D3,(A2)
    
    MOVE.B  #6,D0       ; See "Display Current Value"
    MOVE.B  (A1),D1
    TRAP    #15
    MOVE.B  Health,D1
    MOVE.B  #3,D0
    TRAP    #15

    LEA     Health,A2                     
    MOVE.B  (A2),D3
    MOVE.B  Health,D3
    MULS.W  #2,D3         ; Multiply current value by $2
    MOVE.B  D3,Health
    
    MOVE.B  #6,D0       ; See "Display Current Value"
    MOVE.B  Health,D1
    TRAP    #15
    MOVE.B  Health,D1
    MOVE.B  #3,D0
    TRAP    #15

                        
    LEA     Health,A2                     
    MOVE.B  (A2),D3
    DIVU.W  #2,D3       ; Divide current value by $2
    MOVE.B  D3,Health
    
    MOVE.B  #6,D0       ; See "Display Current Value"
    MOVE.B  (A1),D1
    TRAP    #15
    MOVE.B  Health,D1
    MOVE.B  #3,D0
    TRAP    #15
    SIMHALT

Health  dc.b    $10
Comma   dc.b    ','
    END    START


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
