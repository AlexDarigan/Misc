using System.Collections.Generic;
using System.Linq;
using CardGame.Client.Game.Cards;
using Godot.Collections;

namespace CardGame.Client.Game.CommandQueue.Commands.Player;

public class Update: Command
{
    private Godot.Collections.Dictionary<string,List<int>> Cards { get; set; }
    private bool IsActingPlayer { get; set; }
    
    private Update() {}
        
    public Update(bool isActingPlayer, Dictionary cards)
    {
        IsActingPlayer = isActingPlayer;
        Cards = new Godot.Collections.Dictionary<string, List<int>>(cards);
    }
        
    protected override void Setup(Match board)
    {
        if(!IsActingPlayer) { return; }
        var cards = new System.Collections.Generic.Dictionary<string, List<Card>>();
        foreach (var (rule, cardList) in Cards)
        {
            cards[rule] = Cards[rule].Select(id => board.CardAlbum.GetCard(id)).ToList<Card>();
        }

        board.PlayButton.SetColor(Colors.Green);
        board.Clickables = cards;
        board.Subscribe();
    }
}