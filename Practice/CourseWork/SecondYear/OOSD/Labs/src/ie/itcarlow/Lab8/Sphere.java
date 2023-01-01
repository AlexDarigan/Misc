package ie.itcarlow.Lab8;

public class Sphere extends ThreeDShape {

	private double radius;
	
	public Sphere(String name, String color, double radius)
	{
		super(name, color);
		setRadius(radius);
	}
	
	public void setRadius(double radius) {
		this.radius = radius;
	}
	
	public double getRadius() {
		return radius;
	}
	
	@Override
	public double volume() {
		return (4 / 3) * Math.PI * (getRadius() * getRadius() * getRadius()); 
	}

	@Override
	public double area() {
		return 4 * Math.PI * (getRadius() * getRadius());
	}
	
	@Override
	public String toString() {
		return super.toString() + "\nRadius = " + getRadius();
	}

}
