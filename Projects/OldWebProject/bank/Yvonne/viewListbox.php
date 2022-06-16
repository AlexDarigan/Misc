<?php
// Author: 		Yvonne Ryan - C00263872	
// Student No:	C00263872
// Date:		Feb 2022
// Title:		viewListbox.php
// Purpose:		Listbox to display Customer and Account details for View page

include $_SERVER['DOCUMENT_ROOT'] . "/bank/common/db.inc.php";

// query to select details from Customer and Deposit Account
$sql = "SELECT First_Name, Surname, Address, Date_of_Birth, Customer.Customer_Number, Balance, Deposit_Account_Number
		FROM Customer
		INNER JOIN Deposit_Account
		ON Customer.Customer_Number = Deposit_Account.Customer_Number
		WHERE Closed = 0";
		
		if (!$result = mysqli_query($con,$sql))	// check for erroor
	{
		die('Error in querying the database)' . mysqli_error($con));
	}

echo "<br><select name='viewListbox' id='viewListbox' onclick='populateView()'>";

while ($row = mysqli_fetch_array($result))		// fetch array fetches a result row as an associative array
		{	
			$fname = $row['First_Name'];
			$sname = $row['Surname'];
			$addrs = $row['Address'];
			$dateOfB = $row['Date_of_Birth'];
			$dob = date_create($row['DOB']);
			$dob = date_format($dob, "Y-m-d");
			$num = $row['Customer_Number'];
			$bal = $row['Balance'];
			$accNo = $row['Deposit_Account_Number'];
			$allText = "$fname,$sname,$addrs,$dob,$num,$bal,$accNo";
			echo "<option value= '$allText'>$accNo $fname $sname</option>";
		
		}

echo "</select>";
mysqli_close($con);

?>
	

	
