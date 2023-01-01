package ie.itcarlow.Lab2B;

public class Rectangle {

	private int length;
	private int width;
	
	
	public Rectangle()
	{
		setLength(1);
		setWidth(1);
	}

	public int getLength() 
	{
		return length;
	}

	public void setLength(int newLength) 
	{

		if(newLength <= 0.0)
		{
			this.length = 1;
		}
		else if(newLength > 40.0)
		{
			this.length = 40;
		}
		else 
		{
			this.length = newLength;
		}
	}

	public int getWidth() 
	{
		return width;
	}

	public void setWidth(int newWidth) 
	{
		
		if(newWidth <= 0.0)
		{
			this.width = 1;
		}
		else if(newWidth > 40.0)
		{
			this.width = 40;
		}
		else 
		{
			this.width = newWidth;
		}
		
	}
	
	public int getArea()
	{
		return length * width;
	}
	
	public int getPerimeter()
	{
		return length + length + width + width;
	}
	
	public void printRectangle()
	{
		for(int i = 0; i < this.length; i++)
		{
			System.out.print("*");
			for(int j = 1; j < this.width - 1; j++)
			{
				if(i == 0 || i == this.length - 1)
				{
					System.out.print("*");
				} 
				else
				{
					System.out.print(" ");
				}
			}
			
			System.out.println("*");
		}
		
	}

	public String toString()
	{
		return "Length: " + length + "\nWidth: " + width;
	}
}
