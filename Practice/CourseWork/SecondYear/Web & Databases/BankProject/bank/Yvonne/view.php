<html>
<!-- Author:	Yvonne Ryan  - C00263872			-->
<!-- Date:		Feb 2022							-->
<!-- Title:		view.php							-->
<!-- Purpose:	Allow user to View Deposit Account	-->	
	
<head>
<?php include $_SERVER['DOCUMENT_ROOT'] . "/bank/Yvonne/depositMenu.php" ?>
<link rel="stylesheet" href="/bank/common/menu.css" type="text/css"/>
<link rel="stylesheet" href="/bank/common/forms.css" type="text/css"/>
<link rel="stylesheet" href="table.css" type="text/css">
</head>

<?php 
session_start();
include $_SERVER['DOCUMENT_ROOT'] . "/bank/common/db.inc.php";
date_default_timezone_set('UTC');
	
// query to select Customer Details, Account details and Transaction Details
$sql = "SELECT Deposit_Account.Deposit_Account_Number, Transaction.TransactionID, Date, Amount
		FROM Deposit_Account
		INNER JOIN Deposit_Account_Transaction
		ON Deposit_Account.Deposit_Account_Number = Deposit_Account_Transaction.Deposit_Account_NUmber
		INNER JOIN Transaction 
		ON Deposit_Account_Transaction.TransactionID = Transaction.TransactionID 
		WHERE Closed = 0 
		AND Deposit_Account.Deposit_Account_Number =  " . $_POST['accNo'] .
	 	" ORDER BY Date DESC LIMIT 5" ; 
	// the limit will return 5 recent transactions
	
	
if (!$result = mysqli_query($con,$sql))		// if problem connecting display error message
			{
				die('Error in querying the database)' . mysqli_error($con));
			}


echo '<h1>Recent Transactions</h1>';

	echo "<table>
<tr>
<th>Deposit Account Number</th> <th>Transaction ID</th> <th>Date</th> <th>Amount</th></tr>";
	
					while ($row = mysqli_fetch_array($result))
						{	
							$date= date_create($row['Date']);
							$Fdate = date_format($date, "Y-m-d");
							
							echo "<td>".$row['Deposit_Account_Number']."</td>
							<td>".$row['TransactionID']."</td>
							<td>".$Fdate."</td>
							<td>".$row['Amount']."</td>
							</tr>";
							
						}
				
				echo "</table>";

mysqli_close($con);
	
?>
	
	<br>
		<form action="View.html.php" method="post">
<div class="myButton">
	<input type="submit" value="Rerturn to View Account"/>
	</div>
	</form>
		</html>
