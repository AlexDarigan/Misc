package ie.itcarlow.Lab8;

public class Employee extends Person {

	private float annualSalary;
	
	public Employee(String name, float annualSalary) {
		super(name);
		setAnnualSalary(annualSalary);
	}
	
	
	private void setAnnualSalary(float annualSalary) {
		this.annualSalary = annualSalary;
	}
	
	public float getAnnualSalary() {
		return annualSalary;
	}
	
	@Override
	public String getDescription() {
		return "An employee with a salary of " + getAnnualSalary();
	}
}
