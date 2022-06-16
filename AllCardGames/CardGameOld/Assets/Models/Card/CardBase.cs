using System.Threading.Tasks;
using CardGame.Client.CardLibrary;
using CardGame.Client.Match;

public class CardBase : Spatial
{
	public const float Thickness = 0.003f;
	public const float Width = 0.59f;
	public const float Length = 0.86f;
	protected Texture Face { set { FaceMaterial.AlbedoTexture = value; } }
	public new virtual Vector3 Translation { get { return base.Translation; } set { base.Translation = value; } }
	public new virtual Vector3 RotationDegrees { get { return base.RotationDegrees; } set { base.RotationDegrees = value; } }
	private SpatialMaterial FaceMaterial { get; set; }
	public Zone CurrentZone { get; set; }

	public override void _Ready()
	{
		// TODO: Make sure we're accessing the correct material
		FaceMaterial = GetNode<MeshInstance>("CardMesh").GetSurfaceMaterial(0) as SpatialMaterial; //SurfaceGetMaterial(0) as SpatialMaterial;
	//	FaceMaterial.ResourceLocalToScene = true;
	}
}
