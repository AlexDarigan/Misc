<html>
<head>
<title>Close a Current Account</title>
	<?php include $_SERVER['DOCUMENT_ROOT'] . "/bank/Marcel/currentOptions.php" ?>
<link rel="stylesheet" href="/bank/common/menu.css" type="text/css"/>
<link rel="stylesheet" href="/bank/common/forms.css" type="text/css"/>
	<script src="functions.js"></script>
</head>
	
<body>
<form action="closeCurrentAccount.php" onsubmit="return confirmDelete()"  method="post" >
	<p id="display"></p>
	<h2>Close a Current Account</h2>
<fieldset>
	<legend>Select Name and Customer Number</legend>
	<?php include "listbox2.php" ?>
	<div class="inputbox">
	<p id="display"></p>
	<p><label for="delCustNo">Customer Number</label>
	<input type="number" name="delCustNo" id="delCustNo" disabled/>
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
	<p><label for="delCurAccNo">Current Account Number</label>
	<input type="number" name="delCurAccNo" id="delCurAccNo"  disabled>
		</p></div>
</fieldset>
	
	<div class="myButton">
	<input type="submit" value="Delete Account" />
	</div>
	</form>
	
</body>
</html>