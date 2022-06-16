namespace CardGame.Client.Match.Commands
{
    public class RivalSetFaceDown: Command
    {
        protected override void Setup(IGameBoard board)
        {
            Card card = (Card) board.Rival.Hand.GetChild(board.Rival.Hand.GetChildCount() - 1);
            board.Rival.Hand.Remove(card);
            board.Rival.Supports.Add(card);
            board.Rival.Supports.Update(new Vector3(0, CardBase.Thickness, 0.1f), board);
            board.Rival.Hand.Shift(new Vector3(-CardBase.Width / 2, 0, 0));
            board.Rival.Hand.Update(new Vector3(-CardBase.Width, 0, 0), board);
        }
    }
}
