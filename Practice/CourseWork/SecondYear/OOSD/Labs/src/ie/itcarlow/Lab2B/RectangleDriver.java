package ie.itcarlow.Lab2B;

public class RectangleDriver {

	public static void main(String[] args)
	{
		Rectangle rect = new Rectangle();
		System.out.println("Default Length: " + rect.getLength());
		System.out.println("Default Width: " + rect.getWidth());
		System.out.println(rect);
		System.out.println("Default Area: " + rect.getArea());
		System.out.println("Default Perimeter" + rect.getPerimeter());
		rect.printRectangle();
		
		rect.setLength(5);
		rect.setWidth(10);
		System.out.println("Length: " + rect.getLength());
		System.out.println("Width: " + rect.getWidth());
		System.out.println("Area: " + rect.getArea());
		System.out.println("Perimeter: " + rect.getPerimeter());
		System.out.println(rect);
		rect.printRectangle();
	
	}
}
