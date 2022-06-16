namespace CardGame.Client.Match.Commands
{
    public class PlayerDeploy: Command
    {
        private int CardId { get; }

        public PlayerDeploy(int cardId)
        {
            CardId = cardId;
        }
        
        protected override void Setup(IGameBoard board)
        {
            Card card = board.Cards[CardId];
            board.Player.Hand.Remove(card);
            board.Player.Units.Add(card);
            board.Player.Units.Shift(new Vector3(-CardBase.Width / 2, 0, 0));
            board.Player.Units.Update(new Vector3(CardBase.Width * 1.5f, 0, 0), board);
            board.Player.Hand.Shift(new Vector3(CardBase.Width / 2, 0, 0));
            board.Player.Hand.Update(new Vector3(CardBase.Width, 0, 0), board);
        }
    }
}