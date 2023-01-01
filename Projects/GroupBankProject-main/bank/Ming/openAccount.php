<html>
<!-- Author:	Ming Kit Choy -->
<!-- Date:		Mar 2022	-->
<!-- Purpose:	Allow user to open a Loan account and update tables. -->		
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

//query to find max loan account number 
$sql = "SELECT MAX(Loan_Account_Number) 
		FROM Loan_Account";
	$result = mysqli_query($con,$sql); 	// performs the query
	$row = mysqli_fetch_array($result);
	$accountNo = $row[0];				// set account number
	$accountNo++;						// increment by one
	
// query to update Loan Account table
$insert = "INSERT INTO Loan_Account(Loan_Account_Number,Balance,Term,Monthly_repayments,Customer_Number,Closed)
			VALUES ('$accountNo','$_POST[Balance]','$_POST[Term]','$_POST[Monthly_repayments]','$_POST[Customer_Number]','0')"; 
if (!mysqli_query($con,$insert))
	{
		die('Error in querying the database)' . mysqli_error($con));
	}
	
// query to generate TransactionID number
$sel = "SELECT MAX(TransactionID) 
        FROM Transaction";
    $res = mysqli_query($con,$sel);     // performs the query
    $row = mysqli_fetch_array($res);
    $tranNo = $row[0];                // set account number
    $tranNo++;                        // increment by one
	
// query to update Loan Account Transaction Table
$dTran = "INSERT INTO Loan_Account_Transaction (Loan_Account_Number, TransactionID)
			VALUES ($accountNo, $tranNo)";
	if (!mysqli_query($con,$dTran))
	{
		die('Error in querying the database)' . mysqli_error($con));
	}

//query to update Transaction Table
$tran = "INSERT INTO Transaction (TransactionID, Date, Type, Amount)
		VALUES ($tranNo, NOW(), 'Loan', '$_POST[Balance]')"; 
	if (!mysqli_query($con,$tran))
	{
		die('Error in querying the database)' . mysqli_error($con));
	}
	
$sqlq = "SELECT * FROM Transaction WHERE TransactionID = " . $tranNo;
$r = mysqli_query($con,$sqlq);
echo '<p style="text-align: center; font-size:20">Loan Account has been created. <br><br>Your Loan account number is: '.$accountNo.'  </p>' ;
$sqlq = "SELECT * FROM Transaction WHERE TransactionID = " . $tranNo;
$r = mysqli_query($con,$sqlq);
$rowcount = mysqli_affected_rows($con);
if($rowcount ==1)
	{
		$row = mysqli_fetch_array($r);
		echo '<p style="font-size:18; text-align: center"> TransactionID is: </p>';
		echo '<p style="text-align: center; font-size:18"> '.$row['TransactionID'].' </p>' . "<br>";
		echo '<p style="text-align: center; font-size:18"> Transaction Date is: </p>';
		echo '<p style="text-align: center; font-size:18"> '.$row['Date'].' </p>' . "<br>";
		echo '<p style="text-align: center; font-size:18"> Amount: </p>';
		echo '<p style="text-align: center; font-size:18"> '.$row['Amount'].' </p>' . "<br>";
	}
mysqli_close($con);
?><br>
<form action="openAccount.html.php" method="post">
<div class="myButton">
<input type="submit" value="Return to Previous Page"/></div>
</form>