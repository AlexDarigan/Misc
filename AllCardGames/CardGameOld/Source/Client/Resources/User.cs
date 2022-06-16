namespace CardGame.Client.Resources
{
	public class User: Resource
	{
		public User () { }
		[Export] public int Rank { get; set; } = 0;
		[Export] public string DisplayName { get; set; } = "User";
		[Export] public DeckList CurrentDeck { get; set; }
	}
}
