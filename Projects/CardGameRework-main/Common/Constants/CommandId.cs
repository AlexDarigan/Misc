namespace CardGame.Common.Constants;

public enum CommandId
{
    Update,

    // Common
    DeclareAttackUnit,
    AttackUnit,
    DeclareDirectAttack,
    EndTurn,
    GameOver,
    Resolve,
    SetHealth,
    SentToGraveyard,

    // Player Commands
    PlayerLoadDeck,
    PlayerDraw,
    PlayerDeploy,
    PlayerSetFaceDown,
    PlayerActivate,
    PlayerSendToGraveyard,
        
    // Rival Commands
    RivalLoadDeck,
    RivalDraw,
    RivalDeploy,
    RivalSetFaceDown,
    RivalActivate,
    RivalSendToGraveyard
}