namespace CardGame.Client.Match.Commands
{
    public class RivalLoadDeck: Command
    {
        protected override void Setup(IGameBoard board)
        {
            for (int id = -1; id > -41; id--)
            {
                Card card = board.Cards[id, "Null Card"];
                board.Rival.Deck.Add(card);
            }
            
            board.Rival.Deck.Update(new Vector3(0, CardBase.Thickness, 0));
        }
    }
}