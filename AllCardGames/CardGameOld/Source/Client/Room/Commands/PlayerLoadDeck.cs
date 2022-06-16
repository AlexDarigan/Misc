using System.Collections;
using System.Threading.Tasks;

namespace CardGame.Client.Match.Commands
{
	public class PlayerLoadDeck: Command
	{
		private IEnumerable DeckList { get; }

		public PlayerLoadDeck(IEnumerable deckList)
		{
			DeckList = deckList;
		}

		protected override void Setup(IGameBoard board)
		{
			foreach (DictionaryEntry pair in DeckList)
			{
				Card card = board.Cards[(int) pair.Key, (string) pair.Value];
				board.Player.Deck.Add(card);
			}
			
			board.Player.Deck.Update(new Vector3(0, CardBase.Thickness, 0));
		}
	}
}
