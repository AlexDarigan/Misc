namespace CardGame.Client.Match
{
	public class Table : Spatial
	{
		public event EventHandler PassPlayPressed;
		private SpatialMaterial Material { get; set; }

		public override void _Ready()
		{
			Material = (SpatialMaterial) GetNode<MeshInstance>("PassPlayButton").GetSurfaceMaterial(0);
			GetNode<Area>("PassPlayButton/Area").
				Connect("input_event", this, nameof(OnInputEvent));
		}

		public void OnInputEvent(Node camera, InputEvent input,
			Vector3 clickPos, Vector3 clickNormal, int shapeIdx)
		{
			if (input is InputEventMouseButton { ButtonIndex: (int)ButtonList.Left, Doubleclick: true })
			{
				PassPlayPressed?.Invoke(this, null);
			}
		}

		public void SetState(States state)
		{
			Material.AlbedoColor = state switch
			{
				States.IdleTurnPlayer => Colors.Green,
				States.Active => Colors.Green,
				_ => Colors.Red
			};
		}

		public void SetAsInActive()
		{
			Material.AlbedoColor = Colors.Red;
		}
	}
}
