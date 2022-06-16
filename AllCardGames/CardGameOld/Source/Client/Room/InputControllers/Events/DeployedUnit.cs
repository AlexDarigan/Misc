namespace CardGame.Client.Match.Input.Events
{
    public class DeployedUnit : EventArgs
    {
        public Card Card { get; }

        public DeployedUnit(Card card)
        {
            Card = card;
        }
    }
}