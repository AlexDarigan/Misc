package ie.itcarlow.Lab3;

public class SavingsAccount 
{
	private static int numOfAccounts = 0;
	private static double annualInterestRate = 0;
	private double savingsBalance = 0;
	private int accountNumber;
	
	public SavingsAccount()
	{
		numOfAccounts++;
		accountNumber = numOfAccounts;
	}
	
	public void CalculateMonthlyInterest()
	{
		setSavingsBalance(savingsBalance + (savingsBalance * annualInterestRate) / 12);

	}
	
	public static void ModifyInterestRate(double newRate)
	{
		annualInterestRate = newRate;
	}
	
	public void setSavingsBalance(double newBalance)
	{
		savingsBalance = newBalance;
	}
	
	public double getSavingsBalance()
	{
		return savingsBalance;
	}
	
	
}
