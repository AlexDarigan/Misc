using System.Collections.Generic;
using CardGame.Common;
using Godot.Collections;

namespace CardGame.Server.Room;

public class Table: Node
{
	[Export(PropertyHint.ResourceType)] private Logger Logger { get; set; }
	[Export()] private NodePath MatchPath { get; set; }
	private Match Match { get; set; }

	private Player Player1 { get; set; }
	private Player Player2 { get; set; }

	public override void _Ready()
	{
		Match = GetNode<Match>(MatchPath);
	}

	[Master]
	public void OnPlayerSeated(Array<string> deckList)
	{
		Logger.Log(this, $"{CustomMultiplayer.GetRpcSenderId().ToString()} has been seated at table number {Name}");
		GetSender().DeckList = deckList;
		Match.LoadDeck(GetSender());
	}

	private Player GetSender()
	{
		return CustomMultiplayer.GetRpcSenderId() == Player1.Id ? Player1 : Player2;
	}
}
