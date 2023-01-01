    ORG    $1000
START:
   
    BRA     GAME_LOOP                 

GAME_LOOP
    BSR     INPUT
    BSR     UPDATE
    BSR     CHECK_WIN_LOSE_CONDITIONS ; Redundant with update?
    BRA     GAME_LOOP
    
INPUT
    ; Prompt User for Input
    LEA     PROMPT,A1
    MOVE.B  (A1),D1
    MOVE.B  #13, D0
    TRAP    #15
    
    ; Read Input
    MOVE.B  #4,D0
    TRAP    #15
        
    RTS
    
UPDATE
    MOVE.B  D1,D4       ; Storing Player choice to free D1 for traps
    LEA     ROCK,A1     ; Computer's choice, deterministic now
    MOVE.B  (A1),D5     ; Storing Computer's choice in D5
    RTS
    
DRAW
    RTS
    
CHECK_WIN_LOSE_CONDITIONS
    ; Probably worth using their own labels
    ; Will need to reset label if number is not in range
    ; Rock > Scissor (1 - 3 = -2)
    ; Scissor > Paper (3 - 2 = 2)
    ; Paper > Rock (2 - 1 = 1)
    ; Rock - Paper == P - S therefore check player's input first, then compare it against the computer
    CMP.B   #1, D4
    BEQ     CHECK_ROCK
    CMP.B   #2, D4
    BEQ     CHECK_PAPER
    CMP.B   #3, D4
    BEQ     CHECK_SCISSORS
    RTS
    
CHECK_ROCK
    ; Debug Prom
    LEA     PICKEDROCK,A1
    MOVE.B  (A1),D1
    MOVE.B  #13, D0
    TRAP    #15

    RTS
    
CHECK_PAPER
    LEA     PICKEDPAPER,A1
    MOVE.B  (A1),D1
    MOVE.B  #13, D0
    TRAP    #15
    RTS
    
CHECK_SCISSORS
    LEA     PICKEDKNIFE,A1
    MOVE.B  (A1),D1
    MOVE.B  #13, D0
    TRAP    #15
    RTS
    
    SIMHALT
PROMPT      DC.B   'Rock (1), Paper (2), Scissors (3)?',0
PICKEDROCK  DC.B   'Player picked Rock',0
PICKEDPAPER DC.B   'Player picked Paper',0
PICKEDKNIFE DC.B   'Player picked Scissors',0          
ROUNDSWON   DC.B   $0
ROCK        DC.B   $1
PAPER       DC.B   $2
SCISSORS    DC.B   $3
    END    START       
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
