package ie.itcarlow.Lab6;

public class Student extends Person
{

	private int numCourses;
	private String[] courses;
	private int[] grades;
	
	public Student(String name, String address)
	{
		super(name, address);
		setCourses(new String[10]);
		setGrades(new int[10]);
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

	public int[] getGrades()
	{
		return grades;
	}

	public void setGrades(int[] grades)
	{
		this.grades = grades;
	}

	@Override
	public String toString()
	{
		return "Student: " + getName() + "<" + getAddress() + ">";
	}
	
	public void addCourseGrade(String course, int grade)
	{
		int numCourses = getNumCourses();
		String[] courses = getCourses();
		if(numCourses + 1 >= courses.length)
		{
			// No room to fit the course
			return;
		}
		int[] grades = getGrades();
		courses[numCourses] = course;
		grades[numCourses] = grade;
		setCourses(courses);
		setGrades(grades);
		setNumCourses(++numCourses);
	}
	
	public void printGrades()
	{
		//System.out.println(this + " grades go here");
		String[] courses = getCourses();
		int[] grades = getGrades();
		int numCourses = getNumCourses();
		String strCourseGrades = "";
		for(int i = 0; i < numCourses; i++)
		{
			strCourseGrades += " " + courses[i] + ":" + grades[i]; 
		}
		System.out.println(this + strCourseGrades);
	}
	
	public double getAverageGrade()
	{
		double sumOfGrades = 0;
		int numCourses = getNumCourses();
		int[] grades = getGrades();
		for(int i = 0; i <= numCourses; i++)
		{
			sumOfGrades += grades[i]; 
		}
		
		return sumOfGrades / numCourses;
	}

}
