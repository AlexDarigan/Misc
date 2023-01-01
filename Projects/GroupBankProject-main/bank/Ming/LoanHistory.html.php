<html>
<!-- Author:	Ming Kit choy 					-->
<!-- Purpose:	View a Loan Account History		-->	
<head>
	<title>Loan Account History</title>
<?php include $_SERVER['DOCUMENT_ROOT'] . "/bank/Ming/LoanOption.php"?>
<link rel="stylesheet" href="/bank/common/menu.css" type="text/css"/>
<link rel="stylesheet" href="/bank/common/forms.css" type="text/css"/>
<script src="function.js"></script>
</head>
	
<body>
<form method="post" action="LoanHistory.php" onsubmit="confirmViewHistory()">
	<h1>Loan Account History</h1>
<p id="display"></p>
	<fieldset>
			<legend>Loan Account History</legend>
	<?php include 'listbox4.php'; ?><br><br>		
<div class="inputbox">
<p><label for="custNo">Customer Number</label>
<input type="text" name="custNo" id="custNo" disabled></p></div>
	
		<div class="inputbox">
	<p><label for="fName">First Name</label>
	<input type="text" name="fName" id="fName" readonly></p></div>
	
	<div class="inputbox">
		<p><label for="sName">Surname</label>
		<input type="text" name="sName" id="sName" readonly></p></div>
		
		<div class="inputbox">
			<p><label for="DOB">Date of Birth</label>
			<input type="date" name="DOB" id="DOB" disabled></p></div>
		
		<div class="inputbox">
		<p><label for="add">Address</label>
		<input type="text" name="add" id="add" disabled></p></div>
	
		<div class="inputbox">  
		<p><label for="accNo">Loan Account Number</label>
		<input type="text" name="accNo" id="accNo" readonly></p></div></fieldset>
	
		<div class="myButton">
		<input type="submit" value="View Account History" />
		</div>
 </form>
	</body>
</html>
	