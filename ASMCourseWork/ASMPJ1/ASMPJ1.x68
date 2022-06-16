*-----------------------------------------------------------------------
* STUDENT NAME  : DAVID DARIGAN
* STUDENT ID    : C00263218
* PURPOSE       : DESIGN A GAME BASED ON Games Fleadh 2022 Theme: SDG13
*-----------------------------------------------------------------------


*----------------------------------
* STARTING MEMORY ADDRESS FOR GAME
*----------------------------------

    ORG    $1000

*---------------------------
* VALUES TO BE USED IN GAME 
*---------------------------

CR                  EQU $0D     Carriage Return
LF                  EQU $0A     Line Feed
HT                  EQU $09     Horizontal Tab

*-------------------------
* GAME CONDITION VALUES
*-------------------------

MAX_CARBON          EQU 100     Maximum Carbon
MIN_CARBON          EQU 10      Minimum Carbon

MAX_CASH            EQU 100     Maximum Cash Goal
MIN_CASH            EQU 10      Minimum Required Cash


*-------
* GAME
*--------

START:
    BSR CLEAR_SCREEN        # CLEARING SCREEN IN CASE THIS IS A REPLAY
    BSR WELCOME_MESSAGE
    BSR INITIALIZE_MEMORY
    BSR GAMELOOP

*---------------------------
* GAME ON START SUBROUTINES
*---------------------------

WELCOME_MESSAGE:
    LEA     WelcomeMessage, A1
    MOVE.B  #14,D0
    TRAP    #15
    BSR     DISPLAY_CURSOR
    MOVE.B  #5, D0              WAIT FOR ANY KEY BEFORE CONTINUINING WITH THE GAME
    TRAP    #15
    RTS
    
INITIALIZE_MEMORY:
    MOVE.B  #10, Cash           SET CASH TO THE DEFAULT VALUE #10 DECIMAL
    MOVE.B  #50, Carbon         SET TOTAL CARBON TO THE DEFAULT VALUE #50 DECIMAL
    MOVE.B  #4, Income          SET THE CURRENT INCOME RATE TO THE DEFAULT VALUE #4 
    MOVE.B  #4, CarbonRate
    RTS

*----------------
* CORE GAME LOOP
*----------------

GAMELOOP:
    BSR CLEAR_SCREEN
    BSR PURCHASE
    BSR WAIT
    BSR UPDATE_TOTALS
    BSR CLEAR_SCREEN
    BSR DISPLAY_HUD
    BSR CHECK_GAME_CONDITIONS
    BRA GAMELOOP
    RTS

UPDATE_TOTALS:
    MOVE.B  Cash,D0             RETRIEVE CURRENT CASH VALUE
    MOVE.B  Carbon,D1           RETRIEVE CURRENT CARBON VALUES
    ADD.B   Income,D0           ADD ONE ROUND OF INCOME TO THE CASH VALUE STORED IN D0
    ADD.B   CarbonRate,D1       ADD ONE ROUND OF CARBON TO THE TOTAL CARBON VALUE STORED IN D1
    MOVE.B  D0,Cash             UPDATE CASH WITH THE NEW CASH VALUE FROM D0
    MOVE.B  D1,Carbon           UPDATE CARBON WITH THE NEW CARBON VALUE FROM D1
    RTS


*-----------------------
* PURCHASING ITEMS
*-----------------------

PURCHASE:
    BSR DISPLAY_HUD
    BSR DISPLAY_PROMPT
    BSR DISPLAY_MENU
    BSR GET_INPUT
    BSR TRANSACTION
    RTS    
    
DISPLAY_PROMPT:
    LEA     PurchasePrompt,A1       LOAD EFFECTIVE ADDRESS OF PURCHASE PROMPT CONSTANT TO ADDRESS REGISTER 1
    MOVE.B  #14,D0                  LOAD "DISPLAY STRING" TASK TO D0
    TRAP    #15                     DISPLAY PURCHASE PROMPT
    RTS                             RETURN TO PURCHASE SUBROUTINE

DISPLAY_MENU:
    LEA     PurchaseMenu, A1        LOAD EFFECTIVE ADDRESS OF PURCHASE MENU CONSTANT TO ADDRESS REGISTER 1
    MOVE.B  #14,D0                  LOAD "DISPLAY STRING" TASK TO D0
    TRAP    #15                     DISPLAY PURCHASE MENU
    RTS                             RETURN TO PURCHASE SUBROUTINE

GET_INPUT:
    BSR     DISPLAY_CURSOR          DISPLAY CURSOR (">")
    MOVE.B  #4,D0                   LOAD "READ INT FROM USER" TASK TO D0
    TRAP    #15                     READ INT FROM USER ON ENTER
    RTS                             RETURN TO PURCHASE SUBROUTINE

TRANSACTION:
    CMP.B   #0, D1
    BEQ     PURCHASE_NOTHING        BRANCH TO PURCHASE_NOTHING SUBROUTINE IF 0 WAS SELECTED
    CMP.B   #1,D1
    BEQ     PURCHASE_CHICKEN        BRANCH TO PURCHASE_CHICKEN SUBROUTINE IF 1 WAS SELECTED
    CMP.B   #2,D1
    BEQ     PURCHASE_COW            BRANCH TO PURCHASE_COW SUBROUTINE IF 2 WAS SELECTED
    CMP.B   #3,D1
    BEQ     PURCHASE_SHEEP          BRANCH TO PURCHASE_SHEEP SUBROUTINE IF 3 WAS SELECTED
    CMP.B   #4,D1
    BEQ     PURCHASE_FLOWER         BRANCH TO PURCHASE_FLOWER SUBROUTINE IF 4 WAS SELECTED
    CMP.B   #5,D1
    BEQ     PURCHASE_TREE           BRANCH TO PURCHASE_TREE SUBROUTINE IF 5 WAS SELECTED
    CMP.B   #6,D1
    BEQ     PURCHASE_SOLAR_PANEL    BRANCH TO PURCHASE_SOLAR_PANEL SUBROUTINE IF 6 WAS SELECTED
    CMP.B   #7,D1
    BEQ     PURCHASE_WINDMILL       BRANCH TO PURCHASE_WINDMILL SUBROUTINE IF 7 WAS SELECTED
    BRA     PURCHASE                BRANCH TO PURCHASE IF INVALID INPUT WAS ENTERED

PURCHASE_NOTHING:
    LEA     PurchaseNothing,A1      LOAD EFFECTIVE ADDRESS OF PurchaseNothing CONSTANT TO A1
    LEA     NullObject, A2          LOAD EFFECTIVE ADDRESS OF NullObject TO A2 
    BSR     TRANSACT                BRANCH TO TRANSACT SUBROUTINE TO COMPLETE TRANSACTION ( of Null Object )
    RTS                             RETURN TO PURCHASE SUBROUTINE

PURCHASE_CHICKEN:
    LEA     PurchaseChicken, A1     LOAD EFFECTIVE ADDRESS OF PurchaseChicken CONSTANT TO A1
    LEA     Chicken,A2              LOAD EFFECTIVE ADDRESS OF Chicken TO A2
    BSR     TRANSACT                BRANCH TO TRANSACT SUBROUTINE TO COMPLETE TRANSACTION ( of Chicken )
    RTS                             RETURN TO PURCHASE SUBROUTINE

PURCHASE_COW:
    LEA     PurchaseCow,A1          LOAD EFFECTIVE ADDRESS OF PurchaseCow CONSTANT TO A1
    LEA     Cow,A2                  LOAD EFFECTIVE ADDRESS OF Cow TO A2
    BSR     TRANSACT                BRANCH TO TRANSACT SUBROUTINE TO COMPLETE TRANSACTION ( of Cow )
    RTS                             RETURN TO PURCHASE SUBROUTINE
        
PURCHASE_SHEEP:
    LEA     PurchaseSheep,A1        LOAD EFFECTIVE ADDRESS OF PurchaseSheep CONSTANT TO A1
    LEA     Sheep, A2               LOAD EFFECTIVE ADDRESS OF Sheep TO A2
    BSR     TRANSACT                BRANCH TO TRANSACT SUBROUTINE TO COMPLETE TRANSACTION ( of Sheep )
    RTS                             RETURN TO PURCHASE SUBROUTINE

PURCHASE_FLOWER:
    LEA     PurchaseFlower,A1       LOAD EFFECTIVE ADDRESS OF PurchaseFlower CONSTANT TO A1
    LEA     Flower, A2              LOAD EFFECTIVE ADDRESS OF Flower TO A2
    BSR     TRANSACT                BRANCH TO TRANSACT SUBROUTINE TO COMPLETE TRANSACTION ( of Flower )
    RTS                             RETURN TO PURCHASE SUBROUTINE

PURCHASE_TREE:
    LEA     PurchaseTree,A1         LOAD EFFECTIVE ADDRESS OF PurchaseTree CONSTANT TO A1
    LEA     Tree, A2                LOAD EFFECTIVE ADDRESS OF Tree TO A2
    BSR     TRANSACT                BRANCH TO TRANSACT SUBROUTINE TO COMPLETE TRANSACTION ( of Tree )
    RTS                             RETURN TO PURCHASE SUBROUTINE

PURCHASE_SOLAR_PANEL:
    LEA     PurchaseSolarPanel,A1   LOAD EFFECTIVE ADDRESS OF PurchaseSolarPanel CONSTANT TO A1
    LEA     SolarPanel, A2          LOAD EFFECTIVE ADDRESS OF SolarPanel TO A2
    BSR     TRANSACT                BRANCH TO TRANSACT SUBROUTINE TO COMPLETE TRANSACTION ( of Solar Panel )
    RTS                             RETURN TO PURCHASE SUBROUTINE

PURCHASE_WINDMILL:
    LEA     PurchaseWindmill,A1     LOAD EFFECTIVE ADDRESS OF PurchaseWindmill TO A1
    LEA     Windmill, A2            LOAD EFFECTIVE ADDRESS OF Windmill TO A2
    BSR     TRANSACT                BRANCH TO TRANSACT SUBROUTINE TO COMPLETE TRANSACTION ( of Windmill )
    RTS                             RETURN TO PURCHASE SUBROUTINE

    
TRANSACT:
    MOVE.B  #14,D0              LOAD "DISPLAY STRING" TASK TO D0
    TRAP    #15                 DISPLAY STRING VALUE AT ADDRESS STORED IN A1 (WHICH IS THE MESSAGE LOADED FROM THE CALLING PURCHASE_* SUBROUTINE)

    MOVE.B  (A2)+,D0            MOVE THE COST OF THE CURRENT OBJECT TO D0 THEN INCREMENT THE ADDRESS IN A1 BY ONE PLACE
    CMP.B   Cash,D0             COMPARE THE PLAYER'S TOTAL CASH WITH THE OBJECT'S CASH VALUE
    BGT     REJECT_PURCHASE     IF COST IS GREATER THAN PLAYER'S CASH ON HAND THE GAME REJECTS THE PURCHASE
    SUB.B   D0, Cash            OTHERWISE SUBTRACT THE COST FROM THE PLAYER'S TOTAL CASH

    MOVE.B  (A2)+, D0           MOVE THE PROFIT VALUE OF THE CURRENT OBJECT TO D0 THEN INCREMENT THE ADDRESS IN A1 BY ONE PLACE
    ADD.B   D0, Income          ADD THE PROFIT VALUE OF THE CURRENT OBJECT TO THE PLAYER'S INCOME RATE

    MOVE.B  (A2)+, D0           MOVE THE CARBON PRODUCTION RATE OF THE CURRENT OBJECT T0 D0 THEN INCREMENT THE ADDRESS IN A1 BY ONE PLACE
    ADD.B   D0, CarbonRate      INCREASE THE PLAYER'S CARBON RATE BY THE CARBON PRODUCTION RATE OF THE CURRENT OBJECT ( SOMETIMES 0 )

    
    MOVE.B  (A2), D0            MOVE THE CARBON REDUCTION RATE OF THE CURRENT OBJECT TO D0. THIS IS THE LAST VALUE SO WE DO NOT NEED TO INCREMENT.
    SUB.B   D0, CarbonRate      DECREASE THE PLAYER'S CARBON RATE BY THE CARBON REDUCTION RATE OF THE CURRENT OBJECT ( SOMETIMES 0 )

    RTS


DISPLAY_HUD:
    LEA     HUD_GOALS, A1       
    MOVE.B  #14, D0             
    TRAP    #15                 

    LEA     HUD_LINE,A1         
    MOVE.B  #14,D0
    TRAP    #15

    LEA     CASH_HUD,A1
    MOVE.B  #14,D0
    TRAP    #15

    LEA     Cash,A1
    MOVE.B  (A1),D1
    MOVE.B  #3,D0
    TRAP    #15

    LEA     INCOME_HUD,A1
    MOVE.B  #14,D0
    TRAP    #15

    LEA     Income,A1
    MOVE.B  (A1),D1
    MOVE.B  #3,D0
    TRAP    #15

    LEA     CARBON_HUD,A1
    MOVE.B  #14,D0
    TRAP    #15

    LEA     Carbon, A1
    MOVE.B  (A1),D1
    MOVE.B  #3,D0
    TRAP    #15

    LEA     CARBON_RATE_HUD,A1
    MOVE.B  #14,D0
    TRAP    #15

    LEA     CarbonRate, A1
    MOVE.B  (A1),D1
    MOVE.B  #3,D0
    TRAP    #15

    LEA     HUD_LINE,A1
    MOVE.B  #14,D0
    TRAP    #15
    RTS

CLEAR_SCREEN:
    MOVE.B  #11,D0
    MOVE.W  #$FF00,D1
    TRAP    #15
    CLR.W   D1      ; Preventing Overflow in the DISPLAY_HUD method 
    RTS


DISPLAY_CURSOR:
    LEA     Cursor,A1
    MOVE.B  #14,D0
    TRAP    #15
    RTS

REJECT_PURCHASE:
    LEA     NotEnoughCash,A1
    MOVE.B  #14,D0
    TRAP    #15
    BSR     WAIT
    BRA     PURCHASE

WAIT:
    MOVE.L #100, D1
    MOVEQ #23,D0
    TRAP #15
    RTS

*--------------------------------
* Game Victory / Loss Conditions
*--------------------------------

; Not to self: Branch on right hand values
CHECK_GAME_CONDITIONS:
    BSR     CHECK_CARBON
    BSR     CHECK_CASH
    RTS


CHECK_CARBON:
    LEA     Carbon, A1                  LOAD EFFECTIVE ADDRESS OF TOTAL CARBON TO ADDRESS REGISTER 1
    MOVE.B  (A1),D0                     DEREFERENCE THE VALUE STORED AT THE ADDRESS IN ADDRESS REGISTER 1 T0 D0
    
    CMP.B   #MAX_CARBON,D0              COMPARE THE MAX_CARBON VALUE TO THE PLAYER'S CARBON VALUE STORED AT D0
    BGT     TOO_MUCH_CARBON             IF PLAYER'S (SIGNED) CARBON VALUE EXCEEDS THE MAX CARBON VALUE BRANCH TO TOO_MUCH_CARBON SUBROUTINE
    
    CMP.B   #MIN_CARBON, D0             OTHERWISE COMPARE THE MIN CARBON VALUE TO THE PLAYER'S CARBON VALUE STORED AT D0
    BLS     CARBON_GOAL_REACHED         IF PLAYER'S (UNSIGNED) CARBON VALUE IS BELOW THE MIN CARBON VALUE BRANCH TO CARBON_GOAL_REACHED SUBROUTINE
    
    RTS                                 OTHERWISE RETURN TO CHECK_GAME_CONDITIONS SUBROUTINE

CHECK_CASH:
    LEA     Cash, A1                    LOAD EFFECTIVE ADDRESS OF TOTAL CASH VALUE TO ADDRESS REGISTER 1
    MOVE.B  (A1),D0                     DEFERENCE THE VALUE STORED AT THE ADDRESS IN ADDRESS REGISTER 1 T0 D0
    
    CMP.B   #MIN_CASH,D0                COMPARE THE MIN_CASH VALUE TO THE PLAYER'S CURRENT CASH VALUE STORED AT D0
    BLS     TOO_LITTLE_CASH             IF PLAYER'S (UNSIGNED) CASH VALUE IS LESS THAN THE MIN_CASH VALUE BRANCH TO TOO_LITTLE_CASH SUBROUTINE

    CMP.B   #MAX_CASH,D0                COMPARE THE MAX_CASH VALUE TO THE PLAYER'S CURRENT CASH VALUE STORED AT D1
    BHS     CASH_GOAL_REACHED           IF PLAYER'S (UNSIGNED) CASH VALUE IS GREATER THAN THE MAX_CASH VALUE BRANCH TO CASH_GOAL_REACHED SUBROUTINE
    
    RTS                                 OTHERWISE RETURN TO CHECK_GAME_CONDITIONS SUBROUTINE

    
TOO_MUCH_CARBON:
    LEA     TooMuchCarbon,A1
    MOVE.B  #14, D0
    TRAP    #15                 DISPLAY TooMuchCarbon FAILURE MESSAGE
    BRA GAME_OVER               BRANCH ALWAYS TO GAME_OVER SUBROUTINE
    
TOO_LITTLE_CASH:
    LEA     TooLittleCash,A1  
    MOVE.B  #14, D0             
    TRAP    #15                 DISPLAY TooLittleCash FAILURE MESSAGE
    BRA GAME_OVER               BRANCH ALWAYS TO GAME_OVER SUBROUTINE
    
CASH_GOAL_REACHED:
    LEA     CashGoal,A1
    MOVE.B  #14, D0
    TRAP    #15                 DISPLAY CashGoalReached SUCCESS MESSAGE
    BRA GAME_OVER               BRANCH ALWAYS TO GAME_OVER SUBROUTINE
    
CARBON_GOAL_REACHED:
    LEA     CarbonGoal,A1
    MOVE.B  #14, D0
    TRAP    #15                 DISPLAY CarbonGoalReached SUCCESS MESSSAGE
    BRA GAME_OVER               BRANCH ALWAYS TO GAME_OVER SUBROUTINE

*------------
* GAME END
*-----------

GAME_OVER:
    LEA     ReplayPrompt,A1
    MOVE.B  #14,D0
    TRAP    #15                 ASK PLAYER TO ENTER 1 IF THEY WANT TO REPLAY
    BSR     DISPLAY_CURSOR
    
    MOVE.B  #4,D0
    TRAP    #15                 RETRIEVE INTEGER INPUT FROM USER
    
    CMP.B   #1,D1               COMPARE #1 AGAINST USER INPUT
    BEQ     START               IF EQUAL BRANCH TO START SUBROUTINE
    


END:
    SIMHALT


*------------------------
* Game Data
*------------------------

WelcomeMessage          DC.B  'Sustainable Farming',CR,LF,CR,LF
                        DC.B  ' Welcome to Sustainable Farming, a game about balancing your ',CR,LF
                        DC.B  ' short term self interest against long term group interest. ',CR,LF
                        DC.B  ' Purchase farm production items to increase your income and',CR,LF
                        DC.B  ' reach your total cash goal but avoid producing too much carbon ', CR,LF
                        DC.B  ' otherwise the cash will not be useful in the wasteland created ', CR,LF
                        DC.B  ' by your greed. However you must also stay profitable!',CR,LF
                        DC.B  ' No cash means no survival!',CR,LF, CR,LF
                        DC.B  ' PRESS ANY KEY TO CONTINUE ',CR,LF,0

HUD_LINE                DC.B    CR,LF,' ------------------------------------------------------------------------------',CR,LF,0
HUD_GOALS               DC.B    ' CASH GOAL: 100',HT,'CARBON GOAL: <10', CR,LF
                        DC.B    ' DO NOT GO UNDER $10. DO NOT GO OVER 100 CARBON!',CR,LF,0
CASH_HUD                DC.B    ' CASH: $',0
INCOME_HUD              DC.B    $09,$09,'INCOME: $',0
CARBON_HUD              DC.B    $09,$09,'CARBON: ',0
CARBON_RATE_HUD         DC.B    $09,$09,'CARBON RATE: ',0


PurchasePrompt          DC.B    CR,LF,' Please select a number to purchase the related product',CR,LF,CR,LF
                        DC.B    ' ( Enter 0 to make no purchase )',CR,LF,CR,LF,0
PurchaseMenu            DC.B    ' |   | Name  	  | Produces   | Carbon | Cost | Profit |',CR,LF
                        DC.B    ' |---|--------------|------------|--------|------|--------|',CR,LF
                        DC.B    ' | 1 | Chicken      | Egg        | +1     | $1   | $1     |',CR,LF
                        DC.B    ' | 2 | Cow          | Milk       | +10    | $4   | $2     |',CR,LF
                        DC.B    ' | 3 | Sheep        | Wool       | +6     | $6   | $6     |',CR,LF
                        DC.B    ' | 4 | Flower       | Pollen     | -1     | $1   | $0     |',CR,LF
                        DC.B    ' | 5 | Tree         | Fruit      | -2     | $4   | $2     |',CR,LF
                        DC.B    ' | 6 | Solar Panel  | Electricty | -4     | $12  | $4     |',CR,LF
                        DC.B    ' | 7 | Windmill     | Electricty | -8     | $20  | $4     |',CR,LF,0

Cursor                  DC.B    CR,LF,' > ',0

NotEnoughCash           DC.B    CR,LF,' You do not have enough cash to purchase that item.', CR, LF
                        DC.B    ' Please select another item',CR,LF,0
                        
ReplayPrompt            DC.B    ' Enter 1 to replay. Enter any other key to quit. ',0

; Objects               (Cost, Income, Carbon+, Carbon-)
NullObject              DC.B    $0,$0,$0,$0
Chicken                 DC.B    $1,$1,$1,$0
Sheep                   DC.B    $4,$2,$4,$0
Cow                     DC.B    $6,$6,$A,$0
Flower                  DC.B    $1,$0,$0,$1
Tree                    DC.B    $4,$2,$0,$2
SolarPanel              DC.B    $C,$4,$0,$4
Windmill                DC.B    $14,$4,$0,$8

TooMuchCarbon           DC.B    ' Game Over! You have exceeded the safe carbon amount of under 100!',CR,LF,0
TooLittleCash          DC.B    ' Game Over! You no longer have enough cash to survive!',CR,LF,0
CashGoal                DC.B    ' Congratulations! You have met your cash goal of 100!',CR,LF,0
CarbonGoal              DC.B    ' Congratulations! You have reduced carbon to the miniscule amount of 10!',CR,LF,0

PurchaseNothing         DC.B    CR,LF,CR,LF,' You are purchasing nothing!',0
PurchaseChicken         DC.B    CR,LF,CR,LF,' You are purchasing a Chicken!',0
PurchaseCow             DC.B    CR,LF,CR,LF,' You are purchasing a Cow!',0
PurchaseSheep           DC.B    CR,LF,CR,LF,' You are purchasing a Sheep!',0
PurchaseFlower          DC.B    CR,LF,CR,LF,' You are purchasing a Flower!',0
PurchaseTree            DC.B    CR,LF,CR,LF,' You are purchasing a Tree!',0
PurchaseSolarPanel      DC.B    CR,LF,CR,LF,' You are purchasing a Solar Panel!',0
PurchaseWindmill        DC.B    CR,LF,CR,LF,' You are purchasing a Windmill',0

; Reserving Space for Totals
Cash                    DS.B  1
Income                  DS.B  1
Carbon                  DS.B  1
CarbonRate              DS.B  1
    END START




















*~Font name~Courier~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
