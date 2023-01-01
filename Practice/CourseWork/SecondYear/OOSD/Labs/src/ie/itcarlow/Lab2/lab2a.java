// Note: A WIP. Uploading just so it exists for my laptop.

package ie.itcarlow.Lab2;

/*
Student Name 		: David Darigan
Student Id Number	: C00263218
Date 				: October 2021
Purpose 			: Driver program to test instantiation and data manipulation for the HotelRoom class
*/
public class lab2a {

	public static void main(String[] args)
	{
		HotelRoom roomA = new HotelRoom();
		HotelRoom roomB = new HotelRoom();

		// Setting values for room a
		roomA.setRoomNumber(200);
		roomA.setRoomType("Single");
		roomA.setRate(100);
		roomA.setOccupancy(1);

		// Setting values for room b
		roomB.setRoomNumber(201);
		roomB.setRoomType("Double");
		roomB.setRate(80);
		roomB.setOccupancy(0);
		
		
		
		
		// Using overridden constructor
		HotelRoom roomC = new HotelRoom(202, "Single", 0, 90);
		
		// Getting values from room a
		System.out.println("Number of RoomA is " + roomA.getRoomNumber());
		System.out.println("Type of RoomA is " + roomA.getRoomType());
		System.out.println("Rate of RoomA is " + roomA.getRate());
		System.out.println("RoomA is occupied: " + roomA.getOccupancy());
		
		// Getting values from room b
		System.out.println("Number of RoomB is " + roomB.getRoomNumber());
		System.out.println("Type of RoomB is " + roomB.getRoomType());
		System.out.println("Rate of RoomB is " + roomB.getRate());
		System.out.println("RoomB is occupied: " + roomB.getOccupancy());
		
		if(!roomB.isOccupied())
		{
			roomB.setOccupancy(1);
		} 
		else
		{
			System.out.println("Room B is already occupied");
		}
	}
}
