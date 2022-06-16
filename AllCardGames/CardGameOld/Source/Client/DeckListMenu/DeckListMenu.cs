using System.Collections.Generic;
using CardGame.Client.Resources;

namespace CardGame.Client
{
	[GodotScene]
	public class DeckListMenu : OptionButton
	{
		public User User { get; set; }
		
		public DeckListMenu()
		{
			Connect("item_selected", this, nameof(OnDeckSelected));
			GetPopup().Connect("about_to_show", this, nameof(OnAboutToShow));
		}

		public void OnAboutToShow()
		{
			// TODO: Create a Directory Manager Class for FilePaths
			Clear();
			GetPopup().SetAsMinsize();
			AddItem("Select Deck");
			IEnumerable<string> files = System.IO.Directory.EnumerateFiles(@"User\DeckLists");
			foreach (string file in files)
			{
				AddItem(file.
					Replace(@"User\DeckLists\", "").
					Replace(".tres", ""));
			}
		}

		public void OnDeckSelected(int index)
		{
			// TODO: Add Checks for Empty/Select Deck
			User.CurrentDeck = ResourceLoader.Load<DeckList>($"res://User/DeckLists/{GetItemText(index)}.tres");
		}
	}
}
