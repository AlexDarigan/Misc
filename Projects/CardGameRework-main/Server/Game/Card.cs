using System.Collections.Generic;
using System.Linq;
using CardGame.Common.Constants;
using CardGame.Data;
using CardGame.Scripting;
using CardGame.Server.Game;
using CardGame.Server.Game.Players;
using JetBrains.Annotations;

namespace CardGame.Server;

public class Card
{
    public int Id { get; }
    public Player Owner { get; }
    public CardStates CardStates { get; set; } = CardStates.None;
    public CardTypes CardTypes { get; }
    public Player Controller { get; }
    public Factions Factions { get; }
    public bool IsReady { get; set; } = false;
    public int Power { get; set; }
    public string SetCodes { get; }
    [CanBeNull] public Effect Effect { get; set; }
    public string Title { get;  }
    public IEnumerable<Card> ValidTargets { get; set; } = new List<Card>();
        
    public Card(string name, int id, Player owner, CardPrototype prototype)
    {
        Id = id;
        Owner = owner;
        Controller = owner;
            
        SetCodes = name;
        Title = prototype.Title;
        CardTypes = prototype.CardType;
        Factions = prototype.Factions;
        Power = prototype.Power;

        if (prototype.Effect?.Duplicate() is not Effect effect) return;
        Effect = effect;
        effect.Card = this;
    }
    public Effect Activate() { return Effect; }
    public override string ToString() { return $"Server Card: {Id} {Title}"; }
}