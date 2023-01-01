package ie.itcarlow.Lab15;

public class MyInvalidPasswordException extends Exception {

	public MyInvalidPasswordException() {
		super("Password must be at least 8 characters in length!");
	}
}
