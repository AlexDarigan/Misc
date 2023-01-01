namespace CardGame.Client.Game.Players;

public abstract class Participant: Spatial
{
    protected Zone Deck { get; private set; }
    protected Zone Discard { get; private set; }
    protected Zone Hand { get; private set; }
    protected Zone Units { get; private set; }
    protected Zone Supports { get; private set; }
    

    public override void _Ready()
    {
        Deck = GetNode<Zone>("Deck");
        Discard = GetNode<Zone>("Discard");
        Hand = GetNode<Zone>("Hand");
        Units = GetNode<Zone>("Units");
        Supports = GetNode<Zone>("Supports");
    }

}