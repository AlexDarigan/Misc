package ie.itcarlow.Lab4;

public class Employee {

	private static int employeeRecordCount = 0;
	private int employeeNumber;
	private Address address;
	
	// Type can be "Staff" or "Manager"
	// If "Manager", then include car details.
	private String type;
	private String car = "";
	
	public Employee()
	{
		setEmployeeNumber(employeeRecordCount);
		employeeRecordCount++;
	}
	
	public int getEmployeeRecordCount()
	{
		return employeeRecordCount;
	}
	
	public int getEmployeeNumber()
	{
		return employeeNumber;
	}
	
	public void setEmployeeNumber(int employeeNumber)
	{
		this.employeeNumber = 1000 + employeeNumber;
	}

	public Address getAddress() 
	{
		return address;
	}

	public void setAddress(Address address) 
	{
		this.address = address;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public String getCar() {
		
		if(getType() != "Manager")
		{
			System.out.println("Only Managers have company cars.");
		}
		return car;
	}

	public void setCar(String car) {
		
		if(getType() != "Manager")
		{
			System.out.println("Only Managers may have company cars");
			return;
		}
		this.car = car;
	}
	
	public String toString()
	{
		String strEmployee = "";
		strEmployee = "\nEmployee Number" + getEmployeeNumber() + "\nType" + getType() + "\nAddress" + getAddress();
		if(getType() == "Manager")
		{
			strEmployee += "\nCompany Car: " + car;
		}
		return strEmployee;
	}

	
}
