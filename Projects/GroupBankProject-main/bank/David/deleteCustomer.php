<!--
Student Name : David Darigan
Student ID	 : C00263218
Purpose: Flags a customer for deletion in the Customer table, if the customer has no open accounts.
-->
<?php
session_start();
include $_SERVER['DOCUMENT_ROOT'] . '/bank/common/db.inc.php';
date_default_timezone_set('UTC');

// Check for Current Account
// Check for Deposit Account
// Check for Loan Account
$customerNumber = $_POST[customerNumber];
$fname = $_POST[firstname];
$sname = $_POST[surname];

// Checking to see if the user has any account and if so if that account is closed (0 meaning 'not closed');
$queries['deposit account'] = "SELECT * FROM Loan_Account WHERE Customer_Number = $customerNumber AND Closed = 0";
$queries['current account'] = "SELECT * FROM Deposit_Account WHERE Customer_Number = $customerNumber AND Closed = 0";
$queries['loan account'] = "SELECT * FROM Current_Account WHERE Customer_Number = $customerNumber AND Closed = 0";

// Run each query seperately and check if they still have an open account
foreach($queries as $account_type => $query) {
	if(!mysqli_query($con, $query)) {
		die(mysqli_error($con));
	}
	if(mysqli_affected_rows($con) > 0){
		// On the first open account found, set a session variable to display which account was still open
		$_SESSION["ResultMessage"] = "Could not delete customer " . $fname . " " . $sname . " because they have an open $account_type.";
		mysqli_close($con);
		// Return to the calling form and inform the user that the customer still has an open account
		header( 'Location: deleteCustomer.html.php');
	}
}

// The customer has no open accounts if this is reached, therefore their DeletedFlag is set to 1 for 'true';
$update = "UPDATE Customer SET Deleted = 1 WHERE Customer_Number = $customerNumber";

if(!mysqli_query($con, $update)) 
{
	die(); 
	$_SESSION["ResultMessage"] = "Could not delete customer : " . $fname . " " . $sname . "due to error: " . mysqli_error($con);

}
else
{
	$_SESSION["ResultMessage"] = "Deleted customer : " . $fname . " " . $sname;
}
mysqli_close($con);

// Return to the calling form and display the ResultMessage session variable
header( 'Location: deleteCustomer.html.php');
?>
