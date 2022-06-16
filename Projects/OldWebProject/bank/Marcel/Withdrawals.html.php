 <html>
<!-- Author:	Marcel Zama -->
<!-- Date:		March 2022	-->
<!-- Purpose:	Withdrawals -->	
<head>
	<title>View Current Account</title>
<?php include $_SERVER['DOCUMENT_ROOT'] . "/bank/Marcel/currentOptions.php"?>
<link rel="stylesheet" href="/bank/common/menu.css" type="text/css"/>
<link rel="stylesheet" href="/bank/common/forms.css" type="text/css"/>
<script src="functions.js"></script>
	
	<style>
table, th, td {
  border:1px solid black;
		}
	</style>
</head>
	
<body>
	<form action="Withdrawals.php" onsubmit="return confirmCheck2()"  method="post" >
<p id="display"></p>
			<h2>Withdrawals</h2>
	<fieldset>
			<legend>Withdrawals</legend>
	<?php include 'listbox4.php'; ?>
		<br><br>
		<div class="inputbox">
	<label for="fName">First Name</label>
	<input type="text" name="fName" id="fName" required disabled>
		</div>
		<br>
		
	<div class="inputbox">
		<label for="sName">Surname</label>
		<input type="text" name="sName" id="sName" required disabled>
		</div>
		<br>
		
	<div class="inputbox">
		<label for="add">Address</label>
		<input type="text" name="add" id="add" required disabled>
		</div>
		<br>
		
		<div class="inputbox">
			<label for="DOB">Date of Birth</label>
			<input type="date" name="DOB" id="DOB" required disabled>
		</div>
	<br>
<div class="inputbox">
<label for="custNo">Customer Number</label>
		   <input type="text" name="custNo" id="custNo" required disabled>
	</div>
	<br>
		
	<div class="inputbox">	
<label for="bal">Balance</label>
		<input type="text" name="bal" id="bal" required disabled>
	</div>
	<br>
			<div class="inputbox">  
<label for="accNo">Current Account Number</label>
<input type="number" name="accNo" id="accNo" required disabled>
	</div>
		<br>
	</fieldset>
	
	<fieldset>
		<div class="inputbox">  
		<label for="WidAmount">Withdrawal ammount</label>
		<input type="number" name="WidAmount" id="WidAmount" required>
		</div>
	</fieldset>
	
	<div class="myButton">
	<input type="submit" value="Submit" />
	</div>

				 </form>

	</body>
	</html>