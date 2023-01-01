<?php
// Author:	Yvonne Ryan - C00263872	
// Date:	March 2022
// Title:	listbox3.php
// Purpose:	Listbox used for Close Deposit Account screen
include $_SERVER['DOCUMENT_ROOT'] . "/bank/common/db.inc.php";

// query to select Customer Details
$sql= "SELECT Customer.Customer_Number, First_Name, Surname, Date_of_Birth, Address, Deposit_Account_Number
		FROM Customer
		INNER JOIN Deposit_Account
		ON Customer.Customer_Number = Deposit_Account.Customer_Number
		WHERE Closed = 0";

if (!$result = mysqli_query($con,$sql))
	{
		die('Error in querying the database)' . mysqli_error($con));
	}

echo "<br><select name='closeListbox' id='closeListbox' onclick='populateClose()'>";

	
while ($row = mysqli_fetch_array($result))		// fetch array fetches a result row as an associative array
		{	
			$num = $row['Customer_Number'];
			$fname = $row['First_Name'];
			$sname = $row['Surname'];
			$dateOfB = $row['Date_of_Birth'];
			$dob = date_create($row['DOB']);
			$dob = date_format($dob, "Y-m-d");
			$addrs = $row['Address'];
			$accountNo = $row['Deposit_Account_Number'];
			$allText = "$num,$fname,$sname,$dob,$addrs,$accountNo";
			echo "<option value= '$allText'>$accountNo $fname $sname</option>";
		
		}

echo "</select>";
mysqli_close($con);

?>
	

	