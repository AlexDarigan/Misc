    ORG    $1000
START:                  

    ; Ask user for gamer points
    ; Stores a gamers point in a memory location
    ; Displays points on screen

    LEA     prompt,A1   ; Load address of prompt into A1
    MOVE.W  (A1),D1     ; Move value of prompt into D1
    
                        ; Prompt user to enter points
    MOVE    #14,D0      ; Task 14 - Display String (Prompt) from D1
    TRAP    #15         
    
    MOVE.B  #4,D0       ; Reading gamer points from keyboard
    TRAP    #15         ; Task 4 - Request user numeric input into D1
    
    MOVE.B  D0, $4001   ; Moving gamer points to location in memory
    
    MOVE.B  #3,D0       ; Displaying gamer points 
    TRAP    #15         ; Task 3 - Display Numeric
    SIMHALT            

prompt  dc.b    'Please enter gamer points: ',0
    END    START

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
