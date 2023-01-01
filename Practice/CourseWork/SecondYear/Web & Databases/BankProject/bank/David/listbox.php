<!--
Student Name : David Darigan
Student ID	 : C00263218
Purpose: Adds all active Customers and adds their details to a listbox to be linked in other pages.
-->
<?php
include $_SERVER['DOCUMENT_ROOT'] . '/bank/common/db.inc.php';
date_default_timezone_set("UTC");

// Fetch all active customers
$customers = "SELECT * FROM Customer WHERE Deleted = 0";
if(!$result = mysqli_query($con, $customers)){
	die('Could not retrieve customer numbers ' . mysqli_error($con));
}
   
echo "<select name='listbox' id='listbox' onchange='populate()' onkeydown='populate()'>";
echo "<option value=' & & & & & & & & & '>Select Customer</option>"; // Begin empty
while($row = mysqli_fetch_array($result)) {
	// Set the option value as an ampersand (&) seperated String of values with the customer number and name as the option innerHTML.
	$customerNumber = $row['Customer_Number'];
	$firstName = $row['First_Name'];
	$surname = $row['Surname'];
	$phone = $row['Phone_Number'];
	$address = $row['Address'];
	$dob = date_create($row['Date_of_Birth']);
	$dob = date_format($dob, "Y-m-d");
	$occupation = $row['Occupation'];
	$email = $row['Email_Address'];
	$salary = $row['Salary'];
	$guarantor = $row['Guarantors_Name'];
	// Using ampersands (&) as a seperator because commas (,) are reserved for addresses
	$customerData = "$customerNumber&$firstName&$surname&$phone&$address&$dob&$occupation&$email&$salary&$guarantor";
	echo "<option value='$customerData'>$customerNumber - $firstName $surname</option>";
}
echo "</select>";

mysqli_close($con);