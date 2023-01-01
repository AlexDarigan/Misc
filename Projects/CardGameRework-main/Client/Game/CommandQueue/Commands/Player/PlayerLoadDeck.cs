using System.Collections;
using System.Collections.Generic;
using CardGame.Client.Game.Cards;

namespace CardGame.Client.Game.CommandQueue.Commands.Player;

public class PlayerLoadDeck: Command
{
	private IEnumerable DeckList { get; }

	private PlayerLoadDeck() {}
		
	public PlayerLoadDeck(IEnumerable deckList)
	{
		DeckList = deckList;
	}

	protected override void Setup(Match board)
	{
		board.Player.LoadDeck(DeckList, board.CardAlbum);
	}
}