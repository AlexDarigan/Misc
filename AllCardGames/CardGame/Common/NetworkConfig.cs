namespace CardGame.Common;

public class NetworkConfig: Resource
{
    [Export(PropertyHint.Range, "5000, 9000, 100")]
    public int Port { get; set; } = 5000;

    [Export] 
    public string IpAddress { get; set; } = "127.0.0.1";
}