<!DOCTYPE HTML>
<!--
Student Name : David Darigan
Student ID	 : C00263218
Purpose: Allows the bank user to enter and validate the details of a new customer to be added to the customer table of the bank database.
-->
<html>
<head><title>Add New Customer</title></head>
<script src="functions.js"></script>
<body>
<div><?php include $_SERVER['DOCUMENT_ROOT'] . "/bank/common/customerfilemaintenancemenu.html.php"?></div>
<br>
<form action="addcustomer.php" onsubmit="return confirm('Are you sure you want to add this Customer?')" method="post">
	<fieldset>
	<legend>Add New Customer</legend>
				
		<p class="inputbox">
			<label for="firstname">First Name</label>
			<input type="text" name="firstname" id="firstname" placeholder="First Name" required/>
		</p>
				
		<p class="inputbox">
			<label for="surname">Surname</label>
			<input type="text" name="surname" id="surname" placeholder="Surname" required/>
		</p>
				
		<p class="inputbox">
			<label for="phone">Phone Number</label>
			<!-- Only allow phone numbers in the format of "(000)-000-0000" -->
			<input type="text" name="phone" id="phone" pattern="[(]{1}[0-9]{3}[)]{1}[--]{1}[0-9]{3}[--]{1}[0-9]{4}" 
				   placeholder="(000)-000-0000" required title="(000)-000-0000"/>
		</p>
				
		<p class="inputbox">
			<label for="address">Address</label>
			<input type="text" name="address" id="address" placeholder="Address" required/>
		</p>
					
		<p class="inputbox">
			<label for="dob">Date of Birth</label>
			<!-- Customers must be 16 or older to have a bank account -->
			<input type="date" name="dob" id="dob" placeholder="dob" onblur="validateAge()" required/>
		</p>
				
		<p class="inputbox">
			<label for="occupation">Occupation</label>
			<input type="text" name="occupation" id="occupation" placeholder="Occupation" 
					required pattern="[a-zA-Z ]+" title="Letters and spaces only"/>
		</p>
				
		<p class="inputbox">
			<label for="email">Email</label>
			<input type="email" name="email" id="email" placeholder="Email" required/>
		</p>
				
		<p class="inputbox">
			<label for="salary">Salary</label>
			<input type="text" name="salary" id="salary" placeholder="Salary" required pattern="[0-9]+" title="Digits only"/>
		</p>
				
		<p class="inputbox">
			<label for="gurantor">Gurantor's Name</label>
			<!-- Customers cannot be their own gurantor -->
			<input type="text" name="gurantor" id="gurantor" placeholder="Gurantor's Name" onblur="confirmGurantor()"/>
		</p>
				
		<input type="submit" value="Add New Customer"/>		
	</fieldset>
</form>
</body>
</html>