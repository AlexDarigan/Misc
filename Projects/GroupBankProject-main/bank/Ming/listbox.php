<?php
include $_SERVER['DOCUMENT_ROOT'] . "/bank/common/db.inc.php";

$sql= "SELECT Customer_Number, First_Name, Surname, Date_of_Birth, Address FROM Customer WHERE Deleted = 0";

if (!$result = mysqli_query($con,$sql))
	{
		die('Error in querying the database)' . mysqli_error($con));
	}

echo "<br><select name='listbox' id='listbox' onclick='populate()'>";

while ($row = mysqli_fetch_array($result))
		{	
			$num = $row['Customer_Number'];
			$fname = $row['First_Name'];
			$sname = $row['Surname'];
			$DOB = $row['Date_of_Birth'];
			$addrs = $row['Address'];
			$allText = "$num,$fname,$sname,$DOB,$addrs";
			echo "<option value= '$allText'>$num $fname $sname</option>";
		
		}
echo "</select>";
mysqli_close($con);

?>