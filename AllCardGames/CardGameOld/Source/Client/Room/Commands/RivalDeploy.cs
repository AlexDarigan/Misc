namespace CardGame.Client.Match.Commands
{
    public class RivalDeploy: Command
    {
        private int CardId { get; }
        private string SetCode { get; }

        public RivalDeploy(int cardId, string setCode)
        {
            CardId = cardId;
            SetCode = setCode;
        }
        
        protected override void Setup(IGameBoard board)
        {
            Card card = board.Cards[CardId, SetCode];
            Card fake = (Card) board.Rival.Hand.GetChild(board.Rival.Hand.GetChildCount() - 1);
            card.Translation = fake.Translation;
            card.RotationDegrees = fake.RotationDegrees;
            board.Rival.Hand.Remove(fake);
            board.Rival.Hand.Add(card);
            
            fake.Hide();
            fake.QueueFree();
            
            board.Rival.Hand.Remove(card);
            board.Rival.Units.Add(card);
            board.Rival.Units.Shift(new Vector3(CardBase.Width / 2, 0, 0));
            board.Rival.Units.Update(new Vector3(-CardBase.Width * 1.5f, 0, 0), board);
            board.Rival.Hand.Shift(new Vector3(-CardBase.Width / 2, 0, 0));
            board.Rival.Hand.Update(new Vector3(-CardBase.Width, 0, 0), board);
        }
    }
}   