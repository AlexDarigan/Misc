<!--
Student Name : David Darigan
Student ID	 : C00263218
Purpose: Records a Deposit Transaction to the transaction table, the related account transaction table and update the balance of the related account with the deposited amount.
-->
<?php
include $_SERVER['DOCUMENT_ROOT'] . "/bank/common/db.inc.php";
date_default_timezone_set('UTC');

// Formatting this string to be used in later sql queries as a part of a column name.
$accountType = str_replace(" ", "_", $_POST['accountType']);

// Generate the unique ID for this transaction
$getMaxTransactionID = "SELECT MAX(TransactionID) FROM Transaction";
if(!$result = mysqli_query($con, $getMaxTransactionID))
{
	die("Could not retreive next transaction ID because " . mysqli_error($con));
}
$row = mysqli_fetch_array($result);
$transactionID = $row[0] + 1;

// Insert this Deposit Transaction into the Transactions table
$makeDeposit = "INSERT INTO Transaction(TransactionID, Date, Type, Amount) VALUES ($transactionID, NOW(), 'Lodgement', $_POST[amount])";
if(!mysqli_query($con, $makeDeposit))
{
	die("Could not make deposit because " . mysqli_error($con));
}


// Insert this Transaction into the relevant Account_Transaction table
$joinTransaction = "INSERT INTO $accountType"."_Transaction($accountType"."_Number, TransactionID) 
					VALUES ($_POST[accountNumber], $transactionID)";
if(!mysqli_query($con, $joinTransaction))
{
	die("Could not add to $accountType "."_Transaction table because " . mysqli_error($con));
}

// Update the balance of the account
$newBalance = $_POST['amount'] + $_POST['balance'];
$updateBalance = "UPDATE $accountType SET balance = $newBalance 
				WHERE Customer_Number = $_POST[customerNumber] AND $accountType"."_Number = $_POST[accountNumber]";
if(!mysqli_query($con, $updateBalance))
{
	die("Could not update balance because " . mysqli_error($con));
}

echo $updateBalance . "<br>";

// Closing the database connection
mysqli_close($con);

// Return to the calling form
header("Location: lodgements.html.php");
?>
