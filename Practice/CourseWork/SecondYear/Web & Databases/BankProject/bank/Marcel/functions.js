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

function toggleLockc()
{
	if(document.getElementById("amendViewbutton").value == "Amend Details")
	{
		document.getElementById("fName").disable = false;
		document.getElementById("sName").disable = false;
		document.getElementById("add").disable = false;	
		document.getElementById("DOB").disable = false;	
		document.getElementById("custNo").disable = false;	
		document.getElementById("overlimit").disable = false;	
		document.getElementById("bal").disable = "View Details";	
	}
	
	else
	{
		document.getElementById("fName").disable = false;
		document.getElementById("sName").disable = false;
		document.getElementById("add").disable = false;
		document.getElementById("DOB").disable = false;
		document.getElementById("custNo").disable = false;	
		document.getElementById("overlimit").disable = false;
		document.getElementById("bal").disable = "Amend Details";
	}
}

function populateA() 
{
	var sel = document.getElementById("listbox3");
	var result;
	result = sel.options[sel.selectedIndex].value;
	var accountDetails = result.split(',');
	document.getElementById("fName").value=accountDetails[0];
	document.getElementById("sName").value=accountDetails[1];
	document.getElementById("add").value = accountDetails[2];
	document.getElementById("DOB").value = accountDetails[3];
	document.getElementById("custNo").value = accountDetails[4];
	document.getElementById("overlimit").value = accountDetails[5];
	document.getElementById("bal").value=accountDetails[6];
	document.getElementById("accNo").value=accountDetails[7];
	document.getElementById("tranID").innerHTML=accountDetails[8];
	document.getElementById("date").innerHTML=accountDetails[9];
	document.getElementById("type").innerHTML=accountDetails[10];
	document.getElementById("amount").innerHTML=accountDetails[11];
}

function populateB() 
{
	var sel = document.getElementById("listbox2");
	var result;
	result = sel.options[sel.selectedIndex].value;
	var delDetails = result.split(',');
	document.getElementById("delCustNo").value=delDetails[0];
 	document.getElementById("delFName").value=delDetails[1];
 	document.getElementById("delSName").value=delDetails[2];
	document.getElementById("delDOB").value=delDetails[3];
	document.getElementById("delAddress").value=delDetails[4];
	document.getElementById("delCurAccNo").value=delDetails[5];
}

function populateC() 
{
	var sel = document.getElementById("listbox4");
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
	document.getElementById("type").innerHTML=accountDetails[9];
	document.getElementById("amount").innerHTML=accountDetails[10];
}

function confirmCheck() // allows user to confirm details displayed
{
	var response;
	response = confirm('Are you sure (Y/N)?');

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
			document.getElementById("delCurAccNo").disabled=false;
			return true;
		}
	else 
		{
			populateB();
			return false;
		}
}

function confirmCheck2() // allows user to confirm details displayed
{
	var response;
	response = confirm('Are you sure (Y/N)?');

	if(response)
		{	
			document.getElementById("fName").disabled=false;
			document.getElementById("sName").disabled=false;
			document.getElementById("add").disabled=false;
			document.getElementById("DOB").disabled=false;
			document.getElementById("custNo").disabled=false;
			document.getElementById("bal").disabled=false;
			document.getElementById("accNo").disabled=false;
			return true;
		}
	else
		{
			return false;
		}
}

function confirmCheck3() // allows user to confirm details displayed
{
	var response;
	response = confirm('Are you sure (Y/N)?');

	if(response)
		{	
			document.getElementById("overlimit").disabled=false;
			document.getElementById("accNo").disabled=false;

			return true;
		}
	else
		{
			return false;
		}
}