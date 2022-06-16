namespace Client.Screens
{
    public class UserProfile : Control, IScreen
    {
        private UserProfile() { /* Godot Engine Reflection */ }
        public void Display() { Show(); }
        public void StopDisplaying() { Hide(); }
    }
}