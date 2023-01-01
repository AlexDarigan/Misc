package ie.itcarlow.Lab8;

public class Rectangle extends TwoDShape {

	private double length;
	private double breadth;
	
	public Rectangle(String name, String color, double length, double breadth) {
		super(name, color);
		setLength(length);
		setWidth(breadth);
	}
	
	public void setWidth(double breadth) {
		this.breadth = breadth;
	}
	
	public double getBreadth() {
		return breadth;
	}
	
	public void setLength(double length) {
		this.length = length;
	}
	
	public double getLength() {
		return length;
	}
	
	@Override
	public double area() {
		// TODO Auto-generated method stub
		return getLength() * getBreadth();
	}
	
	@Override
	public String toString() {
		return super.toString() + "\nLength = " + getLength() + "\nBreadth = " + getBreadth();
	}

}
