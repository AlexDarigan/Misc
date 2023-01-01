<!DOCTYPE HTML>
<!--
Student Name : David Darigan
Student ID	 : C00263218
Purpose: Allows the bank user to flag a customer for deletion. The customer will still exist in the table but won't show up when processing active customers.
-->
<?php session_start(); ?>
<html>
<head>
<title>Delete Customer</title>
<link rel="stylesheet" href="/bank/common/selector.css" type="text/css"/>
</head>
<script src="functions.js"></script>
<body>
<div><?php include $_SERVER['DOCUMENT_ROOT'] . "/bank/common/customerfilemaintenancemenu.html.php"?></div>

<?php 
	// Display wheter the deletion was successful or not (and if so why not)
	if(ISSET($_SESSION['ResultMessage'])) { echo '<script>alert("'.$_SESSION['ResultMessage'].'");</script>'; }
	session_destroy();
?>
		
<form action="deleteCustomer.php" onsubmit="confirm('Are you sure you wish to delete this Customer?')" method="post">
<br>
	<fieldset>
	<legend>Delete Customer</legend>
				
		<p class="inputbox">
			<label for="CustomerID">Select</label>
			<?php include "listbox.php"?>
		</p>
				
		<p class="inputbox">
			<label for="CustomerNumber">Customer ID</label>
			<input type="text" name="customerNumber" id="customerNumber" readonly/>
		</p>
			
		<p class="inputbox">
			<label for="firstname">First Name</label>
			<input type="text" name="firstname" id="firstname" placeholder="First Name" readonly/>
		</p>
				
		<p class="inputbox">
			<label for="surname">Surname</label>
			<input type="text" name="surname" id="surname" placeholder="Surname" readonly/>
		</p>
				
		<p class="inputbox">
			<label for="phone">Phone Number</label>
			<input type="text" name="phone" id="phone" placeholder="Phone Number" pattern="[0-9]+" readonly/>
		</p>
				
		<p class="inputbox">
			<label for="address">Address</label>
			<input type="text" name="address" id="address" placeholder="Address" readonly/>
		</p>
				
		<p class="inputbox">
			<label for="dob">Date of Birth</label>
			<input type="date" name="dob" id="dob" placeholder="dob" readonly/>
		</p>
				
		<p class="inputbox">
			<label for="occupation">Occupation</label>
			<input type="text" name="occupation" id="occupation" placeholder="Occupation" readonly/>
		</p>
				
		<p class="inputbox">
			<label for="email">Email</label>
			<input type="email" name="email" id="email" placeholder="Email" readonly/>
		</p>
				
		<p class="inputbox">
			<label for="salary">Salary</label>
			<input type="text" name="salary" id="salary" placeholder="Salary" readonly/>
		</p>
				
		<p class="inputbox">
			<label for="gurantor">Gurantor's Name</label>
			<input type="text" name="gurantor" id="gurantor" placeholder="Gurantor's Name" readonly/>
		</p>
				
		<input type="submit" value="Delete Customer" id="deleteCustomer"/>
	
	</fieldset>
</form>
</body>
</html>