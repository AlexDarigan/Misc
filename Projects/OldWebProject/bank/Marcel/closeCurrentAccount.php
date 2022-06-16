<html>
<!-- Author:	Marcel Zama -->
<!-- Date:		Mar 2022	-->
<!-- Purpose:	Allow user to close a Current account and update tables. -->	
<head>
<?php include $_SERVER['DOCUMENT_ROOT'] . "/bank/Marcel/currentOptions.php" ?>
<link rel="stylesheet" href="/bank/common/menu.css" type="text/css"/>
<link rel="stylesheet" href="/bank/common/forms.css" type="text/css"/>
</head>


<?php 
session_start();
include $_SERVER['DOCUMENT_ROOT'] . "/bank/common/db.inc.php";
date_default_timezone_set('UTC');

$sel = "SELECT Balance FROM Current_Account 
		WHERE Balance = 0
		AND Current_Account_Number = " . $_POST['delDepAccNo'] ;

if (!$result = mysqli_query($con,$sel))		// if problem connecting display error message
	{
		die('Error in querying the database)1' . mysqli_error($con));
	}

$rowcount = mysqli_affected_rows($con);
	
if ($rowcount == 1) // if a result has been found where Balance = 0, run the next query to close account
	{
		//query to set account to Closed 
		$sql = "UPDATE Current_Account 
				SET Closed = 1
				WHERE Current_Account_Number = " . $_POST['delDepAccNo'] ;
	
			if (!$result = mysqli_query($con,$sql))		// if problem connecting display error message
				{
					die('Error in querying the database)' . mysqli_error($con));
				}
			else
				{
					echo "<br>" . '<p style="text-align: center; font-size:18">Current Account has been closed. </p>';
				}
	}

else if ($rowcount == 0)
	{
		echo "<br>" . '<p style="text-align: center; font-size:18"> Current Account cannot be closed until remaining balance is 					withdrawn. </p>';
		echo "<br>" . '<p style="text-align: center; font-size:18"> Please withdraw funds and try again. </p>';
	
	}

mysqli_close($con);
	
?>
	<br>
		<form action="closeCurrentAccount.html.php" method="post">
<div class="myButton">
	<input type="submit" value="Return to Previous Page"/>
	</div>
	</form
		</html>
