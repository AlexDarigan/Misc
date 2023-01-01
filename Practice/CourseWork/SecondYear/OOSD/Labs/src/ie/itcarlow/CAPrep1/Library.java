package ie.itcarlow.CAPrep1;

import java.util.Scanner;

/*
Write a driver program called Library which will allow the user to 
enter details of 3 books. Invoke the Borrow method for one of the 
objects. 
Write an appropriate toString() for the Book class and call it for 
each of the object instances you created at the end of the program. 
Write  a  static  method  which  returns  the  number  of  Book  objects 
created, and call it after each Book has been created. 
 */

public class Library {
	

	public static void main(String[] args) {

		Scanner scanner = new Scanner(System.in);
		Book[] books = new Book[3];
		for(int i = 0; i < 3; i++)
		{
			Book book = new Book();
			System.out.println("Please enter book name: ");
			book.setName(scanner.nextLine());
			System.out.println("Please enter book author: ");
			book.setAuthor(scanner.nextLine());
			System.out.println("Please enter book genre: ");
			book.setGenre(scanner.nextLine());
			System.out.println("Please set the book status (A -> available, B -> borrowed)");
			book.setStatus(scanner.nextLine());
			books[i] = book;
			System.out.println("Number of Books: " + Book.getNumberOfBooksCreated());
		}
		
		books[2].Borrow();
		
		for(int i = 0; i < 3; i++)
		{
			System.out.println(books[i]);
			System.out.print("--------");
		}
		
		scanner.close();
	}

}
