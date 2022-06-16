using Godot.Collections;

namespace WAT
{
	public class Boolean: Assertion
	{
		public static Dictionary IsTrue(bool value, string context)
		{
			var passed = $"|boolean| {value.ToString()} == true";
			var failed = $"|boolean| {value.ToString()} == false";
			var result = value ? passed : failed;
			return Result(value, passed, result, context);
		}

		public static Dictionary IsFalse(bool value, string context)
		{
			var passed = $"|boolean| {value.ToString()} == false";
			var failed = $"|boolean| {value.ToString()} == true";
			var success = !value;
			var result = success ? passed : failed;
			return Result(success, passed, result, context);
		}
	}
}

