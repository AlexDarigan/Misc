<!--
Purpose: 
	Create's a common main menu that is added into all other pages through the use of the php include menu.
	It also brings in the common look and feel of the project.
-->
<!DOCTYPE html>
<html>
<head>
	<!-- Link all of the Stylesheets to be shared through the Website -->
	<link rel="stylesheet" href="/bank/common/menu.css" type="text/css"/>
	<link rel="stylesheet" href="/bank/common/forms.css" type="text/css"/>
	<link rel="stylesheet" href="/bank/common/body.css" type="text/css"/>
</head>
<body>

<!-- .html.php means they're mostly html with some little php, usually a simple include of this page -->
<ul>
	<li><a href="/bank/index.php">Home</a></li>
    <li><a href="/bank/David/lodgements/lodgements.html.php">Lodgements</a></li>
    <li><a href="/bank/Marcel/Withdrawals.html.php">Withdrawals</a></li>
    <li><a href="/bank/common/customerfilemaintenancemenu.html.php">Customer File Maintenance</a></li>
	<li><a href="/bank/common/accountmaintenancemenu.html.php">Account Maintenance</a></li>
    <li><a href="/bank/blank/management.html.php">Management</a></li>
	<li><a href="/bank/blank/quotes.html.php">Quotes</a></li>
	<li><a href="/bank/Ming/Report/ReportOption.html.php">Reports</a></li>
	<li><a href="/bank/blank/changepassword.html.php">Change Password</a></li>
</ul>
</body></html>