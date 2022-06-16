using System.Runtime.CompilerServices.Assets.Sounds;
using CardGame.Server;

namespace CardGame.Client.Match.Commands
{
	public class PlayerDraw : Command
	{
		private int CardId { get; }

		public PlayerDraw(int cardId)
		{
			CardId = cardId;
		}
		
		protected override void Setup(IGameBoard board)
		{
			Card card = board.Cards[CardId];
			board.Player.Deck.Remove(card);
			board.Player.Hand.Add(card);
			board.Player.Hand.Shift(new Vector3(-CardBase.Width / 2, 0, 0));
			board.Player.Hand.Update(new Vector3(CardBase.Width, 0, 0), board);
		}
	}
}

		
		
