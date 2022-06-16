namespace CardGame.Client.Match.Commands
{
    public class PlayerSetFaceDown: Command
    {
        private int CardId { get; }

        public PlayerSetFaceDown(int cardId)
        {
            CardId = cardId;
        }
        
        protected override void Setup(IGameBoard board)
        {
            Card card = board.Cards[CardId];
            board.Player.Hand.Remove(card);
            board.Player.Supports.Add(card);
            board.Player.Supports.Update(new Vector3(0, CardBase.Thickness, -0.1f), board);
            board.Player.Hand.Shift(new Vector3(CardBase.Width / 2, 0, 0));
            board.Player.Hand.Update(new Vector3(CardBase.Width, 0, 0), board);
        }
    }
}