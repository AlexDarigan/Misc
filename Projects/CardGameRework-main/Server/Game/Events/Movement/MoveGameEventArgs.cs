using CardGame.Server.Game;
using CardGame.Server.Game.Players;

namespace CardGame.Server.Events;

public abstract class MoveGameEventArgs: GameEventArgs
{
    protected Card Card { get; }
    protected Player Controller { get; }
    protected MoveGameEventArgs(){}
    protected MoveGameEventArgs(Card card)
    {
        Controller = card.Controller;
        Card = card;
    }
}