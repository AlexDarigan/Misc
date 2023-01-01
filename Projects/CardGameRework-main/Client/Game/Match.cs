using System.Collections.Generic;
using CardGame.Client.Game.Cards;
using CardGame.Client.Game.CommandQueue;
using CardGame.Client.Game.Players;
using CardGame.Client.Game.Table;
using CardGame.Common.Constants;
namespace CardGame.Client.Game;

[GodotScene]
public class Match : Spatial
{
	public delegate void Play(string command, params object[] args);
	public event Play Declare;
	public Player Player { get; private set; }
	public Rival Rival { get; private set; }
	public Board Board { get; private set; }
	public CardAlbum CardAlbum { get; private set; }
	private Queue Queue { get; set; }
	public Dictionary<string, List<Card>> Clickables { get; set; }
	public PassPlayButton PlayButton { get; set; }
	
	private Match() { }
		
	public override void _Ready()
	{
		Player = GetNode<Player>("Player");
		Rival = GetNode<Rival>("Rival");
		Board = GetNode<Board>("Board");
		Queue = GetNode<Queue>("CommandQueue");
		CardAlbum = GetNode<CardAlbum>("CardAlbum");
		PlayButton = GetNode<PassPlayButton>("Board/PassPlayButton");
	}

	public void Subscribe()
	{
		PlayButton.Clicked += OnPassPlayClicked;
		foreach (var (rule, cards) in Clickables)
		{
			foreach (var card in cards)
			{
				card.Highlight.Visible = true;
			}
			foreach (var card in cards)
			{
				switch (rule)
				{
					case "CanBeDeployed":
						card.Clicked += OnCanBeDeployedClicked; 
						break;
					case "CanBeSetFaceDown":
						card.Clicked += OnCanBeSetFaceDownClicked;
						break;
					case "CanBeActivated":
						card.Clicked += OnCanBeActivatedClicked;
						break;
					case "CanAttackUnit":
						card.Clicked += OnCanAttackUnitClicked;
						break;
					case "CanAttackPlayer": 
						card.Clicked += OnCanAttackPlayerClicked;
						break;
				}
			}
			
		}
	}

	private void Unsubscribe()
	{
		PlayButton.Clicked -= OnPassPlayClicked;
		foreach (var (rule, cards) in Clickables)
		{
			foreach (var card in cards)
			{
				card.Highlight.Visible = false;
			}
			switch (rule)
			{
				case "CanBeDeployed":
					foreach (var card in cards) { card.Clicked -= OnCanBeDeployedClicked; }
					break;
				case "CanBeSetFaceDown":
					foreach (var card in cards) { card.Clicked -= OnCanBeSetFaceDownClicked; }
					break;
				case "CanBeActivated":
					foreach (var card in cards) { card.Clicked -= OnCanBeActivatedClicked; }
					break;
				case "CanAttackUnit":
					foreach (var card in cards) { card.Clicked -= OnCanAttackUnitClicked; }
					break;
				case "CanAttackPlayer":
					foreach (var card in cards) { card.Clicked -= OnCanAttackPlayerClicked; }
					break;
			}
		}
		PlayButton.SetColor(Colors.Red);
	}
	
	protected virtual void OnCanBeDeployedClicked(Card card)
	{
		Unsubscribe();
		Declare?.Invoke("Deploy", card.Id);
	}

	protected virtual void OnCanBeSetFaceDownClicked(Card card)
	{
		Unsubscribe();
		Declare?.Invoke("SetFaceDown", card.Id);
	}

	protected virtual void OnCanBeActivatedClicked(Card card)
	{
		Unsubscribe();
		Declare?.Invoke("Activate", card.Id);
	}

	protected virtual void OnCanAttackUnitClicked(Card attacker)
	{
		attacker.Attack.Visible = true;
	}

	protected virtual void OnCanAttackPlayerClicked(Card attacker)
	{
		attacker.Attack.Visible = true;
	}

	protected virtual void OnPassPlayClicked()
	{
		Declare?.Invoke("PassPlay");
		Unsubscribe();
	}
	
	private int QC = 0;
	public void OnGameUpdated() 
	{ 
		if(QC == 1) { return; }
		QC += 1;
		Queue.OnGameUpdated(this); 
	}
	
	public void OnCommandQueued(CommandId command, object[] args) { Queue.TryEnqueue(command, args); }
}
