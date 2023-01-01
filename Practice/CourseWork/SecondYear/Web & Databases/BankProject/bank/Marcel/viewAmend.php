<html>
<!-- Author:	Marcel Zama -->
<!-- Date:		Mar 2022	-->
<!-- Purpose:	Allow user to change overdraft limit in a Current account and update tables. -->	
<head>
<?php include $_SERVER['DOCUMENT_ROOT'] . "/bank/Marcel/currentOptions.php" ?>
<link rel="stylesheet" href="/bank/common/menu.css" type="text/css"/>
<link rel="stylesheet" href="/bank/common/forms.css" type="text/css"/>
</head>
</html>

<?php 
session_start();
include $_SERVER['DOCUMENT_ROOT'] . "/bank/common/db.inc.php";
date_default_timezone_set('UTC');
	
	$overdraftlimit = $_POST['overlimit'];
	$accnr = $_POST['accNo'];
	echo $accnr;
	echo $overdraftlimit;
	
// query to update Current Account table
$insert = "UPDATE Current_Account 
		   SET Overdraft_Limit = $overdraftlimit
		   WHERE Current_Account_Number = " . $_POST['accNo'] ;
	
if (!mysqli_query($con,$insert))
	{
		die('1 . Error in querying the database / ' . mysqli_error($con));
	}
	
	$sqlq = "SELECT * FROM Transaction WHERE TransactionID = " . $tranNo;

$r = mysqli_query($con,$sqlq);

echo '<p style="text-align: center; font-size:20">Action was registered successfully. <br><br>  </p>' ;
	
mysqli_close($con);

?>

	<br>
<form action="viewAmend.html.php" method="post">
<div class="myButton">
	<input type="submit" value="Return to Previous Page"/>
	</div>
</form>

