using System;
using Godot;
using Godot.Collections;

namespace Debug
{
    // Turn this info an interface?
    public class Logger : Resource
    {
        [Export()] private bool PrintToConsole { get; set; }
        [Export(PropertyHint.MultilineText)] private string LogText { get; set; }

        public Logger()
        {
            Console.Write("Logger!");
            LogText = "";
        }
        
        public void Log(string text)
        {
            if (PrintToConsole) { Console.WriteLine(text); }
            LogText += $"{text}\n";
            ResourceSaver.Save(ResourcePath, this);
        }
    }
}