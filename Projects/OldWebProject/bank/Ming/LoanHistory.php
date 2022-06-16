<html>
<!-- Author:	Ming Kit choy 											-->
<!-- Date:		March 2022												-->
<!-- Title:		LoanHistory.php											-->
<!-- Purpose:	Allow user to view Loan account transaction history		-->	
	
<head>
<?php include $_SERVER['DOCUMENT_ROOT'] . "/bank/Ming/LoanOption.php"?>
<link rel="stylesheet" href="/bank/common/menu.css" type="text/css"/>
<link rel="stylesheet" href="/bank/common/forms.css" type="text/css"/>

<style>
table, th, td {
  	border: 1px solid black;
	text-align: center;
	margin-left:auto; 
    margin-right:auto;
	
	background-color: white;
	
	}
	
	th, td {
		padding: 15px; 
		}	
h1 { 
	text-align: center;
		}
p {
	text-align: center;
	font-size: large;
		}
	</style>
</head>
<?php 
session_start();
include $_SERVER['DOCUMENT_ROOT'] . "/bank/common/db.inc.php";
date_default_timezone_set('UTC');
	
// query to select Customer Details, Account number and Transaction Details
$sql = "SELECT Date, Transaction.TransactionID, Type, Amount, Balance
		FROM Loan_Account
		INNER JOIN Loan_Account_Transaction
		ON Loan_Account.Loan_Account_Number = Loan_Account_Transaction.Loan_Account_Number
		INNER JOIN Transaction 
		ON
		Loan_Account_Transaction.TransactionID = Transaction.TransactionID 
		WHERE Loan_Account.Loan_Account_Number = " . $_POST['accNo'] ;
if (!$result = mysqli_query($con,$sql))		// if problem connecting display error message
			{
				die('Error in querying the database)' . mysqli_error($con));
			}
$accNo = $_POST['accNo'];
$fName = $_POST['fName'];
$sName = $_POST['sName'];

echo '<h1>Loan Account History</h1>';
		echo "<p>Account Number:  $accNo &nbsp; &nbsp; &nbsp; &nbsp; Name: $fName $sName </p>";
		echo "<br>";
echo "<table>
<tr>
<th>Date</th> <th>ID</th> <th>Transaction Type</th> <th>Repayment Amount</th> <th>Balance</th></tr>";
	
					while ($row = mysqli_fetch_array($result))
						{	
							$date= date_create($row['Date']);
							$Fdate = date_format($date, "Y-m-d");
							
							echo "<td>".$Fdate."</td>
							<td>".$row['TransactionID']."</td>
							<td>".$row['Type']."</td>
							<td>".$row['Amount']."</td>
							<td>".$row['Balance']."</td>
							</tr>";						
						}
				echo "</table>";
mysqli_close($con);
?>
	<br>
		<form action="LoanHistory.html.php" method="post">
<div class="myButton">
	<p>Do you want to print statement?</p>
	<input type="submit" value="Yes"/>
	<input type="submit" value="No"/>
	</div>
	</form>
</html>