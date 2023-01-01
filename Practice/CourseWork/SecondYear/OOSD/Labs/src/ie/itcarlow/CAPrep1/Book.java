package ie.itcarlow.CAPrep1;

/*
 Problem:  
 
Create a new java class called Book. The Book class should be able 
to store the folowing data: 
Book name, Author, ISBN, Genre, Status, Number of books created in 
library. 
 
The  ISBN  number  will  be  maintained  automatically  by  the  class.  It 
should  be  an  int  starting  at  1  and  get  assigned  within  the 
constructor. All other fields should only be accessible via getter and 
setter  methods  which  you  should  provide  in  the  class.  The 
constructor should use the setter methods. The Status field should 
either be ‘A’ for available or ‘B’ for borrowed. Create a class method 
called Borrow() which will set the Status to ‘B’ for a book. 
 
Write a driver program called Library which will allow the user to 
enter details of 3 books. Invoke the Borrow method for one of the 
objects. 
Write an appropriate toString() for the Book class and call it for 
each of the object instances you created at the end of the program. 
Write  a  static  method  which  returns  the  number  of  Book  objects 
created, and call it after each Book has been created. 
 */

public class Book 
{
	private String name;
	private String author;
	private String genre;
	private String status;
	private int ISBN;
	private static int numberOfBooksCreated = 0;
	
	public Book()
	{
		numberOfBooksCreated++;
		ISBN = numberOfBooksCreated;
	}
	
	public static int getNumberOfBooksCreated()
	{
		return numberOfBooksCreated;
	}
	
	public String getName()
	{
		return name;
	}
	
	public String getAuthor()
	{
		return author;
	}
	
	public String getGenre()
	{
		return genre;
	}
	
	public String getStatus()
	{
		return status;
	}
	
	public int getISBN()
	{
		return ISBN;
	}
	
	public void setName(String name)
	{
		this.name = name;
	}
	
	public void setAuthor(String author)
	{
		this.author = author;
	}
	
	public void setGenre(String genre)
	{
		this.genre = genre;
	}
	
	public void setStatus(String status)
	{
		// A for Available
		// B for Borrowed
		this.status = status;
	}
	
	public void Borrow()
	{
		setStatus("B");
	}
	
	public String toString()
	{
		String bookString = "";
		bookString += "\nName: " + getName();
		bookString += "\nAuthor: " + getAuthor();
		bookString += "\nGenre: " + getGenre();
		bookString += "\nISBN: " + getISBN();
		bookString += "\nStatus: " + getStatus();
		return bookString;
	}
	
	
}
