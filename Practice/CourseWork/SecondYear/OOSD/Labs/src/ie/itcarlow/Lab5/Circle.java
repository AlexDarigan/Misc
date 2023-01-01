package ie.itcarlow.Lab5;

public class Circle extends Point 
{
	private double radius;
	
	public Circle(int x, int y, int radius)
	{
		super(x, y);
		setRadius(radius);
	}
	
	public double getRadius()
	{
		return radius;
	}
	
	public void setRadius(int radius)
	{
		this.radius = radius;
	}
	
	public String toString()
	{
		return "x: " + getX() + ", y: " + getY() + ", radius: " + getRadius();
	}
}