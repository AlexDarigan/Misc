<?php
// Author:		Ming kit Choy
// Date:		March 2022
// Title:		reportListbox.php
// Purpose:		Listbox used for Account Report screen
include $_SERVER['DOCUMENT_ROOT'] . "/bank/common/db.inc.php";

// query to select Customer Details
$sql= "SELECT Customer.Customer_Number, First_Name, Surname, Date_of_Birth, Address
		FROM Customer";

if (!$result = mysqli_query($con,$sql))		// check for error
	{
		die('Error in querying the database)' . mysqli_error($con));
	}

echo "<br><select name='reportListbox' id='reportListbox' onclick='populateHistory()'>";	// on click populate function will fill the form with data

while ($row = mysqli_fetch_array($result))	// fetch array fetches a result row as an associative array
		{	
			$num = $row['Customer_Number'];
			$fname = $row['First_Name'];
			$sname = $row['Surname'];
			$dateOfB = $row['Date_of_Birth'];
			$dob = date_create($row['DOB']);
			$dob = date_format($dob, "Y-m-d");
			$addrs = $row['Address'];
			$allText = "$num,$fname,$sname,$dob,$addrs,";
			echo "<option value= '$allText'>$accNo $fname $sname</option>";
		}

echo "</select>";
mysqli_close($con);

?>