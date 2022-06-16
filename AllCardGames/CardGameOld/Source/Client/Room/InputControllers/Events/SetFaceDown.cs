namespace CardGame.Client.Match.Input.Events
{
    public class SetFaceDown : EventArgs
    {
        public Card Card { get; }

        public SetFaceDown(Card card)
        {
            Card = card;
        }
    }
}