namespace Client.Screens
{
    public class Settings : Control, IScreen
    {
        private Settings() { /* Godot Engine Reflection */ }
        public void Display() { Show(); }
        public void StopDisplaying() { Hide(); }
    }
}