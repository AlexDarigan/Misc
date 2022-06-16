
    ORG    $1000
START:

    ; TASK 1   
    LEA     greeting, A1    ; Loading the effective address of greeting into A1
    MOVE.B  (A1),D1         ; Derefencing the address at A1 and loading the value into D1
    MOVE.B  #1, D0          ; Moving task 1 into D0
    TRAP    #15             ; Displaying the string stored at D1
  
    ; TASK 5
    MOVE.B  #5, D0          ; Moving task 5 into D0
    TRAP    #15             ; Reading in a single character
  
    ; TASK 8
    MOVE.B  #8, D0          ; Moving task 8 into D0
    TRAP    #15             ; Returning time in hundreadths of a second since midnight in D1
    CLR.L   D1              ; Moving the
  
    ; TASK 11
    MOVE.L  $00220052, D1   ; Moving the hex number 0502 with word lenght into D1
    MOVE.B  #11,D0          ; Moving task 11 into D0
    TRAP    #15             ; Setting the positon at row 2 and column 5
    CLR.L   D1              ; Clearing D1 to prevent bad memory
 
    ; TASK 13
    LEA     greeting,A1     ; Loading the effective address of greeting into A1
    MOVE.B  (A1),D1         ; Derefencing the address at A1 and loading the value into D1
    MOVE.B  #13,D0          ; Moving task 13 into D0
    TRAP    #15             ; Displaying a null terminated string with CR & LF
 
    ; TASK 17
    LEA     greeting,A1     ; Loading the effective address of greeting into A1
    MOVE.B  #10,D1          ; Moving the decimal value in D1
    MOVE.B  #17,D0          ; Moving task 17 into D0
    TRAP    #15             ; Displaying the string stored at the address in A1 and then the decimal number stored in D1
 
    ; TASK 18
    LEA     greeting,A1     ; Loading the effective address of greeting into A1
    MOVE.B  #18,D0          ; Moving task 18 into D0
    TRAP    #15             ; Displaying the string stored at the address in A1 and then read in a number from the keyboard
  
    ; TASK 21   
    MOVE.L  $00222222,D1    ; Moving hex code for blue into D1
    MOVE.B  %00000011,D2    ; Setting font style to bold and italic
    MOVE.B  #21,D0          ; Moving task 21 into D0
    TRAP    #15             ; Changing the font color and style

    SIMHALT

greeting    dc.b    'Hello, World',0            

    END    START    

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
