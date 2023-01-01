package ie.itcarlow.Lab4;

public class Office {

	private static int roomCount = 0;
	private int roomNumber;
	private Employee[] assignedEmployees = new Employee[2];
	
	public Office()
	{
		setRoomNumber(roomCount);
		++roomCount;
	}
	
	public void assignEmployeeToOffice(Employee employee)
	{
		if(assignedEmployees.length >= 2)
		{
			System.out.println("Office already has the maximum two Employees assigned");
		}
		else 
		{
			assignedEmployees[assignedEmployees.length] = employee;
		}
	}
	
	public Employee getRecordOfAssignedEmployee(int index)
	{
		return assignedEmployees[index];
	}
	
	public int getNumberOfAssignedEmployees()
	{
		return assignedEmployees.length;
	}

	public int getRoomNumber() {
		return roomNumber;
	}

	public void setRoomNumber(int roomNumber) {
		this.roomNumber = 100 + roomNumber;
	}
	
	public String toString()
	{
		String strOffice = "\nRoom Number: " + getRoomNumber() + "\nAssigned Employees: " + getNumberOfAssignedEmployees();
		for(int i = 0; i < getNumberOfAssignedEmployees(); i++)
		{
			strOffice += "\nEmployee " + i + "\n" + assignedEmployees[i].toString();
		}
		return strOffice;
	}
}
