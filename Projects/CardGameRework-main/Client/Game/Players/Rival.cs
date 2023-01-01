using System.Linq;
using CardGame.Client.Game.Cards;
using CardGame.Common.Constants;

namespace CardGame.Client.Game.Players;

public class Rival: Participant
{
	public void LoadDeck(CardAlbum album)
	{
		for(var id = -1; id > -41; id--)
		{
			var card = album.GetCard(id, "NullCard");
			album.RemoveChild(card);
		    Deck.Add(card);
		}

		SortDeck();
	}

	public void Draw(SceneTreeTween tween)
	{
		var card = Deck[^1];
		Deck.Remove(card);
		Hand.Add(card);
		SortHand(tween, card);
	}

	public void Deploy(int id, string setCode, CardAlbum album, SceneTreeTween tween)
	{
		var card = Hand[^1];
		album.Reveal(id, setCode, card);
		Hand.Remove(card);
		Units.Add(card);
		SortUnits(tween, card);
		SortHand(tween);
	}

	public void SetFaceDown(SceneTreeTween tween)
	{
		var card = Hand[^1];
		Hand.Remove(card);
		Supports.Add(card);
		SortSupports(tween, card);
		SortHand(tween);
	}
	
	public void SendToGraveyard(Card card, SceneTreeTween tween)
	{
		if (card.CardTypes == CardTypes.Unit)
		{
			Units.Remove(card);
			Discard.Add(card);
			SortDiscard(tween, card);
			SortUnits(tween);
		}
		else
		{
			Supports.Remove(card);
			Discard.Add(card);
			SortDiscard(tween, card);
			SortSupports(tween);
		}
	}

	private void SortUnits(SceneTreeTween tween, Card unsorted = null)
	{
		const float duration = 0.2f;
		const float moveX = 2.5f;
		var translation = (-moveX * Units.Count / 2) + moveX / 2;
		foreach (var card in Units)
		{
			if (card == unsorted)
			{
				tween.Parallel().TweenProperty(card?.Mesh, "translation", Vector3.Zero, duration);
			}
			
			tween.Parallel().TweenProperty(card, "translation", new Vector3(translation, 0, 0), duration);
			tween.Parallel().TweenProperty(card, "rotation_degrees", Vector3.Zero, duration);
			tween.Parallel().TweenProperty(card.Mesh, "rotation_degrees", Vector3.Zero, duration);
			translation += moveX;
		}
	}

	private void SortSupports(SceneTreeTween tween, Card unsorted = null)
	{
		const float duration = 0.2f;
		const float moveX = 2.5f;
		var translation = (-moveX * Supports.Count / 2) + moveX / 2;
		foreach (var card in Supports)
		{
			var flip = card.IsInGroup("Activated") ?  new Vector3(0, 0, 180) : Vector3.Zero;
			if (card == unsorted)
			{
				tween.Parallel().TweenProperty(card?.Mesh, "translation", Vector3.Zero, duration);
			}
			
			tween.Parallel().TweenProperty(card, "translation", new Vector3(translation, 0, 0), duration);
			tween.Parallel().TweenProperty(card, "rotation_degrees", flip, duration);
			translation += moveX;
		}
	}

	private void SortHand(SceneTreeTween tween, Card unsorted = null)
	{
		const float duration = 0.2f;
		const float degrees = -10f;
		var rotation = -degrees * Hand.Count / 2;


		foreach (var card in Hand.Except(new[] { unsorted }).ToList())
		{
			tween.TweenProperty(card, "rotation_degrees", new Vector3(0, rotation, 0), duration);
			rotation += degrees;
		}

		if (unsorted == null) return;
		tween.TweenProperty(unsorted?.Mesh, "translation", new Vector3(0, 0, 6f), duration);
		tween.Parallel().TweenProperty(unsorted, "translation", new Vector3(0, 0.05f * unsorted.GetIndex(), 0), duration);
		tween.Parallel().TweenProperty(unsorted, "rotation_degrees", new Vector3(0, rotation, 0), duration); // Somewhere?
	}

	private void SortDeck()
	{
		foreach (var card in Deck)
		{
			card.Mesh.RotationDegrees = new Vector3(0,  0, 180);
			card.Translation = new Vector3(0, 0.02f * card.GetIndex(), 0);
		}
	}
	
	private void SortDiscard(SceneTreeTween tween, Card unsorted)
	{
		tween.TweenProperty(unsorted, "translation", new Vector3(0, 0, 0.02f * unsorted.GetIndex()), 0.2f);
	}

	public void ActivateCard(int cardId, string setCode, int slotIndex, CardAlbum album, SceneTreeTween tween)
	{
		var card = Supports[slotIndex];
		album.Reveal(cardId, setCode, card);
		tween.TweenProperty(card.Mesh, "rotation_degrees", Vector3.Zero, 0.2f);
		card.AddToGroup("Activated");
	}
}