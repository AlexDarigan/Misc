package ie.itcarlow.Lab7;

public class Vet {
	
	private String name;
	
	public Vet() {
		this("?");
	}
	
	public Vet(String name) {
		setName(name);
	}
	
	public void vaccinate(Animal animal) {
		System.out.println(getName() + " is vaccinating");
		if(animal instanceof Dog)
		{
			System.out.println("Dog has been vaccinated\n" + animal.toString());
		}
		else if(animal instanceof Cat)
		{
			System.out.println("Cat has been vaccinated\n" + animal.toString());
		}
	}
	
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
