namespace CardGame.Data;

public class Library : Node
{
    private static Library Instance { get; set; }

    public override void _Ready()
    {
        Instance = this;
    }

    public static CardPrototype GetCard(string name)
    {
        return Instance.GetNode<CardPrototype>(name);
    }
}