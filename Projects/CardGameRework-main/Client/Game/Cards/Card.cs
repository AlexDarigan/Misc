using CardGame.Common.Constants;
namespace CardGame.Client.Game.Cards;

[GodotScene]
public class Card: Spatial, IClickable
{
	[Export()] public Color IsBeingTargeted { get; set; } = Colors.Red;
	[Export()] public Color IsPlayable { get; set; } = Colors.Blue;
	[Export()] public Color IsPlayableFocused { get; set; } = Colors.Green;

	public MeshInstance Mesh { get; set; }
	public MeshInstance Highlight { get; set; }
	private SpatialMaterial CardFace { get; set; }
	public Sprite3D Attack { get; set; }
	private Sprite3D Defend { get; set; }
	
	public event Action<Card> Clicked;
	
	public int Id { get; set; }
	public string Title { get; set; }
	public string Text { get; set; }
	public CardTypes CardTypes { get; set; }
	public Factions Factions { get; set; }
	public int Power { get; set; }
	public Texture Art
	{
		get { return CardFace.AlbedoTexture; }
		set { CardFace.AlbedoTexture = value; }
	}

	public void Click()
	{
		GD.Print("Clicked ", this);
		Clicked?.Invoke(this);
	}
	
	private Card() { /* */ }
	
	public override void _Ready()
	{
		Mesh = GetNode<MeshInstance>("Card");
		CardFace = Mesh.GetSurfaceMaterial(0) as SpatialMaterial;
		Highlight = GetNode<MeshInstance>("Card/Highlight"); //.GetSurfaceMaterial(0) as SpatialMaterial;
		Attack = GetNode<Sprite3D>("Card/Attack");
		Defend = GetNode<Sprite3D>("Card/Defend");
	}
	
	private Transform CachedTransform { get; set; } = Transform.Identity;
	
	public override void _EnterTree()
	{
		GlobalTransform = CachedTransform;
	}

	public override void _ExitTree()
	{
		CachedTransform = GlobalTransform;
	}
}
