package ie.itcarlow.Lab8;

public class Student extends Person {

	private String course;
	
	public Student(String name, String course) {
		super(name);
		setCourse(course);
	}
	
	public void setCourse(String course) {
		this.course = course;
	}
	
	public String getCourse() {
		return course;
	}
	
	@Override
	public String getDescription() {
		return "A Student studying " + getCourse();
	}
}
