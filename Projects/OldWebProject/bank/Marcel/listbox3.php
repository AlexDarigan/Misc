<?php
include $_SERVER['DOCUMENT_ROOT'] . "/bank/common/db.inc.php";

// query to select details from Customer, Current ccount, Current Account Transaction and Transatcion using inner join
$sql = "SELECT First_Name, Surname, Address, Date_of_Birth, Customer.Customer_Number, Overdraft_Limit, Balance, Current_Account.Current_Account_Number, Transaction.TransactionID, Date, Type, Amount
FROM Customer
INNER JOIN Current_Account
ON Customer.Customer_Number = Current_Account.Customer_Number
INNER JOIN Current_Account_Transaction on Current_Account.Current_Account_Number = Current_Account_Transaction.Current_Account_Number
INNER JOIN Transaction on Current_Account_Transaction.TransactionID = Transaction.TransactionID 
WHERE Closed = 0 AND Deleted = 0";

if (!$result = mysqli_query($con,$sql))	// check for erroor
	{
		die('Error in querying the database)' . mysqli_error($con));
	}

echo "<br><select name='listbox3' id='listbox3' onclick='populateA()'>";

while ($row = mysqli_fetch_array($result))		// fetch array fetches a result row as an associative array
		{	
			$fname = $row['First_Name'];
			$sname = $row['Surname'];
			$addrs = $row['Address'];
			$dateOfB = $row['Date_of_Birth'];
			$dob = date_create($row['DOB']);
			$dob = date_format($dob, "Y-m-d");
			$num = $row['Customer_Number'];
			$overlimit = $row['Overdraft_Limit'];
			$bal = $row['Balance'];
			$accNo = $row['Current_Account_Number'];
			$tID = $row['TransactionID'];
			$tDate= $row['Date'];
			$date= date_create($row['date']);
			$date = date_format($date, "Y-m-d");
			$type = $row['Type'];
			$amount = $row['Amount'];
			$allText = "$fname,$sname,$addrs,$dob,$num,$overlimit,$bal,$accNo,$tID,$date,$type,$amount";
			echo "<option value= '$allText'>$num $fname $sname</option>";
		
		}

echo "</select>";
mysqli_close($con);

?>
	


	
	