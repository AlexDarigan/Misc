package ie.itcarlow.Lab6;

public class Teacher extends Person
{

	private int numCourses;
	private String[] courses;
		
	public Teacher(String name, String address)
	{
		super(name, address);
		setCourses(new String[10]); // No definitive size given so using a default size of 10
		setNumCourses(0);
	}

	public int getNumCourses()
	{
		return numCourses;
	}

	public void setNumCourses(int numCourses)
	{
		this.numCourses = numCourses;
	}

	public String[] getCourses()
	{
		return courses;
	}

	public void setCourses(String[] courses)
	{
		this.courses = courses;
	}

	@Override
	public String toString()
	{
		return "Teacher: " + super.toString();
	}
	
	public boolean addCourse(String course)
	{
		String[] courses = getCourses();
		int numCourses = getNumCourses();
		if(numCourses + 1 >= courses.length)
		{
			return false;
		}
		
		courses[numCourses] = course;
		++numCourses;
		setCourses(courses);
		setNumCourses(numCourses);
		return true;
	}
	
	public boolean removeCourse(String course)
	{
		int numCourses = getNumCourses();
		String[] courses = getCourses();
		boolean courseWasRemoved = false;
		for(int i = 0; i < numCourses; i++)
		{
			System.out.println(courses[i]);
			if(courses[i].equals(course)) 
			{
				
				/* In most cases this removed course would be over-written by the left shift
				   in the else branch *except* for when it is the last element, so we need
				   an explicit setter here */
				courses[i] = "";
				courseWasRemoved = true;
				
			}
			else if(courseWasRemoved)
			{
				courses[i - 1] = courses[i];
			}
		}
		
		if(courseWasRemoved) {
			setCourses(courses);
			setNumCourses(--numCourses);
		}
		
		return courseWasRemoved;
	}
	
	
	
}
