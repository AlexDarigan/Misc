<html>
<!-- Author:	Marcel Zama -->
<!-- Date:		Mar 2022	-->
<!-- Purpose:	Allow user to open a Current account and update tables. -->	
	
		<style>
table, th, td {
  border:1px solid black;
		}
	</style>
	
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

//query to find max Current account number 
$sql = "SELECT MAX(Current_Account_Number) 
		FROM Current_Account";

	$result = mysqli_query($con,$sql); 	// performs the query
	$row = mysqli_fetch_array($result);
	$accountNo = $row[0];				// set account number
	$accountNo++;						// increment by one
		
// query to update Current Account table
$insert = "INSERT INTO Current_Account (Current_Account_Number,Balance,Overdraft_Limit,Customer_Number,Closed)
			VALUES ('$accountNo','$_POST[Balance]','$_POST[Overdraft_Limit]','$_POST[Customer_Number]','0')"; 

if (!mysqli_query($con,$insert))
	{
		die('Error in querying the database)' . mysqli_error($con));
	}

// query to generate TransactionID number
$sel = "SELECT MAX(TransactionID) 
		FROM Transaction";
	
	$res = mysqli_query($con,$sel); 	// performs the query
	$row = mysqli_fetch_array($res);
	$tranNo = $row[0];				// set account number
	$tranNo++;						// increment by one


// query to update Current Account Transaction Table
$dTran = "INSERT INTO Current_Account_Transaction (Current_Account_Number, TransactionID)
			VALUES ($accountNo, $tranNo)";

	if (!mysqli_query($con,$dTran))
	{
		die('Error in querying the database)' . mysqli_error($con));
	}
	
//query to update Transaction Table
$tran = "INSERT INTO Transaction (TransactionID, Date, Type, Amount)
		VALUES ($tranNo, NOW(), 'Lodgement', '$_POST[Balance]')"; 

	if (!mysqli_query($con,$tran))
	{
		die('Error in querying the database)' . mysqli_error($con));
	}
	
$sqlq = "SELECT * FROM Transaction WHERE TransactionID = " . $tranNo;

$r = mysqli_query($con,$sqlq);

echo '<p style="text-align: center; font-size:20">Current Account has been successfully created. <br><br>  </p>' ;

mysqli_close($con);


?>

	<br>
<form action="OpenCurrentAccount.html.php" method="post">
<div class="myButton">
	<input type="submit" value="Return to Previous Page"/>
	</div>
</form>

