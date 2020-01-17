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
     <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="js/sb-admin-2.min.js"></script>

  <!-- Page level plugins -->
  <script src="vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="js/demo/datatables-demo.js"></script>
  
  
      <link href="css/sb-admin-2.min.css" rel="stylesheet">
      <link href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css" rel="stylesheet">

  <!-- Custom styles for this page -->
  <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
     <% QueryPair queryPair = (QueryPair)request.getAttribute("data");
      List<QueryData> dataList=queryPair.getQueryData();
      QueryDetails queryDetails=queryPair.getQueryDetails();
      
      int col_size=queryDetails.getCol_no();
      List<String>legends=new ArrayList(Arrays.asList(queryDetails.getCol_name().split(",")));
      List<String>type=new ArrayList(Arrays.asList(queryDetails.getCol_type().split(",")));
      %>
   <script>
   $(document).ready(function() {
	    $('#table1').DataTable( {
	        "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]]
	    } );
	} );</script>
  </head>
  <body>
  
 <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
             
                  <thead>
                    <tr>
                    <% for(int j=0;j<legends.size();j++){%>
           
   
        	<td><%=legends.get(j)%></td>
        		 
         
            <%}%>
    
      </tr>
                  </thead>
                  
                  <tbody>
  
     
 <% for(int i=0;i<dataList.size();i++){%>
            <tr>
        	  
          	<% if(col_size>0){%><td><%if(dataList.get(i).getCol_1()!=null){%> <%=dataList.get(i).getCol_1()%> <%} else if(dataList.get(i).getD1()!=0){%> <%=dataList.get(i).getD1()%><%} else{%> <%=dataList.get(i).getI1()%><% }%>
          	<%} if(col_size>1){%></td><td><%if(dataList.get(i).getCol_2()!=null){%> <%=dataList.get(i).getCol_2()%> <%} else if(dataList.get(i).getD2()!=0){%> <%=dataList.get(i).getD2()%><%} else{%> <%=dataList.get(i).getI2()%><% }%>	
          	<%} if(col_size>2){%></td> <td><%if(dataList.get(i).getCol_3()!=null){%> <%=dataList.get(i).getCol_3()%> <%} else if(dataList.get(i).getD3()!=0){%> <%=dataList.get(i).getD3()%><%} else{%> <%=dataList.get(i).getI3()%><% }%>	
          	<%} if(col_size>3){%></td><td><%if(dataList.get(i).getCol_4()!=null){%> <%=dataList.get(i).getCol_4()%> <%} else if(dataList.get(i).getD4()!=0){%> <%=dataList.get(i).getD4()%><%} else{%> <%=dataList.get(i).getI4()%><% }%>	
          	<%} if(col_size>4){%></td><td><%if(dataList.get(i).getCol_5()!=null){%> <%=dataList.get(i).getCol_5()%> <%} else if(dataList.get(i).getD5()!=0){%> <%=dataList.get(i).getD5()%><%} else{%> <%=dataList.get(i).getI5()%><% }%>	
          	<%} if(col_size>5){%></td><td><%if(dataList.get(i).getCol_6()!=null){%> <%=dataList.get(i).getCol_6()%> <%} else if(dataList.get(i).getD6()!=0){%> <%=dataList.get(i).getD6()%><%} else{%> <%=dataList.get(i).getI6()%><% }%>	
          	<%} if(col_size>6){%></td><td><%if(dataList.get(i).getCol_7()!=null){%> <%=dataList.get(i).getCol_7()%> <%} else if(dataList.get(i).getD7()!=0){%> <%=dataList.get(i).getD7()%><%} else{%> <%=dataList.get(i).getI7()%><% }%>	
            <%}%>
            </td>
          </tr>
      
                
                <%}%>
    
  
                  </tbody>
                </table> 
      
             </div>
      
               
  </body>
</html>
