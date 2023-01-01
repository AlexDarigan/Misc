package ie.itcarlow.Lab4;

//Author 		: David Darigan
//Student ID	: C00263218
//Date 			: 2nd November 2021
//Purpose 		: A HR System

public class MyHR {
	
	private Employee[] employees = new Employee[5];
	private Office[] offices = new Office[3];
	
	public MyHR()
	{
		for(int i = 0; i < 3; i++)
		{
			offices[i] = new Office();
		}
	}

	public void createNewEmployee(Office office, Address address, String type, String car)
	{
		if(employees.length >= 5)
		{
			System.out.println("Maximum number of Employees already created");
			return;
		}
		
		Employee employee = new Employee();
		employee.setAddress(address);
		employee.setType(type);
		office.assignEmployeeToOffice(employee);
		
		if(type == "Manager")
		{
			employee.setCar(car);
		}
	}
	
	public void listAllEmployees()
	{
		for(int i = 0; i < employees.length; i++)
		{
			System.out.println(employees[i]);
		}
	}
	
	public void listAllOffices()
	{
		for(int i = 0; i < offices.length; i++)
		{
			System.out.println(offices[i]);
		}
	}
}
