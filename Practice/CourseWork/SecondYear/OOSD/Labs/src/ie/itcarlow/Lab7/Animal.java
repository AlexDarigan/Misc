package ie.itcarlow.Lab7;

public class Animal {

	private String type;
	private int age;
	private char gender; // 'F' -> Female, 'M' -> Male;
	
	public Animal() {
		this("", 0, ' ');
	}
	
	public Animal(String type, int age, char gender) {
		setType(type);
		setAge(age);
		setGender(gender);
	}
	
	public void eat() {
		System.out.println("Animal is eating");
	}
	
	public void sleep() {
		System.out.println("Animal is sleeping");
	}
	
	public void makeSound() {
		System.out.println("A generic animal sound");
	}

	public String toString()
	{
		return "type: " + getType() + "\nage: " + getAge() + "\ngender: " + getGender(); 	
	}
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public char getGender() {
		return gender;
	}

	public void setGender(char gender) {
		this.gender = gender;
	}
}
