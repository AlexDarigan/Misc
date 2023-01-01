<html>
<!-- Author:	Yvonne Ryan - C00263872									-->
<!-- Date:		Feb 2022												-->
<!-- Title:		openAccount.php											-->
<!-- Purpose:	Open a Deposit account and update tables				-->	
	
<head>
<?php include $_SERVER['DOCUMENT_ROOT'] . "/bank/Yvonne/depositMenu.php" ?>
<link rel="stylesheet" href="/bank/common/menu.css" type="text/css"/>
<link rel="stylesheet" href="/bank/common/forms.css" type="text/css"/>
</head>

<?php 
session_start();
include $_SERVER['DOCUMENT_ROOT'] . "/bank/common/db.inc.php";
date_default_timezone_set('UTC');

//query to find max deposit account number 
$sql = "SELECT MAX(Deposit_Account_Number) 
		FROM Deposit_Account";

	$result = mysqli_query($con,$sql); 	// performs the query
	$row = mysqli_fetch_array($result);
	$accountNo = $row[0];				// set account number
	$accountNo++;						// increment by one
		
	
// query to update Deposit Account table
$insert = "INSERT INTO Deposit_Account (Deposit_Account_Number,Balance,Customer_Number,Closed)
			VALUES ('$accountNo','$_POST[Balance]','$_POST[Customer_Number]','0')"; 

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


	
// query to update Deposit Account Transaction Table
$dTran = "INSERT INTO Deposit_Account_Transaction (Deposit_Account_Number, TransactionID)
			VALUES ($accountNo, $tranNo)";

	if (!mysqli_query($con,$dTran))
	{
		die('Error in querying the database)' . mysqli_error($con));
	}
	
	
//query to update Transaction Table
$tran = "INSERT INTO Transaction (TransactionID, Date, Type, Amount)	
		VALUES ($tranNo, NOW(), 'Lodgement', '$_POST[Balance]')"; 
						// NOW() function returns the current date and time
	
	if (!mysqli_query($con,$tran))
	{
		die('Error in querying the database)' . mysqli_error($con));
	}
	
	
$sqlq = "SELECT * FROM Transaction WHERE TransactionID = " . $tranNo;

$r = mysqli_query($con,$sqlq);

echo "<br><br>" .'<p style="text-align: center; font-size:20">Deposit Account has been created. Your account number is: '.$accountNo.'  </p>' ;
	
$sqlq = "SELECT * FROM Transaction WHERE TransactionID = " . $tranNo;

$r = mysqli_query($con,$sqlq);
	
$rowcount = mysqli_affected_rows($con);

if($rowcount ==1)
	{
		$row = mysqli_fetch_array($r);
	
		echo "<br>" . '<p style="text-align: center; font-size:18"> TransactionID: </p>';
		echo '<p style="text-align: center; font-size:18"> '.$row['TransactionID'].' </p>' . "<br>";
		echo '<p style="text-align: center; font-size:18"> Transaction Date: </p>';
		echo '<p style="text-align: center; font-size:18"> '.$row['Date'].' </p>' . "<br>";
		echo '<p style="text-align: center; font-size:18">Amount: </p>';
		echo '<p style="text-align: center; font-size:18"> '.$row['Amount'].' </p>' . "<br>";
	
	}


mysqli_close($con);


?>

	<br>
<form action="openAccount.html.php" method="post">
<div class="myButton">
	<input type="submit" value="Return to Open Account"/>
	</div>
</form></html>

