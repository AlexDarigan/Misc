﻿namespace CardGame.Common
{
    public enum CardTypes
    {
        Null,
        Unit,
        Support
    }

    public enum Factions
    {
        Null,
        Warrior
    }

    public enum Who
    {
        NoOne = 0,
        Player = 1,
        Rival = 2,
    }

    public enum Triggers
    {
        Any
    }
    
    public enum CommandId {
        // Common
        AttackUnit,
        AttackParticipant,
        EndTurn,
        GameOver,
        Resolve,
        SetHealth,
        SentToGraveyard,
        PlayerUpdate,
        UpdateCards,

        // Player Commands
        PlayerLoadDeck,
        PlayerDraw,
        PlayerDeploy,
        PlayerSetFaceDown,
        PlayerActivate,
        
        // Rival Commands
        RivalLoadDeck,
        RivalDraw,
        RivalDeploy,
        RivalSetFaceDown,
        RivalActivate,
    }
    
    public enum States { IdleTurnPlayer, Active, Passive, Loser, Winner, Passing, Acting }
    public enum Declaration { OnDeclaration, Deploy, SetFaceDown, Activate, AttackUnit, AttackPlayer, PassPlay, EndTurn}
    public enum CardStates { None, Deploy, AttackUnit, AttackPlayer, SetFaceDown, Activate }
    public enum Illegal { NotDisqualified, Draw, Deploy, AttackUnit, AttackPlayer, SetFaceDown, PassPlay, EndTurn, Activation }

}