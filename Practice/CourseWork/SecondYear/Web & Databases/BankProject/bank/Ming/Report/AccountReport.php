<html>
<head>
<?php include $_SERVER['DOCUMENT_ROOT'] . "/bank/Ming/Report/ReportOption.html.php" ?>
<link rel="stylesheet" href="/bank/common/menu.css" type="text/css"/>
<link rel="stylesheet" href="/bank/common/forms.css" type="text/css"/>

</head>

<?php 
session_start();
include $_SERVER['DOCUMENT_ROOT'] . "/bank/common/db.inc.php";
date_default_timezone_set('UTC');
	
// query to select Customer Details, Account number and Transaction Details
$sql = "SELECT Date, Type, Amount, Balance
		FROM Loan_Account
		INNER JOIN Loan_Account_Transaction
		INNER JOIN Transaction";
	
if (!$result = mysqli_query($con,$sql))		// if problem connecting display error message
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
<th>Date</th> <th>Transaction Type</th> <th>Amount</th> <th>Balance</th></tr>";
	
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
		<form action="AccountReport.html.php" method="post">
<div class="myButton">
	<p>Would you like to print page?</p>
	<input type="submit" value="Yes"/>
	<input type="submit" value="No"/>
	</div>
	</form>
</html>
