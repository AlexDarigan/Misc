<html>
<!-- Author:	Marcel Zama -->
<!-- Date:		March 2022	-->
<!-- Purpose:	Amend/View a Current Account -->	
<head>
	<title>View/Amend Current Account</title>
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
<form action="viewAmend.php" onsubmit="return confirmCheck3()" name="myForm" method="post">
<p id="display"></p>
	<h2>View/Ammend Account</h2>
	<fieldset>
			<legend>View Account Details</legend>
	<?php include 'listbox3.php'; ?>
<input type="button" value="Amend Details" id="amendViewButton" onclick="toggleLock()">
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
		<label for="overlimit">Overdraft Limit</label>
		<input type="text" name="overlimit" id="overlimit" required >
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
	
	
	<div class="myButton">
	<input type="submit" value="Submit" />
	</div>
	
	
	<fieldset>
		<legend>Recent Transactions</legend>
		<br>
	<table style="width:100%">
  <tr>
    <th>Transaction ID</th>
    <th>Date</th>
	<th>Type</th>
    <th>Amount</th>
  </tr>
			<tr>
    <td id="tranID"></td>
	<td id="date"></td>
	<td id="type"></td>
	<td id="amount"></td>
   
  </tr>
		</table>
</fieldset>
				 </form>

	</body>
	</html>
	