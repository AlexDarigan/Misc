
function populate(){
	var listbox = document.getElementById("listbox");
	var result;
	result = listbox.options[listbox.selectedIndex].value;
	var customer = result.split("&"); // Using & because , causes issues with the address field
	document.getElementById("customerNumber").value = customer[0];
	document.getElementById("firstname").value = customer[1];
	document.getElementById("surname").value = customer[2];
	document.getElementById("phone").value = customer[3];
	document.getElementById("address").value = customer[4];
	document.getElementById("dob").value = customer[5];
	document.getElementById("occupation").value = customer[6];
	document.getElementById("email").value = customer[7];
	document.getElementById("salary").value = customer[8];
	document.getElementById("gurantor").value = customer[9];
}
	
function toggleLock() {
	// If we did not click amend, all values are disabled
	if(document.getElementById("amendViewButton").value == "Amend Details") {
		document.getElementById("amendViewLegend").innerHTML = "Amending Customer";
		document.getElementById("amendViewButton").value = "View Details";
		document.getElementById("firstname").disabled = false;
		document.getElementById("surname").disabled = false;
		document.getElementById("phone").disabled = false;
		document.getElementById("address").disabled = false;
		document.getElementById("dob").disabled = false;
		document.getElementById("occupation").disabled = false;
		document.getElementById("email").disabled = false;
		document.getElementById("salary").disabled = false;
		document.getElementById("gurantor").disabled = false;
		document.getElementById("savechanges").disabled = false;
	} else {
		document.getElementById("amendViewButton").value = "Amend Details";
		document.getElementById("amendViewLegend").innerHTML = "View Customer";
		document.getElementById("firstname").disabled = true;
		document.getElementById("surname").disabled = true;
		document.getElementById("phone").disabled = true;
		document.getElementById("address").disabled = true;
		document.getElementById("dob").disabled = true;
		document.getElementById("occupation").disabled = true;
		document.getElementById("email").disabled = true;
		document.getElementById("salary").disabled = true;
		document.getElementById("gurantor").disabled = true;
		document.getElementById("savechanges").disabled = false;
	}
}

function confirmCheck()
{
	response = confirm("Are you sure you want to save these changes?");
	if(response) {
		document.getElementById("firstname").disabled = false;
		document.getElementById("surname").disabled = false;
		document.getElementById("phone").disabled = false;
		document.getElementById("address").disabled = false;
		document.getElementById("dob").disabled = false;
		document.getElementById("occupation").disabled = false;
		document.getElementById("email").disabled = false;
		document.getElementById("salary").disabled = false;
		document.getElementById("gurantor").disabled = false;
		return true;
	} 
	else 
	{
		populate();
		toggleLock();
		return false;
	}
}

function validateAge() {
      var birth = new Date(document.getElementById("dob").value);
      var today = new Date();
      var years = today.getFullYear() - birth.getFullYear();
      var month = today.getMonth() - birth.getMonth();
      var day = today.getDate() - birth.getDate();
      
      // Customer is less than 16 years of age
      // OR Customer is in their 16th year but their birth month hasn't come yet
      // OR Customer is in their 16th year and birth month but their birthday hasn't come yet
      if((years < 16) || (years == 16 && month < 0) || (years == 16 && month == 0 && day < 0)) 
      {
		  alert("Customers must be at least 16 years of age for a bank account");
		  document.getElementById("dob").value = "";
      }
  }
 
function confirmGurantor() {
	var customer = document.getElementById("firstname").value + " " + document.getElementById("surname").value;
	var gurantor = document.getElementById("gurantor").value;
	if(customer == gurantor) {
		alert("You cannot be your own Gurantor!");
		document.getElementById("gurantor").value = "";
	}
}

function confirmDeletion() {
	var confirmed = confirm("Are you sure you want to delete this Customer?");
	if(confirmed) 
	{
		return true;
	}
	else
	{
		populate();
		return false;
	}
}
