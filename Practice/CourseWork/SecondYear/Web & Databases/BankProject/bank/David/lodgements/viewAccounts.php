<!--
Student Name : David Darigan
Student ID	 : C00263218
Purpose: Creates a list box of all accounts (both open and closed)
-->
<?php
include $_SERVER['DOCUMENT_ROOT'] . '/bank/common/db.inc.php';

function getAccounts($type, $connection)
{
	$number = $type . "_Number";
	$balance = $type . ".Balance";
	$isClosed = $type . ".Closed";
	$onJoin	= $type . ".Customer_Number = Customer.Customer_Number";
	
	$sql = "SELECT Customer.Customer_Number, First_Name, Surname, $number, $balance, $isClosed 
			FROM Customer INNER JOIN $type ON $onJoin
			WHERE Customer.Deleted = 0";
			
	if(!$result = mysqli_query($connection, $sql))
	{
		die('Could not retreieve customer accounts ' . mysqli_error($connection));
	}
			
	$accounts = array();
	while($row = mysqli_fetch_array($result))
	{
		$accounts[] = array(
			"Customer Number" => $row["Customer_Number"],			
			"First Name" => $row["First_Name"],
			"Surname" => $row["Surname"],
			"Account Number" => $row[$number],
			"Account Type" => str_replace("_", " ", $type),
			"Balance" => $row["Balance"],
			"Closed" => $row["Closed"],
		);
		
	}
	
	return $accounts;
}
			
// Make a query per account type, and merge all results together as one array
$accounts = array_merge(getAccounts("Deposit_Account", $con), getAccounts("Current_Account", $con), getAccounts("Loan_Account", $con));


echo "<select name='listbox' id='listbox' onclick='populateAccount()'>";
echo "<option value= & & & & & & '>Select Account</option>";
// Iterate through the accounts array and store the values as an & seperated String as part of the listbox value per account option.
foreach($accounts as $account)
{
	$custNo = $account['Customer Number'];
	$fname = $account['First Name'];
	$sname = $account['Surname'];
	$accNo = $account['Account Number'];
	$accType = $account['Account Type'];
	$bal = $account['Balance'];
	$status = $account['Closed'];
	$data = "$custNo&$fname&$sname&$accNo&$accType&$bal&$status";
	echo "<option value='$data'>$accNo - $accType </option>";
}
echo "</select>";


mysqli_close($con);