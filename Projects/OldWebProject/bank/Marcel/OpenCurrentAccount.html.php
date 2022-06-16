<?php session_start(); ?>
<html>
<!-- Author:	Marcel Zama 														-->
<!-- Date:		Mar 2022															-->
<!-- Title:		openCurrentAccount.html.php 										-->
<!-- Purpose:	Allow user to open a Current account and update tables accordingly. -->	
<head>
<title>Open a Current Account</title>
	<?php include $_SERVER['DOCUMENT_ROOT'] . "/bank/Marcel/currentOptions.php" ?>
	<script src="functions.js"></script>
<link rel="stylesheet" href="/bank/common/menu.css" type="text/css"/>
<link rel="stylesheet" href="/bank/common/forms.css" type="text/css"/>
</head>
	
<body>
	
<form action="openCurrentAccount.php" onsubmit="return confirmCheck()"  method="post">
	<h2>Open a Current Account</h2>
<fieldset>
	<legend>Select Your Name and Customer Number</legend>
	<?php include "listbox.php" ?>
	<div class="inputbox">
	<p id="display"></p>
	<p><label for="Customer_Number">Customer Number</label>
	<input type="text" name="Customer_Number" id="Customer_Number" placeholder="Customer number" readonly autocomplete=off/>
	</p></div>
	
	<div class="inputbox">	
	<p><label for="firstname">First Name</label>
	<input type="text" name="First_Name" id="First_Name" placeholder="First name"
	disabled value ="<?php if (ISSET($_SESSION['First_Name']) ) echo $_SESSION['First_Name']?>" />
		</p></div>
	
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
	 <p>
		<label for="OverdraftLimit">Overdraft Limit</label>
		<input type="number" name="Overdraft_Limit" id="Overdraft_Limit" placeholder="Overdraft Limit" autocomplete=off required/>
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