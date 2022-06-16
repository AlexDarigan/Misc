using System.Collections.ObjectModel;
using Newtonsoft.Json;

namespace CardGame.Client.CardLibrary
{
	public static class Library
	{
		public static readonly ReadOnlyDictionary<string, CardInfo> Cards;

		static Library()
		{
			string text = System.IO.File.ReadAllText(@"Source/Client/CardLibrary/Library.json");
			Cards = JsonConvert.DeserializeObject<ReadOnlyDictionary<string, CardInfo>>(text);
		}
	}

	public readonly struct CardInfo
	{
		public string Title { get; }
		public CardTypes CardType { get; }
		public Factions Faction { get; }
		public int Power { get; }
		public string Text { get; }
		
		// Can we do a simple convert here instead (say with an attribute)?
		public Texture Art { get; }

		[JsonConstructor]
		public CardInfo(string name, CardTypes cardType, Factions faction, int power, string text, string art)
		{
			Title = name;
			CardType = cardType;
			Faction = faction;
			Power = power;
			Text = text;
			Art = ResourceLoader.Load<Texture>(art);
		}
	}
}
