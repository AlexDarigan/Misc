<?php
// Author: 	Ming Kit Choy
// Date:	March 2022
// Purpose:	Listbox to display Customer and Account details for View/Amend page

include $_SERVER['DOCUMENT_ROOT'] . "/bank/common/db.inc.php";

// query to select details from Customer, Loan ccount, Loan Account Transaction and Transatcion using inner join
$sql = "SELECT First_Name, Surname, Address, Date_of_Birth, Customer.Customer_Number, Balance, Loan_Account.Loan_Account_Number, Transaction.TransactionID, Date, Amount
FROM `Customer` 
INNER JOIN Loan_Account on Customer.Customer_Number = Loan_Account.Customer_Number
INNER JOIN Loan_Account_Transaction on Loan_Account.Loan_Account_Number = Loan_Account_Transaction.Loan_Account_Number
INNER JOIN Transaction on Loan_Account_Transaction.TransactionID = Transaction.TransactionID " ;

if (!$result = mysqli_query($con,$sql))	// check for erroor
	{
		die('Error in querying the database' . mysqli_error($con));
	}

echo "<br><select name='listbox2' id='listbox2' onclick='populateA()'>";

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
			$accNo = $row['Loan_Account_Number'];
			$tID = $row['TransactionID'];
			$tDate= $row['Date'];
			$date= date_create($row['date']);
			$date = date_format($date, "Y-m-d");
			$amount = $row['Amount'];
			$allText = "$fname,$sname,$addrs,$dob,$num,$bal,$accNo,$tID,$date,$amount";
			echo "<option value= '$allText'>$num $fname $sname</option>";
		
		}

echo "</select>";
mysqli_close($con);

?>
	
