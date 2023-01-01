package ie.itcarlow.Lab7;

public class VaccinationDriver {

	public static void main(String[] args) {
		
		Vet vet  = new Vet("Jack Doyle");
		Animal cat = new Cat("Persian", 2, 'M');
		Animal dog = new Dog("Labrador", 7, 'F');
		
		vet.vaccinate(cat);		
		System.out.println();
		vet.vaccinate(dog);
	}

}
