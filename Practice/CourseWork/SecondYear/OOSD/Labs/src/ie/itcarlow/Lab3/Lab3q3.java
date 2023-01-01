package ie.itcarlow.Lab3;

/*
Student Name 		: David Darigan
Student Id Number	: C00263218
Date 				: October 2021
Purpose 			: Driver Program for Bank Customer
*/

public class Lab3q3 
{
	public static void main(String[] args)
	{
		// Test SavingsAccount is added
		// Test numberOfSavingsAccount is added
		// Test balance works correctly
		// Test Savings Account doesn't go over 3
		
		BankCustomer bankCustomer = new BankCustomer("Mr. Nobody", "Nowhere");
		bankCustomer.addAccount(new SavingsAccount());
		
		// Should output "Mr. Nobody"
		System.out.println(bankCustomer.getName());
		
		// Should output "Nowhere"
		System.out.println(bankCustomer.getAddress());
		
		// Should output 1
		System.out.println("Bank Customer has " + bankCustomer.getNumberOfAccounts() + " account(s)");
		
		for(int i = 0; i < 2; i++)
		{
			bankCustomer.addAccount(new SavingsAccount());
		}
		
		// Should output 3
		System.out.println("Bank Customer has " + bankCustomer.getNumberOfAccounts() + " account(s)");
		
		bankCustomer.addAccount(new SavingsAccount());
		
		// Should still output 3
		System.out.println("Bank Customer has " + bankCustomer.getNumberOfAccounts() + " account(s)");
		
		BankCustomer bankCustomer2 = new BankCustomer("Mr. Somebody", "Somewhere");
		SavingsAccount firstAccount = new SavingsAccount();
		SavingsAccount secondAccount = new SavingsAccount();
		firstAccount.setSavingsBalance(2500);
		secondAccount.setSavingsBalance(5000);
		
		bankCustomer2.addAccount(firstAccount);
		// Should output 2500
		System.out.println("Bank Customer 2 has total savings of " + bankCustomer2.balance());
		
		bankCustomer2.addAccount(secondAccount);
		// Should output 7500
		System.out.println("Bank Customer 2 has total savings of " + bankCustomer2.balance());
	}
}
