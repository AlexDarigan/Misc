<html>
<!-- Author:	Yvonne Ryan - C00263872								-->
<!-- Date:		Feb 2022											-->
<!-- Title:		View.html.php										-->
<!-- Purpose:	View a Deposit Account and view recent transaction	-->	
<head>
	<title>View a Deposit Account</title>
<?php include $_SERVER['DOCUMENT_ROOT'] . "/bank/Yvonne/depositMenu.php"?>
<link rel="stylesheet" href="/bank/common/menu.css" type="text/css"/>
<link rel="stylesheet" href="/bank/common/forms.css" type="text/css"/>

<script src="fnc.js"></script>	
</head>
	
<body>
<form name="myForm" action="view.php" method="post">
	<h1>View Deposit Account</h1>
<p id="display"></p>
	<fieldset>
			<legend>View Account Details</legend>
	<?php include 'viewListbox.php'; ?>  <!-- listbox populates the form fields -->

		<br><br>
		<div class="inputbox">
	<label for="fName">First Name</label>
	<input type="text" name="fName" id="fName" disabled> 	
		</div>
		<br>
		
	<div class="inputbox">
		<label for="sName">Surname</label>
		<input type="text" name="sName" id="sName" disabled>
		</div>
		<br>
		
	<div class="inputbox">
		<label for="add">Address</label>
		<input type="text" name="add" id="add" disabled>
		</div>
		<br>
		
		<div class="inputbox">
			<label for="DOB">Date of Birth</label>
			<input type="date" name="DOB" id="DOB" disabled>
		</div>
	<br>
<div class="inputbox">
<label for="custNo">Customer Number</label>
		   <input type="text" name="custNo" id="custNo" disabled>
	</div>
	<br>
		
	<div class="inputbox">	
<label for="bal">Balance</label>
		<input type="text" name="bal" id="bal" disabled>
	</div>
	<br>
			<div class="inputbox">  
<label for="accNo">Deposit Account Number</label>
<input type="text" name="accNo" id="accNo" readonly>
	<!-- readonly so the field can't be modifie but the number can be accsessed -->
	</div>
		<br>
	</fieldset>
	<div class="myButton">
		<input type="submit" value="View Recent Transactions">
	</div>
	</form>

	</body>
	</html>
	