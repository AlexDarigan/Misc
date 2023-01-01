<!DOCTYPE HTML>
<!--
Student Name : David Darigan
Student ID	 : C00263218
Purpose: Allows the bank user to view and amend the details of existing customers.
-->
<html>
<head>
	<title>View Customer</title>
	<link rel="stylesheet" href="/bank/common/selector.css" type="text/css"/>
</head>
<script src="functions.js"></script>
<body>
<div><?php include $_SERVER['DOCUMENT_ROOT'] . "/bank/common/customerfilemaintenancemenu.html.php"?></div>
<br>
<form action="amend.php" onsubmit="confirmCheck()" method="post">
	<fieldset>
	<legend id="amendViewLegend">View Customer</legend>
				
		<p class="inputbox">
			<label>Select</label>
			<?php include "listbox.php"?>
		</p>
				
		<p class="inputbox">
			<label for="CustomerNumber">Customer ID</label>
			<input type="text" name="customerNumber" id="customerNumber" readonly/>
		</p>
			
		<p class="inputbox">
			<label for="firstname">First Name</label>
			<input type="text" name="firstname" id="firstname" placeholder="First Name" disabled/>
		</p>
				
		<p class="inputbox">
			<label for="surname">Surname</label>
			<input type="text" name="surname" id="surname" placeholder="Surname" disabled/>
		</p>
				
		<p class="inputbox">
			<label for="phone">Phone Number</label>
			<!-- Only allow phone numbers in the format of "(000)-000-0000" -->
			<input type="text" name="phone" id="phone" pattern="[(]{1}[0-9]{3}[)]{1}[--]{1}[0-9]{3}[--]{1}[0-9]{4}" 
					   placeholder="(0000)-000-0000" required title="(000)-000-0000" disabled/>
		</p>
				
		<p class="inputbox">
			<label for="address">Address</label>
			<input type="text" name="address" id="address" placeholder="Address" disabled/>
		</p>
				
		<p class="inputbox">
			<!-- Customers must be 16 or older to have a bank account -->
			<!-- This is unlikely to change but mistakes or exceptions might exist -->
			<label for="dob">Date of Birth</label>
			<input type="date" name="dob" id="dob" placeholder="dob" onblur="validateAge()" disabled/>
		</p>
				
		<p class="inputbox">
			<label for="occupation">Occupation</label>
			<input type="text" name="occupation" id="occupation" placeholder="Occupation" disabled/>
		</p>
				
		<p class="inputbox">
			<label for="email">Email</label>
			<input type="email" name="email" id="email" placeholder="Email" disabled/>
		</p>
				
		<p class="inputbox">
			<label for="salary">Salary</label>
			<input type="text" name="salary" id="salary" placeholder="Salary" pattern="[0-9]+" title="digits only" disabled/>
		</p>
				
		<p class="inputbox">
			<!-- Customers cannot be their own gurantor -->
			<label for="gurantor">Gurantor's Name</label>
			<input type="text" name="gurantor" id="gurantor" placeholder="Gurantor's Name" onblur="confirmGurantor()" disabled/>
		</p>
		
		<input type="button" value = "Amend Details" id="amendViewButton" onclick="toggleLock()"/>
		<input type="submit" value="Save Changes" id="savechanges" disabled/>
	
	</fieldset>
</form>
</body>
</html>

