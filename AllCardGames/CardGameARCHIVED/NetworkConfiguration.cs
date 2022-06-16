using Godot;

namespace Configuration
{
    public class NetworkConfiguration : Resource
    {
        [Export()] public string IpAddress { get; set; } = "127.0.0.1";
        [Export(PropertyHint.Range, "5000,9000,100")]  public int Port { get; set; }
    }
}


