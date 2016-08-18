<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<title>WebService Client</title>
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<!-- <style type="text/css">
div {
	background-color: #f1f1f1;
	width: 50%;
	padding: 10px;
	color: black;
	display: none;
}
</style> -->
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
    width:1000px;
    height:3000px;
    background-color:white;
    
}


.header{
    position:fixed;
}

body {
    height: 5000px;
}

</style>

<script language="JavaScript">
	function setVisibility(id, visibility) {
		document.getElementById(id).style.display = visibility;
	}
</script>

<script language="JavaScript">
	
$(document).ready(function(){
    $("#hide").click(function(){$("#sub3").hide();});
   /*  $("#show").click(function(){$("#sub3").show();$("#sub4").hide();$("#sub5").hide();$("#sub6").hide();$("#sub7").hide();$("#sub8").hide();$("#sub9").hide();$("#sub10").hide();$("#sub11").hide();$("#sub12").hide();}); */
});


var scrolled=0;

$(document).ready(function(){

    	
    $("#show").on("click" ,function(){scrolled=scrolled+1500; $("#sub3").show();$("#sub4").hide();$("#sub5").hide();$("#sub6").hide();$("#sub7").hide();$("#sub8").hide();$("#sub9").hide();$("#sub10").hide();$("#sub11").hide();$("#sub12").hide();$(".cover").animate({scrollTop:  scrolled});

			});

    
    $("#hide").on("click" ,function(){scrolled=scrolled+1500; $("#sub3").hide(); $(".cover").animate({scrollTop:  scrolled});

	});
	
    
    
    $("#upClick").on("click" ,function(){
				scrolled=scrolled-300;
				
				$(".cover").animate({
				        scrollTop:  scrolled
				   });

			});


$(".clearValue").on("click" ,function(){
				scrolled=0;
		});


});

function scrollWin() {
    window.scrollBy(0, 250);
    scrolldelay = setTimeout(scrollWin,1000000);
}

function scrollWin2() {
    window.scrollBy(0, -250);
    scrolldelay = setTimeout(pageScroll,1000);
}

</script>

</head>

<body>

<div width="900px" align="center">

<tr><td>

	<h4 align="center" class="well text-left"><b>My Projects</b></h4>
	<hr id="sub9">
</td></tr>
<tr><td>	



	<table class="table table-striped" align="center">
		<tr>
			<th class="text-center">Id</th>
			<th class="text-center">Name</th>
			<th class="text-center">Url</th>
			<th class="text-center">Operation</th>
			<th class="text-center">Statistics</th>
		</tr>
		<c:forEach items="${wsdlList}" var="ws" varStatus="i">
			<tr>
				<td>${ws.id}</td>
				<td>${ws.name}</td>
				<td>${ws.url}</td>
				<td class="text-center"><a href="ControlPanelServlet?id=${ws.id}">open</a></td>
				<td class="text-center"><a href="ShowProject?id=${ws.id}">Show Result</a></td>
			</tr>
		</c:forEach>
	</table></div>
	
	<br />
	
	<input type=button name=type value='New Project' id="show"
		class="btn btn-primary" onclick="setVisibility('sub3', 'inline');scrollWin()";>

</div>
	<!-- <div id="sub3">
		<form action="ControlPanelServlet" method="post">
		<table><tr><th>Project Name: </th><td><input type="text" name="projectName"></td></tr>
		<tr><th>WSDL:</th><td><input type="text" name="Url"></td></tr>
		<tr><th><input
				type="submit" name='action' value="Add Project"></th><td></td></tr>
	 
				</table>
		</form>
	</div> -->


	<div id="sub3" style="display: none" style="height:32px;width:35px">	<br />
		<br />
		<form action="ControlPanelServlet" method="post">
			<div class="col-xs-3">
				<label>Name:</label> <input type="text" class="form-control"
					name="projectName">
			</div>
			<div class="col-xs-8">
				<label>WSDL:</label> <input type="text" class="form-control"
					name="Url">
			</div><br />&nbsp;&nbsp;
			<button type="submit" id="upClick" class="btn btn-primary" name='action' onclick="scrollWin2()">Add</button>
		</form>
	</div>


<%-- 	<c:if test="${ opDiv==true}">
		<hr id="sub10">
		<h2>Operations</h2>
		<c:forEach items="${operations}" var="operations">
			<a href="ControlPanelServlet?op=${operations.name}">${operations.name}</a>
			</br>
		</c:forEach>
	</c:if>
 --%>
<br /><br />
<c:if test="${ opDiv==true}">
	<div class="dropdown" id="sub4">
    <button class="btn btn-primary dropdown-toggle" id="hide" type="button" data-toggle="dropdown">Select Method
    <span class="caret"></span></button>
    <ul class="dropdown-menu">
    <c:forEach items="${operations}" var="operations">
      <li><a href="ControlPanelServlet?op=${operations.name}">${operations.name}</a></li>
	</c:forEach>
    </ul>
  </div>
</c:if>

	<c:if test="${ inputsDiv==true}">
		<hr id="sub11">
		<h4 id="sub5" align="center" class="well text-left"><b>${soap_operation.name}</b></h4>
		<form id="sub6" action="ControlPanelServlet" method="post">
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
	<c:if test="${ resultDiv==true}">
		<hr id="sub12">
		<h4 id="sub7" align="center" class="well text-left"><b>Results</b></h4>
		<table id="sub8" class = "rounded" width="600px" align="center"><tr><td><br />
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
	</td></tr></div>
	</table>
	</body>
	
	<body>

<table class="verticalLine" frame="width:900px" align="center">

<tr><td>

	<h4 align="center" class="well text-left"><b>My Projects</b></h4>
	<hr id="sub9">
</td></tr>
<tr><td>	
<center>


	<table class="table table-striped" align="center">
		<tr>
			<th class="text-center">Id</th>
			<th class="text-center">Name</th>
			<th class="text-center">Url</th>
			<th class="text-center">Operation</th>
			<th class="text-center">Statistics</th>
		</tr>
		<c:forEach items="${wsdlList}" var="ws" varStatus="i">
			<tr>
				<td>${ws.id}</td>
				<td>${ws.name}</td>
				<td>${ws.url}</td>
				<td class="text-center"><a href="ControlPanelServlet?id=${ws.id}">open</a></td>
				<td class="text-center"><a href="ShowProject?id=${ws.id}">Show Result</a></td>
			</tr>
		</c:forEach>
	</table></div>
	</center> 
	<br />
	


<div id="flip">

	<input type=button name=type value='New Project' class="btn btn-primary" onclick="setVisibility('sub3', 'inline');scrollWin()";>
</div>
	<!-- <div id="sub3">
		<form action="ControlPanelServlet" method="post">
		<table><tr><th>Project Name: </th><td><input type="text" name="projectName"></td></tr>
		<tr><th>WSDL:</th><td><input type="text" name="Url"></td></tr>
		<tr><th><input
				type="submit" name='action' value="Add Project"></th><td></td></tr>
	 
				</table>
		</form>
	</div> -->

<br />
	<div id="panel" class="rcorners2" style="display: none">	<br />
		
		<form action="ControlPanelServlet" method="post">
			<div class="col-xs-3">
				<label>Name:</label> <input type="text" class="form-control"
					name="projectName">
			</div>
			<div class="col-xs-8">
				<label>WSDL:</label> <input type="text" class="form-control"
					name="Url">
			</div>&nbsp;&nbsp;
			<div id="flip">
			<button type="submit" class="btn btn-primary" name='action'>Add</button></div>
		</form>
</div>
<%-- 	<c:if test="${ opDiv==true}">
		<hr id="sub10">
		<h2>Operations</h2>
		<c:forEach items="${operations}" var="operations">
			<a href="ControlPanelServlet?op=${operations.name}">${operations.name}</a>
			</br>
		</c:forEach>
	</c:if>
 --%>
<br />

<c:if test="${ opDiv==true}">
	<div class="dropdown" id="sub4">
    <button class="btn btn-primary dropdown-toggle" id="hide" type="button" data-toggle="dropdown">Select Method
    <span class="caret"></span></button>
    <ul class="dropdown-menu">
    <c:forEach items="${operations}" var="operations">
      <li><a href="ControlPanelServlet?op=${operations.name}">${operations.name}</a></li>
	</c:forEach>
    </ul>
  </div>
</c:if>


	<c:if test="${ inputsDiv==true}">
		<hr id="sub11">
		<h4 id="sub5" align="center" class="well text-left"><b>${soap_operation.name}</b></h4>
		
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
	</c:if></div>
	<c:if test="${ resultDiv==true}">
		<hr id="sub12">
		<h4 id="sub7" align="center" class="well text-left"><b>Results</b></h4>
		<table id="sub8" class = "rounded" width="600px" align="center"><tr><td><br />
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
	</td></tr></div>
	</table>
	</body>
	
	
	










<input type="button" id="show1" value="name"/>


<div style="height:300px">
	<h4	style="background-color:#000080;height:50px"><br />&nbsp;&nbsp;&nbsp;
	
	<a href="http://localhost:8080/DynamicClient/ControlPanelServlet" id="show">Home</a> <a href="#"> &nbsp; | &nbsp;</a>
	<a href="" id="show2" onclick="setVisibility('sub3', 'inline');">New Project</a> <a href="#"> &nbsp; | &nbsp;</a>
	<a href="" id="show2">Show Result</a> <a href="#"> &nbsp; | &nbsp;</a>
	<a href="" id="show3">Compare</a>

	
	<!-- <input type=button name=type value='Home' id="show" class="btn btn-default">
	<input type=button name=type value='New Project' id="show" class="btn btn-default" onclick="setVisibility('sub3', 'inline');">
	 -->
	</h4>
	<hr id="sub9">
	
	<center>

	<div id = "show">
	<table class="table table-striped" align="center">
		<tr>
			<th class="text-center">Id</th>
			<th class="text-center">Name</th>
			<th class="text-center">URL</th>
			<th class="text-center">Operation</th>
			<th class="text-center">Statistics</th>
		</tr>
		<c:forEach items="${wsdlList}" var="ws" varStatus="i">
			<tr>
				<td>${ws.id}</td>
				<td>${ws.name}</td>
				<td>${ws.url}</td>
				<td class="text-center"><a href="ControlPanelServlet?id=${ws.id}">open</a></td>
				<td class="text-center"><a href="ShowProject?id=${ws.id}">Show Result</a></td>
			</tr>
		</c:forEach>
	</table></div>
	</center>
</div>
<div style="height:220px">

<div id="show2" style="display: none;">
<div id="flip" >
<input type=button name=type value='New Project' id="show" class="btn btn-primary" onclick="setVisibility('sub3', 'inline');">
</div></div>
<br />
<div id="panel" class="rcorners2" style="display: none">	<br />
		
		<form action="ControlPanelServlet" method="post">
			<div class="col-xs-3">
				<label>Name:</label> <input type="text" class="form-control"
					name="projectName">
			</div>
			<div class="col-xs-8">
				<label>WSDL:</label> <input type="text" class="form-control"
					name="Url">
			</div>&nbsp;&nbsp;
			<div id="flip">
			<button type="submit" class="btn btn-primary" name='action'>Add</button></div>
		</form>
</div>

<c:if test="${opDiv==true}">
<h4 id="sub13" align="center" class="well text-left"><b>Choose From Below Methods</b></h4>

<div>
<div class="left">
	<h4 id="sub14"><b>${nameOfService}&nbsp;&nbsp;</b></h4></div>
<div class="right">
	<div class="dropdown" id="sub4">
    
    <button class="btn btn-primary dropdown-toggle" id="hide" type="button" data-toggle="dropdown" >Select Method
    <span class="caret"></span></button>
    <ul class="dropdown-menu">
    <c:forEach items="${operations}" var="operations">
    
      <li><a id="flip" href="ControlPanelServlet?op=${operations.name}" >${operations.name}</a></li>
	</c:forEach>
    </ul>
  </div></div>
</c:if>

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
	
	<c:if test="${ resultDiv==true}">
		<hr id="sub12">
		<h4 id="sub7" align="center" class="well text-left"><b>Results</b></h4>
		<table id="sub8" class = "rounded" width="600px" align="center"><tr><td><br />
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


</html>

