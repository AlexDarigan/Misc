<html>
<!-- Author:	Marcel Zama -->
<!-- Date:		Mar 2022	-->
<!-- Purpose:	Allow user to open a Current account and update tables. -->	
	

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
	
	$accountNo = $_POST['accNo'];
	$Balance = $_POST['bal'];
	$deleteamount= $_POST['WidAmount'];
	$newBalance = $Balance - $deleteamount;
	
// query to update Current Account table
$insert = "UPDATE Current_Account 
		   SET Balance = $newBalance
		   WHERE Current_Account_Number = " . $_POST['accNo'] ;

if (!mysqli_query($con,$insert))
	{
		die('1 . Error in querying the database / ' . mysqli_error($con));
	}

// query to generate TransactionID number
$sel = "SELECT MAX(TransactionID) 
		FROM Transaction";
	
	$res = mysqli_query($con,$sel); 	// performs the query
	$row = mysqli_fetch_array($res);
	$tranNo = $row[0];				// set account number
	$tranNo++;						// increment by one


// query to update Deposit Account Transaction Table
$dTran = "INSERT INTO Current_Account_Transaction (Current_Account_Number, TransactionID)
			VALUES ($accountNo, $tranNo)";

	if (!mysqli_query($con,$dTran))
	{
		die('2 . Error in querying the database)' . mysqli_error($con));
	}
	
//query to update Transaction Table
$tran = "INSERT INTO Transaction (TransactionID, Date, Type, Amount)
		VALUES ($tranNo, NOW(), 'Withdrawals', '$_POST[WidAmount]')"; 

	if (!mysqli_query($con,$tran))
	{
		die('3 . Error in querying the database)' . mysqli_error($con));
	}
	
$sqlq = "SELECT * FROM Transaction WHERE TransactionID = " . $tranNo;

$r = mysqli_query($con,$sqlq);


echo '<p style="text-align: center; font-size:20">Action was registered successfully. <br><br>  </p>' ;
	

mysqli_close($con);


?>

	<br>
<form action="Withdrawals.html.php" method="post">
<div class="myButton">
	<input type="submit" value="Return to Previous Page"/>
	</div>
</form>


