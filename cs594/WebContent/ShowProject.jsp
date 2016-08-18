<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawVisualization);


    function drawVisualization() {
      // Some raw data (not necessarily accurate)
   

      var data2 = google.visualization.arrayToDataTable([
                                                        ['Month', 'Avg Time'],
                                                        <c:forEach items="${wsdlList}" var="ws"  >
                                                        ['${ws.id}',  ${ws.avg}],
                                                        
                                                        </c:forEach>
                                                     ]);
    
      var data = google.visualization.arrayToDataTable([
                                                        ['Month', 'Time'],
                                                        <c:forEach items="${allData}" var="ad"  >
                                                        <c:if test="${ ad.mainid==mainid}">
                                                        ['${ad.id}',  ${ad.time}],
                                                        </c:if>
                                                        </c:forEach>
                                                     ]);
      var options = {
        title : 'Wsdl Time Analaysis',
        vAxis: {title: 'MiliSeconds'},
        hAxis: {title: 'Number of User'},
        seriesType: 'bars',
       
      };

      var options2 = {
        title : 'All Wsdl Avg Time Analaysis',
        vAxis: {title: 'MiliSeconds'},
        hAxis: {title: 'All WSDL'},
        seriesType: 'bars',
       
      };



      var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
      chart.draw(data, options); 
      var chart2 = new google.visualization.ComboChart(document.getElementById('chart_div2'));
      chart2.draw(data2, options2); 
}
    </script>
  </head>


<body>
 <div id="chart_div" style="width: 900px; height: 500px;"></div>
 <div id="chart_div2" style="width: 900px; height: 500px;"></div>
</body>
</html>