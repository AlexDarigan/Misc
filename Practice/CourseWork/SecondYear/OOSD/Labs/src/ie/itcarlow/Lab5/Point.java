package ie.itcarlow.Lab5;

public class Point 
{
	protected int x;
	protected int y;
	
	public Point(int x, int y)
	{
		setX(x);
		setY(y);
	}
	
	public int getX()
	{
		return x;
	}
	
	public void setX(int x)
	{
		this.x = x;
	}
	
	public int getY()
	{
		return y;
	}
	
	public void setY(int y)
	{
		this.y= y; 
	}
	
	public String toString()
	{
		return "x: " + getX() + ", y: " + getY();
	}
}
