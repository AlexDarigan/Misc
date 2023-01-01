package ie.itcarlow.Lab8;

public class Circle extends TwoDShape {

//	Circle 		circle = new Circle("Circle One", "Red", 10.0);
//		Rectangle	rectangle = new Rectangle("Rectangle One", "Yellow", 15.0, 20.0);
//		Cylinder	cylinder = new Cylinder("Cylinder One", "Green", 6, 8);
//		Sphere		sphere = new Sphere("Sphere One", "Blue", 77);
		
	private double radius;
	
	public Circle(String name, String colour, double radius) {
		super(name, colour);
		setRadius(radius);
	}


	public double getRadius() {
		return radius;
	}
	
	public void setRadius(double radius) {
		this.radius = radius;
	}
	
	@Override
	public double area() {
		// TODO Auto-generated method stub
		return Math.PI * (getRadius() * getRadius());
	}
	
	@Override
	public String toString() {
		return super.toString() + "\nRadius = " + getRadius();
	}

}
