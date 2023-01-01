function populate()			
{	
	var sel = document.getElementById("listbox");
 	var result;
 	result = sel.options[sel.selectedIndex].value;
 	var customerDetails = result.split(',');
 	document.getElementById("Customer_Number").value=customerDetails[0];
 	document.getElementById("First_Name").value=customerDetails[1];
 	document.getElementById("Surname").value=customerDetails[2];
 	document.getElementById("Date_of_Birth").value=customerDetails[3];
 	document.getElementById("Address").value=customerDetails[4];
	
}

function populateA() 
{
	var sel = document.getElementById("listbox2");
	var result;
	result = sel.options[sel.selectedIndex].value;
	var accountDetails = result.split(',');
	document.getElementById("fName").value=accountDetails[0];
	document.getElementById("sName").value=accountDetails[1];
	document.getElementById("add").value = accountDetails[2];
	document.getElementById("DOB").value = accountDetails[3];
	document.getElementById("custNo").value = accountDetails[4];
	document.getElementById("bal").value=accountDetails[5];
	document.getElementById("accNo").value=accountDetails[6];
	document.getElementById("tranID").innerHTML=accountDetails[7];
	document.getElementById("date").innerHTML=accountDetails[8];
	document.getElementById("amount").innerHTML=accountDetails[9];
	

}

function populateB() 
{
	var sel = document.getElementById("listbox3");
	var result;
	result = sel.options[sel.selectedIndex].value;
	var delDetails = result.split(',');
	document.getElementById("delCustNo").value=delDetails[0];
 	document.getElementById("delFName").value=delDetails[1];
 	document.getElementById("delSName").value=delDetails[2];
	document.getElementById("delDOB").value=delDetails[3];
	document.getElementById("delAddress").value=delDetails[4];
	document.getElementById("delLoanAccNo").value=delDetails[5];

}

function populateHistory()			
{	
	var sel = document.getElementById("listbox4");
 	var result;
 	result = sel.options[sel.selectedIndex].value;
 	var customerDetails = result.split(',');
 	document.getElementById("custNo").value=customerDetails[0];
 	document.getElementById("fName").value=customerDetails[1];
 	document.getElementById("sName").value=customerDetails[2];
 	document.getElementById("DOB").value=customerDetails[3];
	document.getElementById("add").value=customerDetails[4];
 	document.getElementById("accNo").value=customerDetails[5];
	
}

function confirmCheck() // allows user to confirm details displayed
{
	var response;
	response = confirm('Are these details correct? Click ok to create account');

	if(response)
		{	
			return true;
		}
	else
		{
			return false;
		}
}

function confirmDelete()
{
	var reply;
	reply = confirm('Are you sure you want to delete this account?');
		
	if(reply)
		{
			document.getElementById("delCustNo").disabled=false;
			document.getElementById("delFName").disabled=false;
			document.getElementById("delSName").disabled=false;
			document.getElementById("delDOB").disabled=false;
			document.getElementById("delAddress").disabled=false;
			document.getElementById("delLoanAccNo").disabled=false;
			return true;
		}
	else 
		{
			populateB();
			return false;
		}
}

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