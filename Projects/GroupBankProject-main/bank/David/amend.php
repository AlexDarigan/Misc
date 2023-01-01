<!--
Student Name : David Darigan
Student ID	 : C00263218
Purpose: Updates an already existing Customer's details.
-->
<?php
include $_SERVER['DOCUMENT_ROOT'] . '/bank/common/db.inc.php';
date_default_timezone_set('UTC');
$dbDate = date("Y-m-d", strtotime($_POST['dob'])); // Match DB Date format
$update = "UPDATE Customer SET 
		   First_Name = '$_POST[firstname]',
		   Surname = '$_POST[surname]',
		   Phone_Number = '$_POST[phone]',
		   Address = '$_POST[address]',
		   Date_of_Birth = '$dbDate',
		   Occupation = '$_POST[occupation]',
		   Email_Address = '$_POST[email]',
		   Salary = '$_POST[salary]',
		   Guarantors_Name = '$_POST[gurantor]' WHERE Customer_Number = '$_POST[customerNumber]'";
	
if(!mysqli_query($con, $update)) {
	die("Could not update Customer " . $_POST["customerNumber"] . " : " . $_POST['firstname'] . " " . $_POST['surname'] . "<br>" . mysqli_error($con)); }
mysqli_close($con);
// Return to the form once the customer details have been updated
header( 'Location: amendview.html.php');
?>
