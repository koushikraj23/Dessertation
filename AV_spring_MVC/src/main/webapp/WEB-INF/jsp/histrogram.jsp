<%@page import="java.util.ArrayList"%>
<%@page import="com.av.model.QueryDetails"%>
<html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*,com.av.model.QueryData,com.av.model.QueryPair" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

  <head>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawStuff);

      function drawStuff() {

          var data = google.visualization.arrayToDataTable([
        <% QueryPair queryPair = (QueryPair)request.getAttribute("data");
        List<QueryData> dataList=queryPair.getQueryData();
        QueryDetails queryDetails=queryPair.getQueryDetails();
        
        int col_size=queryDetails.getCol_no();
        List<String>legends=new ArrayList(Arrays.asList(queryDetails.getCol_name().split(",")));
        %>
        [
        <% for(int j=0;j<legends.size();j++){%>
        '<%=legends.get(j)%>'      <%if(j<legends.size()-1){%>   
        ,
        <%}%>
        <%}%>],
        // ['Year', 'Sales', 'Expenses'],
    <% for(int i=0;i<dataList.size();i++){%>
    [
    	  
      	<% if(col_size>0){%>'<%if(dataList.get(i).getCol_1()!=null){%> <%=dataList.get(i).getCol_1()%> <%} else if(dataList.get(i).getD1()!=0){%> <%=dataList.get(i).getD1()%><%} else{%> <%=dataList.get(i).getI1()%><% }%>'
      	<%} if(col_size>1){%>,<%if(dataList.get(i).getCol_2()!=null){%> <%=dataList.get(i).getCol_2()%> <%} else if(dataList.get(i).getD2()!=0){%> <%=dataList.get(i).getD2()%><%} else{%> <%=dataList.get(i).getI2()%><% }%>	
      	<%} if(col_size>2){%>,<%if(dataList.get(i).getCol_3()!=null){%> <%=dataList.get(i).getCol_3()%> <%} else if(dataList.get(i).getD3()!=0){%> <%=dataList.get(i).getD3()%><%} else{%> <%=dataList.get(i).getI3()%><% }%>	
      	<%} if(col_size>3){%>,<%if(dataList.get(i).getCol_4()!=null){%> <%=dataList.get(i).getCol_4()%> <%} else if(dataList.get(i).getD4()!=0){%> <%=dataList.get(i).getD4()%><%} else{%> <%=dataList.get(i).getI4()%><% }%>	
      	<%} if(col_size>4){%>,<%if(dataList.get(i).getCol_5()!=null){%> <%=dataList.get(i).getCol_5()%> <%} else if(dataList.get(i).getD5()!=0){%> <%=dataList.get(i).getD5()%><%} else{%> <%=dataList.get(i).getI5()%><% }%>	
      	<%} if(col_size>5){%>,<%if(dataList.get(i).getCol_6()!=null){%> <%=dataList.get(i).getCol_6()%> <%} else if(dataList.get(i).getD6()!=0){%> <%=dataList.get(i).getD6()%><%} else{%> <%=dataList.get(i).getI6()%><% }%>	
      	<%} if(col_size>6){%>,<%if(dataList.get(i).getCol_7()!=null){%> <%=dataList.get(i).getCol_7()%> <%} else if(dataList.get(i).getD7()!=0){%> <%=dataList.get(i).getD7()%><%} else{%> <%=dataList.get(i).getI7()%><% }%>	
        <%}%>
        ]
            
         <%if(i<dataList.size()-1){%>   
            ,
            <%}%>
            
            <%}%>
          ]);

          var options = {
           
        	title: ' <%=queryDetails.getTitle()%> ',
         
        };

          var chart = new google.visualization.Histogram(document.getElementById('chart_div'));
      chart.draw(data, options);
    };
    </script>
  </head>
  <body>
    <div id="chart_div" style="width: 900px; height: 500px;"></div>
  </body>
</html>
