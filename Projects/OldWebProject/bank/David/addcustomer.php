<!--
Student Name : David Darigan
Student ID	 : C00263218
Purpose: Generates a unique Customer Number and then adds the new customer with that number to the Customer table.
-->
<html>
<?php
include $_SERVER['DOCUMENT_ROOT'] . '/bank/common/db.inc.php';
date_default_timezone_set("UTC");

// Finding the current highest Customer Number and then incrementing it by 1 to use for the next Customer.
// We set it to a default of 1 if nothing was returned (as in there are no customers yet)
$getMaxCustomerNumber = "SELECT MAX(Customer_Number) FROM Customer";
if(!$result = mysqli_query($con, $getMaxCustomerNumber))
{
	die("Could not retreive max customer number from Customers due to error: " . mysqli_error());
}

$row = mysqli_fetch_array($result);
$nextCustomerNumber = $row[0] + 1;


// Inserting the new Customer into the Customer table with the new unique Customer_Number generated earier
$insertSql = "INSERT into Customer (Customer_Number, First_Name, Surname, Phone_Number, Address, Date_of_Birth, Occupation, Email_Address, Salary, Guarantors_Name) VALUES ($nextCustomerNumber, '$_POST[firstname]', '$_POST[surname]', '$_POST[phone]', '$_POST[address]', '$_POST[dob]', '$_POST[occupation]', '$_POST[email]', '$_POST[salary]', '$_POST[gurantor]')";

if(!mysqli_query($con, $insertSql))
{
	die("Could not add a new customer to the database: " . mysqli_error($con));
}

mysqli_close($con);
?>
	<!-- Displays a summary of details of the newly added Customer -->
	<head>
		<title>New Customer Summary</title>
		<link rel="stylesheet" href="/bank/common/forms.css" type="text/css"/>
		<link rel="stylesheet" href="/bank/common/body.css" type="text/css"/>
	</head>
	<body>
		<br>
		<form action="addcustomer.html.php">
			<fieldset>
				<legend>Customer Summary</legend>
				<p class="inputbox"><label>Customer Number</label><input disabled value="<?php echo $nextCustomerNumber; ?>"/></p>
				<p class="inputbox"><label>First Name</label><input disabled value="<?php echo $_POST[firstname]; ?>"/></p>
				<p class="inputbox"><label>Surname</label><input disabled value="<?php echo $_POST[surname]; ?>"/></p>
				<p class="inputbox"><label>Phone Number</label><input disabled value="<?php echo $_POST[phone]; ?>"/></p>
				<p class="inputbox"><label>Address</label><input disabled value="<?php echo $_POST[address]; ?>"/></p>
				<p class="inputbox"><label>Date of Birth</label><input disabled value="<?php echo $_POST[dob]; ?>"/></p>
				<p class="inputbox"><label>Occupation</label><input disabled value="<?php echo $_POST[occupation]; ?>"/></p>
				<p class="inputbox"><label>Email</label><input disabled value="<?php echo $_POST[email]; ?>"/></p>
				<p class="inputbox"><label>Salary</label><input disabled value="<?php echo $_POST[salary]; ?>"/></p>
				<p class="inputbox"><label>Gurantor's Name</label><input disabled value="<?php echo $_POST[gurantor]; ?>"/></p>
				<input type="submit" value="Return to previous page"/>
				
			</fieldset>
		</form>
	</body>
</html>