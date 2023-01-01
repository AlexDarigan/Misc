package ie.itcarlow.Lab8;

public class Cylinder extends ThreeDShape {

	private double radius;
	private double height;
	
	public Cylinder(String name, String color, double radius, double height) {
		super(name, color);
		setRadius(radius);
		setHeight(height);
	}
	
	public void setRadius(double radius) {
		this.radius = radius;
	}
	
	public double getRadius() {
		return radius;
	}
	
	public void setHeight(double height) {
		this.height = height;
	}
	
	public double getHeight() {
		return height;
	}

	@Override
	public double volume() {
		return Math.PI * (getRadius() * getRadius()) * getHeight();
	}

	@Override
	public double area() {
		return 2 * Math.PI * (getRadius() * getRadius()) + getHeight() * (2 * Math.PI * getRadius());
	}
	
	@Override
	public String toString() {
		//String s = String.format("%.2f", 1.2975118);
		return super.toString() + "\nRadius = " + getRadius() + "\nHeight = " + getHeight();
	}
}
