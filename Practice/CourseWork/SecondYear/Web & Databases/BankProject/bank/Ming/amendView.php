<html>
<!-- Author:	Ming Kit Choy -->
<!-- Date:		March 2022	-->
<!-- Purpose:	Amend/View a Loan Account -->	
	
<head>
<?php include $_SERVER['DOCUMENT_ROOT'] . "/bank/Ming/LoanOption.php" ?>
<link rel="stylesheet" href="/bank/common/menu.css" type="text/css"/>
<link rel="stylesheet" href="/bank/common/forms.css" type="text/css"/>
</head>
</html>

<?php
session_start();
include $_SERVER['DOCUMENT_ROOT'] . "/bank/common/db.inc.php";

// query to update changes made
$sql = "UPDATE Loan_Account SET Balance = '$_POST[amendBal]'
		WHERE Loan_Account_Number = '$_POST[amendAccNo]' ";

if (!mysqli_query($con,$sql))
{
	echo "Error " .mysqli_error($con);
}

else
{
	if (mysqli_affected_rows($con) != 0)	
	{
		echo mysqli_affected_rows($con)." record(s) updated <br>";
		echo "Account Number". $_POST['amendAccNo']." has been updated";
	}
	
	else
	{
		echo "No records were changed";
	}
}

mysqli_close($con);

?>