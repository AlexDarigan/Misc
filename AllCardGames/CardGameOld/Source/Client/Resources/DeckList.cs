using System.Collections.Generic;

namespace CardGame.Client.Resources
{
	public class DeckList: Resource
	{
		public DeckList() {}
		[Export] public IEnumerable<string> Contents { get; set; }
	}
}
