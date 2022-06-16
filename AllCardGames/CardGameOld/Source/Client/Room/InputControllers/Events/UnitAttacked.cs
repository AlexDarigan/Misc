namespace CardGame.Client.Match.Input.Events
{
    public class UnitAttacked: EventArgs
    {
        public Card Attacker { get; }
        public Card Defender { get; }

        public UnitAttacked(Card attacker, Card defender)
        {
            Attacker = attacker;
            Defender = defender;
        }
    }
}