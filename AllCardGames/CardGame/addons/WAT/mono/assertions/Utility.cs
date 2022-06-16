using System;
using System.Collections.Generic;
using Godot;
using Godot.Collections;
using Object = Godot.Object;

namespace WAT
{
	public class Utility: Assertion
	{
		public static Dictionary Fail(string context)
		{
			return Result(false, "N/A", "N/A", context);
		}
		
		public static Dictionary AutoPass(string context)
		{
			return Result(true, "N/A", "N/A", context);
		}

		public static Dictionary Throws(Action function, string context)
		{
			try
			{
				function();
				const string fail = "No exception was thrown";
				return Result(false, "Exception was thrown", fail, context);
			}
			catch (Exception e)
			{
				var pass = $"Threw Exception {e} with Message: {e.Message}";
				return Result(true, "Exception was thrown", pass, context);
			}
		}
		
		public static Dictionary DoesNotThrow(Action function, string context)
		{
			try
			{
				function();
				var pass = $"No exception was thrown";
				return Result(true, "No Exception was thrown", pass, context);
			}
			catch (Exception e)
			{
				var fail = $"Threw {e} with Message: {e.Message}";
				return Result(true, "No Exception was thrown", fail, context);
			}
		}
		
		public static Dictionary Throws<T>(Action function, string context)
		{
			var expected = $"{typeof(T)} was thrown";
			try
			{
				function();
				const string fail = "No Exception was thrown";
				return Result(false, expected, fail, context);
			}
			catch (Exception e)
			{
				if (e is T)
				{
					var pass = $"Threw {e} with Message: {e.Message}";
					return Result(true, expected, pass, context);
				}
				
				var fail = $"Threw {e} with Message: {e.Message}";
				return Result(false, expected, fail, context);
			}
		}
		
		public static Dictionary DoesNotThrow<T>(Action function, string context)
		{
			var expected = $"{typeof(T)} was not thrown";
			try
			{
				function();
				var pass = $"Did not throw {typeof(T)}";
				return Result(true, expected, pass, context);
			}
			catch (Exception e)
			{
				var pass = "";
				if (e is T)
				{
					var fail = $"Threw {e} with Message: {e.Message}";
					return Result(false, expected, fail, context);
				}
				
				pass = $"Threw {e} with Message: {e.Message}";
				return Result(true, expected, pass, context);
			}
		}
	}
}
