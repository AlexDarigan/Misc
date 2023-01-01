package ie.itcarlow.Lab3;

public class BankCustomer 
{
	private String name;
	private String address;
	private SavingsAccount[] savingsAccounts = new SavingsAccount[3];
	private int numberOfAccounts = 0;
	
	public BankCustomer(String customerName, String customerAddress)
	{
		setName(customerName);
		setAddress(customerAddress);
	}
	
	public void addAccount(SavingsAccount newAccount)
	{
		if(numberOfAccounts < 3)
		{
			savingsAccounts[numberOfAccounts] = newAccount;
			numberOfAccounts++;
		}
	}
	
	public void setName(String newName)
	{
		name = newName;
	}
	
	public void setAddress(String newAddress)
	{
		address = newAddress;
	}
	
	public int getNumberOfAccounts()
	{
		return numberOfAccounts;
	}
	
	public String getName()
	{
		return name;
	}
	
	public String getAddress()
	{
		return address;
	}
	
	public double balance()
	{
		double totalSavings = 0;
		for(int i = 0; i < numberOfAccounts; i++)
		{
			totalSavings += savingsAccounts[i].getSavingsBalance();
		}
		return totalSavings;
	}
}
