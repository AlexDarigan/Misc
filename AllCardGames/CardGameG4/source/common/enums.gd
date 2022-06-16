extends Object
class_name Enums

enum CardTypes { Null, Unit, Support }
enum Factions { Null, Warrior }
enum Who { NoOne = 0, Player = 1, Rival = 2 }
enum Triggers { Any }
enum States { IdleTurnPlayer, Active, Passive, Loser, Winner, Passing, Acting }
enum CardStates { None, Deploy, AttackUnit, AttackPlayer, SetFaceDown, Activate }

enum Illegal { 
	NotDisqualified,
	Draw,
	Deploy,
	AttackUnit, 
	AttackPlayer, 
	Activation,
	SetFaceDown, 
	PassPlay, 
	EndTurn
}

enum Declaration { 
	OnDeclaration, 
	Deploy, 
	SetFaceDown, 
	Activate, 
	AttackUnit, 
	AttackPlayer, 
	PassPlay, 
	EndTurn
}

enum CommandId {
	# Common
	AttackUnit = 0,
	AttackParticipant = 1,
	EndTurn = 2,
	GameOver = 3,
	Resolve = 4,
	SetHealth = 5,
	SentToGraveyard = 6,
	PlayerUpdate = 7, 
	UpdateCards = 8, 

	# Player Commands
	PlayerLoadDeck = 9,
	PlayerDraw = 10,
	PlayerDeploy = 11,
	PlayerSetFaceDown = 12,
	PlayerActivate = 13,

	# Rival Commands
	RivalLoadDeck = 14,
	RivalDraw = 15,
	RivalDeploy = 16,
	RivalSetFaceDown = 17,
	RivalActivate = 18,
}

