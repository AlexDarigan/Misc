<?php session_start(); ?>
<html>
<!-- Author:	Yvonne Ryan - C00263872						-->
<!-- Date:		Feb 2022									-->
<!-- Title:		openAccount.html.php 						-->
<!-- Purpose:	Open a Deposit account and update tables 	-->	
<head>
<title>Open a Deposit Account</title>
	<?php include $_SERVER['DOCUMENT_ROOT'] . "/bank/Yvonne/depositMenu.php" ?>
	<script src="fnc.js"></script>
<link rel="stylesheet" href="/bank/common/menu.css" type="text/css"/>
<link rel="stylesheet" href="/bank/common/forms.css" type="text/css"/>
</head>
	
<body>
	
<form action="openAccount.php" onsubmit="return confirmCheck()"  method="post">
	<h1>Open Deposit Account</h1>
<fieldset>
	<legend>Select Name and Customer Number</legend>
	<?php include "listbox.php" ?> <!-- listbox populates the form fields -->
	<div class="inputbox">
	<p id="display"></p>
	<p><label for="Customer_Number">Customer Number</label>
	<input type="text" name="Customer_Number" id="Customer_Number" placeholder="Customer number" readonly /> 
		<!-- readonly so the field can't be modified while still accessing the number -->
	</p></div>
	
	<div class="inputbox">	
	<p><label for="firstname">First Name</label>
	<input type="text" name="First_Name" id="First_Name" placeholder="First name"
	disabled value ="<?php if (ISSET($_SESSION['First_Name']) ) echo $_SESSION['First_Name']?>" />
		</p></div>
	    <!-- if the name is set,  echo name in from -->
	
	<div class="inputbox">
	<p><label for="surname">Surname</label>
	<input type="text" name="surname" id="Surname" placeholder="Surname"
	disabled value ="<?php if (ISSET($_SESSION['Surname']) ) echo $_SESSION['Surname']?>" />
		</p></div>
	
	<div class="inputbox">
	<p><label for="dob">Date of Birth</label>
	<input type="text" name="dob" id="Date_of_Birth" placeholder="Date of Birth" 
	disabled value ="<?php if (ISSET($_SESSION['Date_of_Birth']) ) echo $_SESSION['Date_of_Birth']?>" />
		</p></div>
	
	<div class="inputbox">
	<p><label for="Address">Address</label>
	<input type="text" name="address" id="Address" placeholder="Address"
	disabled value ="<?php if (ISSET($_SESSION['Address']) ) echo $_SESSION['Address']?>" />
		</p></div>
	
	<div class="inputbox">
	<p><label for="Balance">Deposit money to your account</label>
<input type="number" name="Balance" id="Balance" placeholder="Balance" autocomplete=off required>
		</p></div>
</fieldset>
	
	<div class="myButton">
	<input type="submit" value="Confirm Details" />
		<input type="reset" value="Clear"/>
	</div>
	</form>
	
</body>
</html>