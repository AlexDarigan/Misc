package ie.itcarlow.Lab7;

public class Dog extends Animal {
	
	public Dog()
	{
		this("", 0, ' ');
	}
	
	public Dog(String name, int age, char gender)
	{
		super(name, age, gender);
	}
	
	public void eat() {
		System.out.println("Dog is eating");
	}
	
	public void sleep() {
		System.out.println("Dog is sleeping");
	}
	
	public void makeSound() {
		System.out.println("Bark");
	}

	public String toString()
	{
		return "type: " + getType() + "\nage: " + getAge() + "\ngender: " + getGender(); 	
	}
	
	
}
