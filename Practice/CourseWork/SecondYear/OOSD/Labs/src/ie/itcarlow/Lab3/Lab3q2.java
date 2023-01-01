package ie.itcarlow.Lab3;

/*
Student Name 		: David Darigan
Student Id Number	: C00263218
Date 				: October 2021
Purpose 			: Driver Program for Savings Account
*/

public class Lab3q2 
{
	public static void main(String[] args)
	{
		SavingsAccount saver1 = new SavingsAccount();
		SavingsAccount saver2 = new SavingsAccount();
		saver1.setSavingsBalance(2000);
		saver2.setSavingsBalance(3000);
		SavingsAccount.ModifyInterestRate(0.04); //
		saver1.CalculateMonthlyInterest();
		saver2.CalculateMonthlyInterest();
		System.out.println("Saver 1's new balance is " + saver1.getSavingsBalance());
		System.out.println("Saver 2's new balance is " + saver2.getSavingsBalance());
		SavingsAccount.ModifyInterestRate(0.05);
		saver1.CalculateMonthlyInterest();
		saver2.CalculateMonthlyInterest();
		System.out.println("Saver 1's new balance is " + saver1.getSavingsBalance());
		System.out.println("Saver 2's new balance is " + saver2.getSavingsBalance());
	}
}
