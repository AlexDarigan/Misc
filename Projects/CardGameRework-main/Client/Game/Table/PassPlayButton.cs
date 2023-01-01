using CardGame.Client.Game;

public class PassPlayButton : MeshInstance, IClickable
{
    public event Action Clicked;

    public void Click()
    {
        GD.Print("Clicking Action");
        Clicked?.Invoke();
    }

    public void SetColor(Color color)
    {
        var mat = (SpatialMaterial)GetSurfaceMaterial(0);
        mat.AlbedoColor = color;
    }
}
