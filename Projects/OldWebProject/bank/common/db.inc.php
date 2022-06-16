<?php
$hostname="localhost";	
$username="bankgroup";	
$password="P0rtf0l10s";
$dbname="bank";

$con= mysqli_connect($hostname,$username,$password ,$dbname);

if (!$con)
	{
		die("Failed to connect to MySQL: " . mysqli_connect_error());
	}
	
?>
