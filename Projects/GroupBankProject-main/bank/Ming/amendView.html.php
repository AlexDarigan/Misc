<html>
<!-- Title:		amendView.html.php				-->
<!-- Purpose:	View a Loan Account	-->	
<head>
	<title>View a Loan Account</title>
<?php include $_SERVER['DOCUMENT_ROOT'] . "/bank/Ming/LoanOption.php"?>
<link rel="stylesheet" href="/bank/common/menu.css" type="text/css"/>
<link rel="stylesheet" href="/bank/common/forms.css" type="text/css"/>
<script src="function.js"></script>
<style>
table, th, td {
  border:1px solid black;
		}
</style>
</head>
<body>
<form name="myForm" method="post">
<p id="display"></p>
	<h2>Amend/View Loan Account</h2> 
	<fieldset>
		<legend>View Account Details</legend>
		<?php include 'listbox2.php'; ?>

		<br><br>
		<div class="inputbox">
		<label for="fName">First Name:</label>
		<input type="text" name="fName" id="fName" required disabled></div><br>
			
		<div class="inputbox">
		<label for="sName">Surname:</label>
		<input type="text" name="sName" id="sName" required disabled></div><br>
		
		<div class="inputbox">
		<label for="add">Address:</label>
		<input type="text" name="add" id="add" required disabled></div><br>
		
		<div class="inputbox">
			<label for="DOB">Date of Birth:</label>
			<input type="date" name="DOB" id="DOB" required disabled></div><br>
		
		<div class="inputbox">
		<label for="custNo">Customer Number:</label>
		<input type="text" name="custNo" id="custNo" required disabled></div><br>
		
		<div class="inputbox">	
		<label for="bal">Balance:</label>
		<input type="text" name="bal" id="bal" required disabled></div><br>
			
		<div class="inputbox">  
		<label for="accNo">Loan Account Number:</label>
		<input type="number" name="accNo" id="accNo" required disabled></div><br>
	</fieldset>

	<fieldset>
		<legend>Recent Transactions</legend>
		<br>
		<table style="width:100%">
 	 <tr>
   	 	<th>Transaction ID</th>
    	<th>Date</th>
    	<th>Amount</th></tr>
	<tr>
    	<td id="tranID"></td>
		<td id="date"></td>
		<td id="amount"></td></tr>
		</table>
	</fieldset>
</form>
</body>
</html>