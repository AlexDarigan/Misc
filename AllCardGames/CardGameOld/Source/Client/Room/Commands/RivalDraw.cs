namespace CardGame.Client.Match.Commands
{
    public class RivalDraw: Command
    {
	    protected override void Setup(IGameBoard board)
		{
			Card card = (Card) board.Rival.Deck.GetChild(board.Rival.Deck.GetChildCount() - 1);
			board.Rival.Deck.Remove(card);
			board.Rival.Hand.Add(card);
			board.Rival.Hand.Shift(new Vector3(CardBase.Width / 2, 0, 0));
			board.Rival.Hand.Update(new Vector3(-CardBase.Width, 0, 0), board);
		}
    }
}
