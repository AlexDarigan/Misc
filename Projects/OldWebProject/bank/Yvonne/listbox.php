<?php
// Author:		Yvonne Ryan - C00263872	
// Student No:	C00263872
// Date:		March 2022
// Title:		listbox.php
// Purpose:		Listbox used for Open Deposit Account screen
include $_SERVER['DOCUMENT_ROOT'] . "/bank/common/db.inc.php";

// query to select Customer Details
$sql= "SELECT Customer_Number, First_Name, Surname, Date_of_Birth, Address FROM Customer WHERE Deleted = 0";

if (!$result = mysqli_query($con,$sql))		// check for error
	{
		die('Error in querying the database)' . mysqli_error($con));
	}

echo "<br><select name='listbox' id='listbox' onclick='populate()'>";	// on click populate function will fill the form with data

while ($row = mysqli_fetch_array($result))	// fetch array fetches a result row as an associative array
		{	
			$num = $row['Customer_Number'];
			$fname = $row['First_Name'];
			$sname = $row['Surname'];
			$DOB = $row['Date_of_Birth'];
			$addrs = $row['Address'];
			$allText = "$num,$fname,$sname,$DOB,$addrs";
			echo "<option value= '$allText'>$num $fname $sname</option>";
		
		}

echo "</select>";
mysqli_close($con);

?>
	

	

	