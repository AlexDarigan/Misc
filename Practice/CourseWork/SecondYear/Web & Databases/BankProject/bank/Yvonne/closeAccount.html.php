<html>
<!-- Author:	Yvonne Ryan - C00263872									-->
<!-- Date:		March 2022												-->
<!-- Title:		closeAccount.html.php 									-->
<!-- Purpose:	Allow user to close a Deposit account and update tables -->	
<head>
<title>Close a Deposit Account</title>
	<?php include $_SERVER['DOCUMENT_ROOT'] . "/bank/Yvonne/depositMenu.php" ?>
<link rel="stylesheet" href="/bank/common/menu.css" type="text/css"/>
<link rel="stylesheet" href="/bank/common/forms.css" type="text/css"/>
	<script src="fnc.js"></script>
</head>
	
<body>
<form action="closeAccount.php" onsubmit="return confirmClose()"  method="post" > <!-- on submit check user is sure they wish to close -->
	<p id="display"></p>
	<h1>Close Deposit Account</h1>
<fieldset>
	<legend>Select Name and Customer Number</legend>
	<?php include "closeListbox.php" ?>
	<div class="inputbox">
	<p id="display"></p>
	<p><label for="delCustNo">Customer Number</label>
	<input type="number" name="delCustNo" id="delCustNo" disabled>
	</p></div>
	
	<div class="inputbox">	
	<p><label for="delFName">First Name</label>
	<input type="text" name="delFName" id="delFName" disabled >
		</p></div>
	
	<div class="inputbox">
	<p><label for="delSName">Surname</label>
	<input type="text" name="delSName" id="delSName" disabled>
		</p></div>
	
	<div class="inputbox">
	<p><label for="delDOB">Date of Birth</label>
	<input type="date" name="delDOB" id="delDOB" disabled>
		</p></div>
		
	<div class="inputbox">
	<p><label for="delAddress">Address</label>
	<input type="text" name="delAddress" id="delAddress" disabled>
		</p></div>
	
	<div class="inputbox">
	<p><label for="delDepAccNo">Deposit Account Number</label>
	<input type="number" name="delDepAccNo" id="delDepAccNo"  disabled>
		</p></div>
</fieldset>
	
	<div class="myButton">
	<input type="submit" value="Close Account" />
	</div>
	</form>
	
</body>
</html>