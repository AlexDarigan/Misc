namespace CardGame.Client.Resources;

public class User: Resource
{
	public User () { }
	[Export] public string DisplayName { get; set; } = "User";
}