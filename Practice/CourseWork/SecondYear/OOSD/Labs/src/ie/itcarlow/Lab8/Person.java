package ie.itcarlow.Lab8;

public abstract class Person {
	
	private String name;
	
	public Person(String name) {
		setName(name);
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public abstract String getDescription();
	
	
}
