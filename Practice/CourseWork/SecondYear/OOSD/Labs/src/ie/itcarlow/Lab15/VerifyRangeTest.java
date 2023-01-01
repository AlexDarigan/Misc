package ie.itcarlow.Lab15;
import java.util.Scanner;

public class VerifyRangeTest {
	
	public static void main(String[] args) {
		
		Scanner scanner = new Scanner(System.in);
		System.out.println("Please enter a number to verify if it is in range");
		int input = scanner.nextInt();
		Verifier verifier = new Verifier();
		
		try {
			verifier.verifyIntRange(input, 0, 100);
			System.out.println("Number in range!!!");
		} catch (MyOutOfRangeException outOfRange) {
			System.out.println(outOfRange.getMessage());
		}
		System.out.println();
		System.out.println("Please enter a password");
		String password = scanner.next();
		try {
			verifier.verifyPasswordStrength(password);
			System.out.println("Good Password");
		} catch (MyInvalidPasswordException invalidPassword) {
			System.out.println(invalidPassword.getMessage());
		}
		
		
	}

}
