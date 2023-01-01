<html>
<!-- Author:	Yvonne Ryan - C00263872									-->
<!-- Date:		March 2022												-->
<!-- Title:		depositHistory.php										-->
<!-- Purpose:	Allow user to view Deposit account transaction history	-->	
	
<head>
<?php include $_SERVER['DOCUMENT_ROOT'] . "/bank/Yvonne/depositMenu.php" ?>
<link rel="stylesheet" href="/bank/common/menu.css" type="text/css"/>
<link rel="stylesheet" href="/bank/common/forms.css" type="text/css"/>
<link rel="stylesheet" href="table.css" type="text/css"/>
</head>

<?php 
session_start();
include $_SERVER['DOCUMENT_ROOT'] . "/bank/common/db.inc.php";
date_default_timezone_set('UTC');
	
// query to select Customer Details, Account number and Transaction Details
$sql = "SELECT Date, Transaction.TransactionID, Type, Amount, Balance
		FROM Deposit_Account
		INNER JOIN Deposit_Account_Transaction
		ON Deposit_Account.Deposit_Account_Number = Deposit_Account_Transaction.Deposit_Account_Number
		INNER JOIN Transaction 
		ON
		Deposit_Account_Transaction.TransactionID = Transaction.TransactionID 
		WHERE
		Deposit_Account.Deposit_Account_Number = " . $_POST['accNo'] ;
	
	
if (!$result = mysqli_query($con,$sql))		// if there's a problem connecting display error message
			{
				die('Error in querying the database)' . mysqli_error($con));
			}


$accNo = $_POST['accNo'];
$fName = $_POST['fName'];
$sName = $_POST['sName'];

echo '<h1>Account History</h1>';

		echo "<p> Account Number:  $accNo &nbsp; &nbsp; &nbsp; &nbsp; Name: $fName $sName </p>";
		echo "<br>";
	
	
echo "<table>
<tr>
<th>Date</th> <th>Transaction ID</th> <th>Transaction Type</th> <th>Transaction Amount</th> <th>Balance</th></tr>";
	
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
		<form action="depositHistory.html.php" method="post">
<div class="myButton">
	<p>Would you like to print page?</p>
	<input type="submit" value="Yes"/>
	<input type="submit" value="No"/>
	</div>
	</form>
		</html>
