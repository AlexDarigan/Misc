package ie.itcarlow.Lab4;

public class Address {

	private String street;
	private String town;
	private String county;
	
	public String getCounty() 
	{
		return county;
	}
	
	public void setCounty(String county) 
	{
		this.county = county;
	}
	
	public String getTown() 
	{
		return town;
	}
	
	public void setTown(String town) 
	{
		this.town = town;
	}
	
	public String getStreet() 
	{
		return street;
	}
	
	public void setStreet(String street) 
	{
		this.street = street;
	}
	
	public String toString()
	{
		return "\n" + getStreet() + "\n" + getTown() + "\n" + getCounty();		
	}
}
