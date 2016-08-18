<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="5;text/html; charset=ISO-8859-1">
 <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<title>WebService Client</title>
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

<style>
.rounded {
  border-radius: 5px;
  background: #E6E6E6; // without a background or border applied you won't be able to see if its rounded
}

.cover{
	margin-bottom: 0;
    width:1500px;
    height:1200px;
    background-color:#FFFFFF;
    float:right;
    overflow:auto;
}


.rightSection{
    width:850px;
    height:3000px;
    background-color:white;
    
}


.header{
    position:fixed;
}

#panel, #flip {
    text-align: left;
    background-color: #FFFFFF;
}

#panel {

    display: none; 
}

.rcorners2 {
    border-radius: 25px;
    border: 2px solid #D8D8D8;
    padding: 20px; 
    width: 100%;
    height: 250px; 
}

.rcorners3 {
    border-radius: 25px;
    border: 2px solid #D8D8D8;
    padding: 20px; 
    width: 500px;
    height: auto; 
}

body {
    height: 590px;
}

.left{
    width:auto;
    float:left;
    height:100%;
}

.right{
    margin-left:110px;
}

ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow: hidden;
}

li {
    float: left;
    position:relative;
}

.divider {
    position: absolute;
    right:-1px;
    top:2px;
}



</style>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script> 
$(document).ready(function(){
    $("#flip").click(function(){
        $("#panel").slideToggle("slow");
    });
});

function scrollWin() {
    window.scrollTo(0, 500);
}
</script>

<script language="JavaScript">
	function setVisibility(id, visibility) {
		document.getElementById(id).style.display = visibility;
		
		
	};
</script>

<script language="JavaScript">

$(document).ready(function(){
    //$("#hide").click(function(){$("#sub3").hide();});
   //$("#show").click(function(){$("#sub3").show();$("#sub4").hide();$("#sub5").hide();$("#sub6").hide();$("#sub7").hide();$("#sub8").hide();$("#sub9").hide();$("#sub10").hide();$("#sub11").hide();$("#sub12").hide();$("#sub13").hide();$("#sub14").hide();$("#subhide").hide();}); 
   $("#show1").click(function(){$("#sub1").show();$("#sub112").hide();$("#sub2").hide();$("#sub3").hide();$("#sub4").hide();$("#sub5").hide();$("#sub6").hide();});
   $("#show2").click(function(){$("#sub2").show();$("#sub112").hide();$("#sub1").hide();$("#sub3").hide();$("#sub4").hide();$("#sub5").hide();$("#sub6").hide();});
   $("#show3").click(function(){$("#sub3").show();$("#sub112").show();$("#sub1").hide();$("#sub2").hide();$("#sub4").show();$("#sub5").show();$("#sub6").hide();});
   $("#show4").click(function(){$("#sub112").hide();$("#sub6").show();$("#sub1").hide();$("#sub2").hide();$("#sub3").hide();$("#sub4").hide();$("#sub5").hide();});
   
   
   
   //$("#show").click(function(){$("#t1").show();$("#sub4").hide();$("#sub5").hide();$("#sub6").hide();$("#sub7").hide();$("#sub8").hide();$("#sub9").hide();$("#sub10").hide();$("#sub11").hide();$("#sub12").hide();$("#sub13").hide();$("#sub14").hide();});
});

</script>

</head> 

<body>

<div>

<h4	style="margin-top:auto;background-color:#000080;height:65px"><br />&nbsp;&nbsp;&nbsp;

<button type="button" class="btn btn-link btn-lg" id="show1">Home</button>
<button type="button" class="btn btn-link btn-lg" id="show2">New Project</button>
<button type="button" class="btn btn-link btn-lg" id="show3">Open Project</button>
<button type="button" class="btn btn-link btn-lg" id="show4">Compare</button>

</h4>

</div>

<div id="sub1" 
<c:if test="${ flag7=='dd'}">
		style="display: none"
		</c:if>

>



<table class="table table-striped" align="center" hight= >
		<tr>
			<th class="text-center">Id</th>
			<th class="text-center">Name</th>
			<th class="text-center">Url</th>
			<th class="text-center">Statistics</th>
		</tr>
		<c:forEach items="${wsdlList}" var="ws" varStatus="i">
			<tr>
				<td>${ws.id}</td>
				<td>${ws.name}</td>
				<td>${ws.url}</td>
				<td class="text-center"><a href="ShowProject?id=${ws.id}">Show Result</a></td>
			</tr>
		</c:forEach>
	</table></div>
	
<div id="sub2" class="rcorners2" style="display: none">	<br />
		
		<form action="ControlPanelServlet" method="post">
			<div class="col-xs-8">
				<label>Name:</label> <input type="text" class="form-control"
					name="projectName">
			</div><br /><br /><br />
			<div class="col-xs-8">
				<label>WSDL:</label> <input type="text" class="form-control"
					name="Url">
			</div>&nbsp;&nbsp;
			<br /><br /><br /><br />
			<div id="flip">&nbsp;&nbsp;&nbsp;
			<button type="submit" class="btn btn-primary" name='action'>Add</button></div>
		</form>
</div>

<div id="sub3" 
<c:if test="${ flag7!='dd'}">
		style="display: none"
		</c:if>
>


<div id="sub4" class="dropdown">
   &nbsp;&nbsp; 
   Select Project:
   <select name="list" onchange="location = this.options[this.selectedIndex].value;" >
   <option>---Select Project---</option>
    <c:forEach items="${wsdlList}" var="list">
   		<option value='ControlPanelServlet?id=${list.id}&flag7=dd' ${nameOfService ==  list.name ? 'selected="selected"' : ''}>${list.name}</option>
	</c:forEach>
 </select>
  </div><br/>
  
  <div id="sub5" class="dropdown" style="margin-left:auto">
    &nbsp;&nbsp;
    
    Select Operation:
    <select name="list" onchange="location = this.options[this.selectedIndex].value;" >
    <option>---Select Operation---</option>
    <c:forEach items="${operations}" var="operations">
   		<option value='ControlPanelServlet?op=${operations.name}' ${operations.name ==  soap_operation.name ? 'selected="selected"' : ''}>${operations.name}</option>
	</c:forEach>
 </select>
  </div>
  
</div>
<div id="sub6" style="display: none" class="rcorners3">


<form action="ControlPanelServlet" method="post">
<c:forEach items="${wsdlList}" var="ws">
<div class="checkbox">
 &nbsp;&nbsp;<label><input name="comparelist" type="checkbox" value="${ws.name}">${ws.name}</label>
</div>
</c:forEach>

<button type="submit" class="btn btn-primary" name='action' value='compare'>Compare</button>
</form>
</div>

<div id="sub112">

<c:if test="${ inputsDiv==true}">
		<hr id="sub11">
		<h4 id="sub5" align="center" class="well text-left"><b>Insert Parameters For "${soap_operation.name}" Method</b></h4>
		
		<form id="sub6" class="rcorners3" action="ControlPanelServlet" method="post">
			<c:forEach items="${allInputs}" var="allInputs" varStatus="i">
				</br>
				<div class="col-xs-5">
            <label>${allInputs.name}:</label>
            <input type="text" name="ibox${i.index}" class="form-control"/></div><br /><br />
			</c:forEach><br />
			<div class="col-xs-5">
			 <label>Number of Users:</label> <input type="text" name="NoOfUsers" class="form-control"/></div> 
			 <!-- <input type="submit" name="action" value="Invoke"> -->
			 <br /><br /><br /><br />&nbsp;&nbsp;&nbsp;
			 <button type="submit" class="btn btn-primary" name='action' value="Invoke">Invoke</button>
			 
		</form>
		<br /><br />
	</c:if>
	
	<c:if test="${resultDiv==true}">
	<a href="ShowProject?id=${WSDLID}">Show Result in Graph</a>
		<hr id="sub12">
		<h4 id="sub7" align="center" class="well text-left"><b>Results</b></h4>
		<table id="sub8" class = "rounded" width="600px" align="left"><tr><td><br />
	<!-- 	<h4 align="center" class="well text-left"><b>Results</b></h4> -->
		<table class="table table-striped" align="center" >
			<c:forEach items="${result}" var="result" varStatus="i">
				<tr>
					<th>${result.key}</th>
					<td>:&nbsp;${result.value}</td>
				</tr>
			</c:forEach>
		</table></td></tr></table><br />
		
	</c:if>

</div>


</body>

</html>

