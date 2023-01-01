<?php

include $_SERVER['DOCUMENT_ROOT'] . "/bank/common/db.inc.php";

// query to select Customer Details
$sql= "SELECT Customer.Customer_Number, First_Name, Surname, Date_of_Birth, Address, Loan_Account_Number
		FROM Customer
		INNER JOIN Loan_Account
		ON Customer.Customer_Number = Loan_Account.Customer_Number";

if (!$result = mysqli_query($con,$sql))
	{
		die('Error in querying the database)' . mysqli_error($con));
	}

echo "<br><select name='listbox3' id='listbox3' onclick='populateB()'>";

	
while ($row = mysqli_fetch_array($result))		// fetch array fetches a result row as an associative array
		{	
			$num = $row['Customer_Number'];
			$fname = $row['First_Name'];
			$sname = $row['Surname'];
			$dateOfB = $row['Date_of_Birth'];
			$dob = date_create($row['DOB']);
			$dob = date_format($dob, "Y-m-d");
			$addrs = $row['Address'];
			$accountNo = $row['Loan_Account_Number'];
			$allText = "$num,$fname,$sname,$dob,$addrs,$accountNo";
			echo "<option value= '$allText'>$num $fname $sname</option>";
		
		}

echo "</select>";
mysqli_close($con);

?>