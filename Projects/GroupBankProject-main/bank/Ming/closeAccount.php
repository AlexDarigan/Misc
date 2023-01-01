<html>
<head>
<?php include $_SERVER['DOCUMENT_ROOT'] . "/bank/Ming/LoanOption.php" ?>
<link rel="stylesheet" href="/bank/common/menu.css" type="text/css"/>
<link rel="stylesheet" href="/bank/common/forms.css" type="text/css"/>
</head>
</html>
<?php 
session_start();
include $_SERVER['DOCUMENT_ROOT'] . "/bank/common/db.inc.php";
date_default_timezone_set('UTC');

$sel = "SELECT Balance FROM Loan_Account 
		WHERE Balance = 0
		AND Loan_Account_Number = " . $_POST['delLoanAccNo'] ;
	
if (!$result = mysqli_query($con,$sel))		// if problem connecting display error message
	{
		die('Error in querying the database)' . mysqli_error($con));
	}
$rowcount = mysqli_affected_rows($con);
if ($rowcount == 1) // if a result has been found where Balance = 0, run the next query to close account
	{
		//query to set account to Closed 
		$sql = "UPDATE Loan_Account 
				SET Closed = 1
				WHERE Loan_Account_Number = " . $_POST['delLoanAccNo'] ;
			if (!$result = mysqli_query($con,$sql))		// if problem connecting display error message
				{
					die('Error in querying the database)' . mysqli_error($con));
				}
			else
				{
					echo "<br>" . '<p style="text-align: center; font-size:18">Loan Account has been closed. </p>';
				}
	}
else if ($rowcount == 0)
	{
		echo "<br>" . '<p style="text-align: center; font-size:18"> Unable to delete Loan Account until balance is clear </p>';
		echo "<br>" . '<p style="text-align: center; font-size:18"> Please make sure the Loan Belance is clear and try again. </p>';
	}
mysqli_close($con);
?>
	<br>
<form action="closeAccount.html.php" method="post">
<div class="myButton">
	<input type="submit" value="Return to Previous Page"/>
	</div>
</form>