package ie.itcarlow.Lab15;

public class Verifier {
	private MyOutOfRangeException myOutOfRangeException;
	private MyInvalidPasswordException myInvalidPasswordException;
	
	public Verifier()
	{
		myOutOfRangeException = new MyOutOfRangeException();
		myInvalidPasswordException = new MyInvalidPasswordException();
	}
	
	public void verifyIntRange(int value, int low, int high) throws MyOutOfRangeException
	{
		if(value < low || value > high) {
			throw myOutOfRangeException;
		} else {
			System.out.print(value + " is in range");
		}
		
	}
	
	public void verifyPasswordStrength(String password) throws MyInvalidPasswordException {
		if(password.length() < 8) {
			throw myInvalidPasswordException;
		}
	}
}
