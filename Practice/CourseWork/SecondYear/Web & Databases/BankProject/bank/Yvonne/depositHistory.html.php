<html>
<!-- Author:	Yvonne Ryan - C00263872			-->
<!-- Date:		March 2022						-->
<!-- Title:		depositHistory.html.php			-->
<!-- Purpose:	View a Deposit Account History	-->	
<head>
	<title>Deposit Account History</title>
<?php include $_SERVER['DOCUMENT_ROOT'] . "/bank/Yvonne/depositMenu.php"?>
<link rel="stylesheet" href="/bank/common/menu.css" type="text/css"/>
<link rel="stylesheet" href="/bank/common/forms.css" type="text/css"/>
<script src="fnc.js"></script>
</head>
	
<body>
<form method="post" action="depositHistory.php" onsubmit="confirmViewHistory()">  <!-- once form is submitted confirm message appears -->
	<h1>Deposit Account History</h1>
<p id="display"></p>
	<fieldset>
			<legend>View Account History</legend>
	<?php include 'historyListbox.php'; ?>   <!-- the listbox populates the form fields -->
		<br><br>	
		
<div class="inputbox">
<p><label for="custNo">Customer Number</label>
		   <input type="text" name="custNo" id="custNo" disabled>
	</p></div>
	
		<div class="inputbox">
	<p><label for="fName">First Name</label>
	<input type="text" name="fName" id="fName" readonly>
		<!-- readonly so the field cannot be modified but name can still be accessed -->
			</p></div>
	
	<div class="inputbox">
		<p><label for="sName">Surname</label>
		<input type="text" name="sName" id="sName" readonly>
		</p></div>
		
		<div class="inputbox">
			<p><label for="DOB">Date of Birth</label>
			<input type="date" name="DOB" id="DOB" disabled>
			</p></div>
		
	<div class="inputbox">
		<p><label for="add">Address</label>
		<input type="text" name="add" id="add" disabled>
		</p></div>
	
			<div class="inputbox">  
<p><label for="accNo">Deposit Account Number</label>
<input type="text" name="accNo" id="accNo" readonly> 
<!-- readonly so the field cannot be modified but number can still be accessed -->
				</p></div>

	</fieldset>
	
	<div class="myButton">
		<input type="submit" value="View Account History" />
	</div>
 </form>
	</body>
	</html>
	