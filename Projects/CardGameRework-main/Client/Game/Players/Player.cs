using System.Collections;
using System.Linq;
using CardGame.Client.Game.Cards;
using CardGame.Common.Constants;

namespace CardGame.Client.Game.Players;

[GodotScene]
public class Player : Participant
{
	public void LoadDeck(IEnumerable deckList, CardAlbum album)
	{
		foreach (DictionaryEntry pair in deckList)
		{
			var card = album.GetCard((int) pair.Key, (string) pair.Value);
			album.RemoveChild(card);
			Deck.Add(card);
		}

		SortDeck();
	}

	public void Draw(Card card, SceneTreeTween tween)
	{
		Deck.Remove(card);
		Hand.Add(card);
		SortHand(tween, card);
	}

	public void Deploy(Card card, SceneTreeTween tween)
	{
		Hand.Remove(card);
		Units.Add(card);
		SortUnits(tween, card);
		SortHand(tween);
	}

	public void SetFaceDown(Card card, SceneTreeTween tween)
	{
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
			var flip = card.IsInGroup("Activated") ? Vector3.Zero : new Vector3(0, 0, 180);
			if (card == unsorted)
			{
				tween.Parallel().TweenProperty(card?.Mesh, "translation", Vector3.Zero, duration);
			}
			
			tween.Parallel().TweenProperty(card, "translation", new Vector3(translation, 0, 0), duration);
			tween.Parallel().TweenProperty(card, "rotation_degrees", Vector3.Zero, duration);
			tween.Parallel().TweenProperty(card.Mesh, "rotation_degrees", flip, duration);
			translation += moveX;
		}
	}

	private void SortHand(SceneTreeTween tween, Card unsorted = null)
	{
		
		// 
		const float duration = .2f;
		const float degrees = -10f;
		var rotation = -degrees * Hand.Count / 2;


		foreach (var card in Hand.Except(new[] { unsorted }).ToList())
		{
			tween.Parallel().TweenProperty(card, "rotation_degrees", new Vector3(0, rotation, 0), duration);
			rotation += degrees;
		}

		if (unsorted == null) return;
		tween.Parallel().TweenProperty(unsorted?.Mesh, "translation", new Vector3(0, 0, -6f), duration);
		tween.Parallel().TweenProperty(unsorted.Mesh, "rotation_degrees", new Vector3(0, 0, 0), duration);
		tween.Parallel().TweenProperty(unsorted, "rotation_degrees", new Vector3(0, rotation, 0), duration); // Somewhere?
		tween.Parallel().TweenProperty(unsorted, "translation", new Vector3(0, 0.05f * unsorted.GetIndex(), 0), duration);
		
	}
	
	private void SortDeck()
	{
		foreach (var card in Deck)
		{
			card.Mesh.RotationDegrees = new Vector3(0, 0, 180);
			card.Translation = new Vector3(0, 0.04f * card.GetIndex(), 0);
		}
	}

	private void SortDiscard(SceneTreeTween tween, Node unsorted)
	{
		tween.TweenProperty(unsorted, "translation", new Vector3(0, 0, 0.02f * unsorted.GetIndex()), 0.2f);
	}

	public void ActivateCard(Card card, SceneTreeTween tween)
	{
		tween.TweenProperty(card.Mesh, "rotation_degrees", Vector3.Zero, 0.2f);
		card.AddToGroup("Activated");
	}
}
