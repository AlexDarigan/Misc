function confirmViewHistory() // allows user to confirm details displayed
{
	var response;
	response = confirm('Are these details correct? Click ok to view account history');

	if(response)
		{	
			return true;
		}
	else
		{
			return false;
		}
}

function populateHistory()			
{	
	var sel = document.getElementById("reportListbox");
 	var result;
 	result = sel.options[sel.selectedIndex].value;
 	var customerDetails = result.split(',');
 	document.getElementById("Customer_Number").value=customerDetails[0];
 	document.getElementById("First_Name").value=customerDetails[1];
 	document.getElementById("Surname").value=customerDetails[2];
 	document.getElementById("Date_of_Birth").value=customerDetails[3];
 	document.getElementById("Address").value=customerDetails[4];
	
}