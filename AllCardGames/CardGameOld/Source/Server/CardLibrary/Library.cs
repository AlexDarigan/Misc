using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Globalization;
using System.Linq;
using Newtonsoft.Json;

namespace CardGame.Server.CardLibrary
{
	public static class Library
	{
		public static readonly ReadOnlyDictionary<string, CardInfo> Cards;

		static Library()
		{
			string text = System.IO.File.ReadAllText(@"Source/Server/CardLibrary/Library.json");
			Cards = JsonConvert.DeserializeObject<ReadOnlyDictionary<string, CardInfo>>(text);
		}
	}

	public readonly struct CardInfo
	{	
		public string Title { get; }
		public CardTypes CardTypes { get; }
		public Factions Factions { get; }
		public int Power { get; }
		public SkillInfo Skill { get; }
		
		[JsonConstructor]
		public CardInfo(string title, CardTypes cardType, Factions faction, int power, SkillInfo skill)
		{
			Title = title;
			CardTypes = cardType;
			Factions = faction;
			Power = power;
			Skill = skill;
		}
	}

	public readonly struct SkillInfo
	{
		public readonly IEnumerable<Triggers> Triggers;
		public readonly IEnumerable<int> OpCodes;
		public readonly string Description; // Debugging Purposes
		
		[JsonConstructor]
		public SkillInfo(IEnumerable<Triggers> triggers, IEnumerable<string> opCodes, string description)
		{
			Triggers = triggers;
			Description = description;
			OpCodes = GetOpCodes();
			
			IEnumerable<int> GetOpCodes()
			{
				List<int> codes = new();
				foreach (string code in opCodes)
				{
					if (int.TryParse(code, NumberStyles.Integer, CultureInfo.InvariantCulture, out int value)) { codes.Add(value); }
					else if (Enum.IsDefined(typeof(Bytecode.OpCodes), code)) { codes.Add(ParseEnum<Bytecode.OpCodes>(code)); }
					else if (Enum.IsDefined(typeof(Factions), code)) { codes.Add(ParseEnum<Factions>(code)); }
					else if (Enum.IsDefined(typeof(CardTypes), code)) { codes.Add(ParseEnum<CardTypes>(code)); }
					else { throw new Exception("Could not locate a matching Op Code");}
				}
				return codes.AsEnumerable();
			}
		}
		
		private static int ParseEnum<T>(string value)
		{
			return (int) Enum.Parse(typeof(T), value, true);
		}
	}
}

