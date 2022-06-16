namespace CardGame.Client.Match
{
	public interface IGameBoard
	{
		Participant Player { get; }
		Participant Rival { get; }
		Effects Effects { get; }
		Cards Cards { get; }
		Table Table { get; }
	}
}
