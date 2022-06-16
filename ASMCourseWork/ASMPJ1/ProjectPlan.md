# Sustainable Farming

	A game about balancing short term self interest against long term group interest. 

## Game End Conditions

	| Condition    | Win     | Lose     | 
	|--------------|---------|----------|
	| Total Carbon | < 2500  | > 25,000 |
	| Total Cash   | < 1     | > 1000   |


## Primary Game Loop

	0) Game Initialization
	1) Game Start
		1.1 ) Welcome Message
	2) Game Loop
		2.1 ) Purchase Prompt
			2.1.1 ) Clear Screen
			2.1.2 ) Display HUD
			2.1.3 ) Display Prompt
		2.2 ) Purchase Input
			2.2.1 ) Get Input
			2.2.2 ) Validate Input
			2.2.3 ) Update Running Values
			2.2.4 ) Clear Screen
			2.2.5 ) Display HUD
			2.2.6 ) Wait
		2.3 ) Check Events
		2.4 ) Check Game Conditions
			2.4.1 ) Check Carbon Levels
				2.4.1.A ) [ Total Carbon => MAX_CARBON ] Goto Game Lost
				2.4.1.B ) [ Total Carbon =< MIN_CARBON ] Goto Game Won
			2.4.2 ) Check Cash Amount
				2.4.2.A ) [ Total Cash => MAX_CASH ] Goto Game Won
				2.4.2.B ) [ Total Cahs =< MIN_CASH ] Goto Game Lost
		2.5) Goto Game Loop
	3.0) Game Over
		3.1 ) Game Won
		3.2 ) Game Lost

## Game Economy

### Rates (Decimal)

	| Rate Type         | Small | Medium | Large |
	|-------------------|-------|--------|-------|
	| Carbon Production | 4     | 8      | 16    |
	| Carbon Reduction  | 2     | 4      | 8     | 
	| Purchase Price    | 6     | 8      | 24    |
	| Income Rate       | 2     | 6      | 12    |

### Items

	| Name  	   | Produces   | Carbon Rate      | Purchase Price     | Income Rate       |
	|--------------|------------|------------------|--------------------|-------------------|
	| Chicken      | Egg        | Small Production | Small Purchase     | Small Production  |      
	| Cow          | Milk       | Large Production | Large Purchase     | Medium Production |
	| Sheep        | Wool       | Medium Prodution | Medium Purchase    | Large Production  |
	| Flower       | Pollen     | Small Reduction  | Cheap Purchase     | Small Production  |
	| Tree         | Fruit      | Medium Reduction | Medium Purchase    | Small Production  |
	| Solar Panel  | Electricty | Large Reduction  | Medium Purchase    | Small Production  |
	| Windmill     | Electricty | Large Reduction  | Large Purchase     | Large Production  |

## Miscellaneous Ideas

	(Ideas I may not have time for)
	
	Add "Once Off" Quests

		- Install Solar Panels
		- Fix Old Windmills
		- Recycle Waste
		- Pick Up Trash
		- Install Fox Defenses
		- Install Poacher Defenses
		- Shoot a Guy
		- Discover Feed Recipies (affect income rate)
		- Add Messages To Hex Table (use DC.B first and then check data in memory)