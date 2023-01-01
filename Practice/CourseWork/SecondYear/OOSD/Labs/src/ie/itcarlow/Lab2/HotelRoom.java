package ie.itcarlow.Lab2;

public class HotelRoom {

	private int roomNumber;
	private String roomType; // "Single" or "Double"
	private int occupancy; // 0 (Vacant) or 1 (Occupied)
	private double rate;
	
	public HotelRoom()
	{
		
	}
	
	public HotelRoom(int number, String type, int roomOccupancy, int nightlyRate)
	{
		setRoomNumber(number);
		setRoomType(type);
		setOccupancy(roomOccupancy);
		setRate(nightlyRate);
	}
	
 
	public int getRoomNumber() {
		return roomNumber;
	}

	public void setRoomNumber(int number) {
		roomNumber = number;
	}

	public String getRoomType() {
		return roomType;
	}

	public void setRoomType(String type) {
		if(!type.equals("Single") && !type.equals("Double"))
		{
			// Invalid Type so we set it to a default
			roomType = "Single";
		}
		else
		{
			roomType = type;
		}
	}

	public int getOccupancy() {
		return occupancy;
	}

	public void setOccupancy(int newOccupancy) {
		if(newOccupancy > 1 || newOccupancy < 0)
		{
			// Invalid type was entered so we set rooms by default to prevent double booking
			newOccupancy = 1;
		}
		else 
		{
			occupancy = newOccupancy;
		}
	}

	public double getRate() {
		return rate;
	}

	public void setRate(double nightlyRate) {
		rate = nightlyRate;
	}
	
	public boolean isOccupied()
	{
		return occupancy == 1;
	}
			
}
