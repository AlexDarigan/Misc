package ie.itcarlow.Lab7;

public class Cat extends Animal {

	public Cat()
	{
		this("", 0, ' ');
	}
	
	public Cat(String name, int age, char gender)
	{
		super(name, age, gender);
	}
	
	public void eat() {
		System.out.println("Cat is eating");
	}
	
	public void sleep() {
		System.out.println("Cat is sleeping");
	}
	
	public void makeSound() {
		System.out.println("Meow");
	}

	public String toString()
	{
		return "type: " + getType() + "\nage: " + getAge() + "\ngender: " + getGender(); 	
	}
}
