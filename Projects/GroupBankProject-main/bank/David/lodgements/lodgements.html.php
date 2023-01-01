<!DOCTYPE HTML>
<!--
Student Name : David Darigan
Student ID	 : C00263218
Purpose: Allows the Bank User to make a deposit to any open account.
-->
<?php session_start(); ?>
<html>
<head><title>Lodgements</title>
</head>

<body>
<div><?php include $_SERVER['DOCUMENT_ROOT'] . "/bank/common/menu.html.php"?></div>
<br>
<form name="account" action="lodgements.php" method="post" onsubmit="return confirm('Are you sure you wish to make this deposit?')">
<br>
<fieldset>
<legend>Make Lodgement</legend>
	
	<p class="inputbox">
		<label>Select Account</label>
		<?php include "viewAccounts.php"?>
	</p>
	
	<p class="inputbox">
		<label for="customerNumber">Customer Number</label>
		<input text id="customerNumber" name="customerNumber" readonly>
	</p>
	
	<p class="inputbox">
		<label for="firstName">First Name</label>
		<input text id="firstName" name="firstName" readonly>
	</p>
	
	<p class="inputbox">
		<label for="surname">Surname</label>
		<input text id="surname" name="surname" readonly>
	</p>
	
	<p class="inputbox">
		<label for="accountNumber">Account Number</label>
		<input type="text" id="accountNumber" name="accountNumber" readonly>
	</p>
	
	<p class="inputbox">
		<label for="accountType">Account Type</label>
		<input type="text" id="accountType" name="accountType" readonly>
	</p>
	
	<p class="inputbox">
		<label for="balance">Balance</label>
		<input type="text" id="balance" name="balance" readonly>
	</p>
	
	<p class="inputbox">
		<label for="status">Status</label>
		<input type="text" id="status" name="status" readonly>
	</p>
	
	<p class="inputbox">
		<label for="amount">Deposit</label>
		<input type="text" id="amount" name="amount" pattern="[0-9]{0,4}[.]{1}[0-9]{2}" 
			   title="Format is up to 4 whole digits with up to 2 decimal places" placeholder="0000.00"
			   required onblur="validateAmount()">
	</p>
	
	<br>
	<input type="submit" value="Make Lodgement" id="submit" disabled>
	</fieldset>
</form>
</body>
	
<script>function populateAccount()
{
	var sel = document.getElementById("listbox");
	var result;
	result = sel.options[sel.selectedIndex].value;
	var accountDetails = result.split("&");
	if(accountDetails[0] == "") {
		document.getElementById("customerNumber").value = "";
		document.getElementById("firstName").value = "";
		document.getElementById("surname").value = "";
		document.getElementById("accountNumber").value = "";
		document.getElementById("accountType").value = "";
		document.getElementById("balance").value = "";
		document.getElementById("status").value = "";
		document.getElementById("submit").disabled = true;
		return;
	} 
	document.getElementById("customerNumber").value = accountDetails[0];
	document.getElementById("firstName").value = accountDetails[1];
	document.getElementById("surname").value = accountDetails[2];
	document.getElementById("accountNumber").value = accountDetails[3];
	document.getElementById("accountType").value = accountDetails[4];
	document.getElementById("balance").value = accountDetails[5];
	var status = accountDetails[6];
	var statusString = "";
	if(status == 0)
	{
		statusString = 'Open';
		document.getElementById("submit").disabled = false;

	} else {
		statusString = 'Closed';
		document.getElementById("submit").disabled = true;
	}
	document.getElementById("status").value = statusString;
}
	
function validateAmount()
{
	if(parseFloat(document.getElementById("amount").value) < 1)
	{
	   	alert("You must at least deposit 1.00");
		document.getElementById("amount").value = "";
	}
}
</script>
</html>