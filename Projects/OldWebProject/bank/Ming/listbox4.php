<?php
// Author:		Ming Kit Choy
// Date:		March 2022
// Title:		listbox4.php
// Purpose:		Listbox used for Loan Account History screen
include $_SERVER['DOCUMENT_ROOT'] . "/bank/common/db.inc.php";

// query to select Customer Details
$sql= "SELECT Customer.Customer_Number, First_Name, Surname, Date_of_Birth, Address, Loan_Account_Number
		FROM Customer
		INNER JOIN Loan_Account ON
		Customer.Customer_Number = Loan_Account.Customer_Number
		WHERE Deleted = 0";

if (!$result = mysqli_query($con,$sql))		// check for error
	{
		die('Error in querying the database)' . mysqli_error($con));
	}

echo "<br><select name='listbox4' id='listbox4' onclick='populateHistory()'>";	// on click populate function will fill the form with data

while ($row = mysqli_fetch_array($result))	
		{	
			$num = $row['Customer_Number'];
			$fname = $row['First_Name'];
			$sname = $row['Surname'];
			$dateOfB = $row['Date_of_Birth'];
			$dob = date_create($row['DOB']);
			$dob = date_format($dob, "Y-m-d");
			$addrs = $row['Address'];
			$accNo = $row['Loan_Account_Number'];
			$allText = "$num,$fname,$sname,$dob,$addrs,$accNo";
			echo "<option value= '$allText'>$accNo $fname $sname</option>";
		
		}

echo "</select>";
mysqli_close($con);

?>
	
