package ie.itcarlow.Lab8;

public class TestPerson {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Person[] people = new Person[2];
		people[0] = new Employee("Mr. Nobody", 200.00f);
		people[1] = new Student("Jake C", "Bio");
		
		for(Person person: people) {
			System.out.println(person.getName());
			System.out.println(person.getDescription());
		}
	}

}
