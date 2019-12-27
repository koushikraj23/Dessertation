<%@page import="java.util.ArrayList"%>
<%@page import="com.av.model.QueryDetails"%>
<html lang="en">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*,com.av.model.QueryDetails,com.av.model.QueryPair" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>


<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>SB Admin 2 - Blank</title>

  <!-- Custom fonts for this template-->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="css/sb-admin-2.min.css" rel="stylesheet">

</head>
	<script>
	var where=null;
	var list= null;
	var join=null;
	
	var myObj={};
	var mytable={};
	var slected_tables=[];
	var selected_column=[];
	var col_type=[];
	
	var no_of_fields=1;
	var no_of_tables=1;
	var no_of_joins=0;
	var query;
$(document).ready(function () {
	    

/*final sql Query
 */	
	$("#submit").click(function() {
		/*  myObj[table].push(", "+table+"."+field+" as "+type+no_of_fields )
		mytable.push(slected_tables); */
		 query= list+" from "+slected_tables.toString();
		if(no_of_joins>0){
			
			query=query+" "+join;
		}
		if(where!= null){
			 query=query+" "+where;
		}
		
		$("#sql_query").val(query);
		 console.log(query);
		/* if(no_of_tables>1){
		 $.ajax({
		        type: "POST",
		        contentType: "application/json",
		        url: "/testing",
		        data:  JSON.stringify(myObj),
		        dataType: 'json',
		        cache: false,
		        timeout: 600000,
		        success: function (data) {
		          
		            join=data;
		            no_of_joins=join.length;
		            console.log("SUCCESS : ", join);
		        },
		        error: function (e) {

		            var json = "<h4>Ajax Response</h4><pre>"
		                + e.responseText + "</pre>";
		            $('#feedback').html(json);

		            console.log("ERROR : ", e);
		            $("#btn-search").prop("disabled", false);

		        }
		    }); 
		}
		*/
		
	
		
		
	});
	
	
	
	/*  */
	$("#next1").click(function() {
		/*  myObj[table].push(", "+table+"."+field+" as "+type+no_of_fields )
		mytable.push(slected_tables); */
		
		$("#col_no").val(no_of_fields);
		$("#col_type").val(col_type.toString());
		if(no_of_tables>1){
		 $.ajax({
		        type: "POST",
		        contentType: "application/json",
		        url: "/testing",
		        data:  JSON.stringify(myObj),
		        dataType: 'json',
		        cache: false,
		        timeout: 600000,
		        success: function (data) {
		          
		            join=data;
		            no_of_joins=join.length;
		            console.log("SUCCESS : ", join);
		        },
		        error: function (e) {

		            var json = "<h4>Ajax Response</h4><pre>"
		                + e.responseText + "</pre>";
		            $('#feedback').html(json);

		            console.log("ERROR : ", e);
		            $("#btn-search").prop("disabled", false);

		        }
		    });
		}
		
		
		$('#where_column').append($(" <option disabled selected value> -- select an option -- </option> "));
		for (index = 0; index < selected_column.length; index++) { 
		    console.log(selected_column[index]); 
		    $('#where_column')
            .append($("<option></option>")
            .attr("value",selected_column[index])
            .text(selected_column[index]));
		} 
		
		$("#where_fieldset").prop('disabled', false);
		
		
		
	});
	
	$("#next2").click(function() {
console.log(no_of_tables);
console.log(no_of_joins);
console.log(slected_tables);
		if(no_of_joins==0&&no_of_tables>1){
			$("#join_fieldset").prop('disabled', false);
			$('#where_column1').append($(" <option disabled selected value> -- select an option -- </option> "));
	$('#where_column2').append($(" <option disabled selected value> -- select an option -- </option> "));
		 slected_tables.forEach(joinTable);
		 }
		
	});
	
	
	$("#list1").click(function() {
		
		if(no_of_tables==1){
			 slected_tables.forEach(fire_ajax_submit);
		 $.ajax({
		        type: "POST",
		        contentType: "application/json",
		        url: "/testing",
		        data: JSON.stringify(slected_tables),
		        dataType: 'json',
		        cache: false,
		        timeout: 600000,
		        success: function (data) {
		            console.log("SUCCESS : ", data);
		        },
		        error: function (e) {

		            var json = "<h4>Ajax Response</h4><pre>"
		                + e.responseText + "</pre>";
		            $('#feedback').html(json);

		            console.log("ERROR : ", e);
		            $("#btn-search").prop("disabled", false);

		        }
		    });
		 
		 
		
		 }
		
		else if( no_of_tables==2){
			for (index = 0; index < slected_tables.length; index++) { 
			    console.log(slected_tables[index]); 
			    
			    
			    
			} 
			slected_tables.forEach(fire_ajax_submit);
			
		}
		});

	$( "#selected_column" ).click(function() {
		table=$('#table_name').val();
		var temp=$('#column_name').val().split("-");
		field=temp[0];
		var type;	
		
		if(temp[1]==("varchar")||temp[1]==("text"))
		{
		type="col"
		col_type.push("text")
		}
		else if(temp[1]==("int"))
		{
		type="i"
			col_type.push("number")
		}
		else if(temp[1]==("float"))
		{
		type="d"
			col_type.push("number")
		}
		
		
 	if(list==null){
			list="Select "+table+"."+field+" as "+type+no_of_fields ;	
			console.log(list);
			slected_tables.push(table);
			selected_column.push(table+"."+field);
			$('#fields')
	        .append(table+"."+field+" as "+type+no_of_fields);
			console.log(slected_tables);
			no_of_fields=no_of_fields+1;
		}
		else  if (!list.includes(table+"."+field)) {
			list=list+","+table+"."+field+" as "+type+no_of_fields ;
			console.log(list);
			selected_column.push(table+"."+field);
			$('#fields')
	        .append(table+"."+field+" as "+type+no_of_fields);
			if (slected_tables.indexOf(table) < 0) { 
				slected_tables.push(table);
				console.log(slected_tables);
				no_of_tables=no_of_tables+1;
				} 
			no_of_fields=no_of_fields+1;
		} 
 	
 	
		
		if(myObj.hasOwnProperty(table)){
			 myObj[table].push(", "+table+"."+field+" as "+type+no_of_fields )
		
		 }
		else{
		     myObj[table]=[table+"."+field+" as "+type+no_of_fields]
		   
		    }
		
		
		});

	
	
	
	
	$( "#join_condition" ).click(function() {
		var col_temp=$('#where_column1').val().split("-");
		var a=$('#where_column2').val().split("-");
		var w_table1=$( "#where_table1").val()+"."+col_temp1[0]+$( "#condition2").val()+$( "#where_table2").val()+"."+col_temp[0];
		//var w_table2=$( "#where_table1").val()+"."+$( "#where_column1").val()+$( "#where_column1").val()+$( "#where_table2").val()+"."+$( "#where_column2").val();
		
		
 	if(join==null){
 		join= w_table1;	
			console.log(join);
			no_of_joins=no_of_joins+1;
			$('#joins')
	        .append(w_table1);
		}
		else  if (!join.includes(w_table1)) {
			
			join=join+" and "+ w_table1;	
			$('#joins')
	        .append(w_table1);
			no_of_joins=no_of_joins+1;
			console.log(join+"_"+no_of_joins);
		}	
 	
 	if(no_of_joins==(no_of_tables-1)){
 		$("#join_fieldset").prop('disabled', true);
 	}
		
		});

	
	
/* 
	$( "#where_condition" ).click(function() {
		var condition=$('#condition').val();
		
		var column=$("#where_column").val();	
		
		if( where==null){
			$('#where_list').append(column+condition);
		}
		
		else 
			if (!where.indexOf(column+condition) >-1) {
		$('#where_list').append(column+condition+",");
		}
		 else{
			 alert("Condition alreday added");
		 }
		 
		
		if( where==null){
			where=column+condition;
		}
		
		else if (!where.indexOf(column+condition) >-1) 
			{ 
			console.log(where.indexOf(column+condition));
			where= where+" and "+column+condition;
			}
        
	
 	console.log(where);
		
		});

	
	
	
	
	 */
	
	
	$('#table_name').on('change', function() {
		  $.ajax({
		        type: "POST",
		        contentType: "application/json",
		        url: "/search",
		        data: JSON.stringify(this.value),
		        dataType: 'json',
		        cache: false,
		        timeout: 600000,
		        success: function (data) {
		            console.log("SUCCESS : ", data);
		            $('#column_name').find('option').remove().ends
		            $('#column_name').append($(" <option disabled selected value> -- select an option -- </option>"));
		           
		            $.each(data, function(key, value) {
		            	
		                $('#column_name')
		                    .append($("<option></option>")
		                    .attr("value",value)
		                    .text(value));
		                console.log(value);
		           });
		        },
		        error: function (e) {

		            var json = "<h4>Ajax Response</h4><pre>"
		                + e.responseText + "</pre>";
		            $('#feedback').html(json);

		            console.log("ERROR : ", e);
		            $("#btn-search").prop("disabled", false);

		        }
		    });

		});
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	  

});


/*where condition  */
function where_clause(value){
		var condition=$('#condition').val();
		
		var column=$("#where_column").val();	
		
		
		if( where==null){
			$('#where_list').append(column+condition+" ");
			where=column+condition+" ";
			console.log(where);
			
		}
		
		else if (!where.includes(column+condition+" ")) 
			{ 
			
			$('#where_list').append(" "+value+" "+ column+condition);
			where= where+" "+ value+" "+column+condition+" ";
			console.log(where);
			}
        
	

		
		
}


function join_clause(value) {


}


function joinTable(value) {

	$('#where_table1')
    .append($("<option></option>")
    .attr("value",value)
    .text(value));
	$('#where_table2')
    .append($("<option></option>")
    .attr("value",value)
    .text(value));
}





function column_list(id,value){
	j_id="#"+id;
	console.log(j_id,value,id);
	  $.ajax({
	        type: "POST",
	        contentType: "application/json",
	        url: "/search",
	        data: JSON.stringify(value),
	        dataType: 'json',
	        cache: false,
	        timeout: 600000,
	        success: function (data) {
	            console.log("SUCCESS : ", data);
	            $(j_id).find('option').remove().ends
	            $(j_id)
                .append($("<option disabled selected value> -- select an option -- </option>"));
                
	            $.each(data, function(key, value) {
	            	
	                $(j_id)
	                    .append($("<option></option>")
	                    .attr("value",value)
	                    .text(value));
	                console.log(value);
	           });
	        },
	        error: function (e) {

	            var json = "<h4>Ajax Response</h4><pre>"
	                + e.responseText + "</pre>";
	            $('#feedback').html(json);

	            console.log("ERROR : ", e);
	            $("#btn-search").prop("disabled", false);

	        }
	    });
}

</script>
<body id="page-top">

  <!-- Page Wrapper -->
  <div id="wrapper">

    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">SB Admin <sup>2</sup></div>
      </a>

      <!-- Divider -->
      <hr class="sidebar-divider my-0">

      <!-- Nav Item - Dashboard -->
      <li class="nav-item">
        <a class="nav-link" href="/">
          <i class="fas fa-fw fa-tachometer-alt"></i>
          <span>Dashboard</span></a>
      </li>

      <!-- Divider -->
      
     

      <!-- Heading -->
      <div class="sidebar-heading">
        Addons
      </div>

      <!-- Nav Item - Charts -->
      <li class="nav-item">
        <a class="nav-link" href="addQuery">
          <i class="fas fa-fw fa-chart-area"></i>
          <span>Add Query</span></a>
      </li>

      <!-- Nav Item - Tables -->
      <li class="nav-item">
        <a class="nav-link" href="allQuery">
          <i class="fas fa-fw fa-table"></i>
          <span>View Queries</span></a>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider d-none d-md-block">

      <!-- Sidebar Toggler (Sidebar) -->
      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>

    </ul>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

          <!-- Sidebar Toggle (Topbar) -->
          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>

          <!-- Topbar Search -->
          <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
            <div class="input-group">
              <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
              <div class="input-group-append">
                <button class="btn btn-primary" type="button">
                  <i class="fas fa-search fa-sm"></i>
                </button>
              </div>
            </div>
          </form>

          <!-- Topbar Navbar -->
          <ul class="navbar-nav ml-auto">

            <!-- Nav Item - Search Dropdown (Visible Only XS) -->
            <li class="nav-item dropdown no-arrow d-sm-none">
              <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-search fa-fw"></i>
              </a>
              <!-- Dropdown - Messages -->
              <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in" aria-labelledby="searchDropdown">
                <form class="form-inline mr-auto w-100 navbar-search">
                  <div class="input-group">
                    <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
                    <div class="input-group-append">
                      <button class="btn btn-primary" type="button">
                        <i class="fas fa-search fa-sm"></i>
                      </button>
                    </div>
                  </div>
                </form>
              </div>
            </li>

            <!-- Nav Item - Alerts -->
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-bell fa-fw"></i>
                <!-- Counter - Alerts -->
                <span class="badge badge-danger badge-counter">3+</span>
              </a>
              <!-- Dropdown - Alerts -->
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="alertsDropdown">
                <h6 class="dropdown-header">
                  Alerts Center
                </h6>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="mr-3">
                    <div class="icon-circle bg-primary">
                      <i class="fas fa-file-alt text-white"></i>
                    </div>
                  </div>
                  <div>
                    <div class="small text-gray-500">December 12, 2019</div>
                    <span class="font-weight-bold">A new monthly report is ready to download!</span>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="mr-3">
                    <div class="icon-circle bg-success">
                      <i class="fas fa-donate text-white"></i>
                    </div>
                  </div>
                  <div>
                    <div class="small text-gray-500">December 7, 2019</div>
                    $290.29 has been deposited into your account!
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="mr-3">
                    <div class="icon-circle bg-warning">
                      <i class="fas fa-exclamation-triangle text-white"></i>
                    </div>
                  </div>
                  <div>
                    <div class="small text-gray-500">December 2, 2019</div>
                    Spending Alert: We've noticed unusually high spending for your account.
                  </div>
                </a>
                <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
              </div>
            </li>

            <!-- Nav Item - Messages -->
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-envelope fa-fw"></i>
                <!-- Counter - Messages -->
                <span class="badge badge-danger badge-counter">7</span>
              </a>
              <!-- Dropdown - Messages -->
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="messagesDropdown">
                <h6 class="dropdown-header">
                  Message Center
                </h6>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/fn_BT9fwg_E/60x60" alt="">
                    <div class="status-indicator bg-success"></div>
                  </div>
                  <div class="font-weight-bold">
                    <div class="text-truncate">Hi there! I am wondering if you can help me with a problem I've been having.</div>
                    <div class="small text-gray-500">Emily Fowler Â· 58m</div>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/AU4VPcFN4LE/60x60" alt="">
                    <div class="status-indicator"></div>
                  </div>
                  <div>
                    <div class="text-truncate">I have the photos that you ordered last month, how would you like them sent to you?</div>
                    <div class="small text-gray-500">Jae Chun Â· 1d</div>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/CS2uCrpNzJY/60x60" alt="">
                    <div class="status-indicator bg-warning"></div>
                  </div>
                  <div>
                    <div class="text-truncate">Last month's report looks great, I am very happy with the progress so far, keep up the good work!</div>
                    <div class="small text-gray-500">Morgan Alvarez Â· 2d</div>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/Mv9hjnEUHR4/60x60" alt="">
                    <div class="status-indicator bg-success"></div>
                  </div>
                  <div>
                    <div class="text-truncate">Am I a good boy? The reason I ask is because someone told me that people say this to all dogs, even if they aren't good...</div>
                    <div class="small text-gray-500">Chicken the Dog Â· 2w</div>
                  </div>
                </a>
                <a class="dropdown-item text-center small text-gray-500" href="#">Read More Messages</a>
              </div>
            </li>

            <div class="topbar-divider d-none d-sm-block"></div>

            <!-- Nav Item - User Information -->
            <li class="nav-item dropdown no-arrow">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">Valerie Luna</span>
                <img class="img-profile rounded-circle" src="https://source.unsplash.com/QAB-WJcbgJk/60x60">
              </a>
              <!-- Dropdown - User Information -->
              <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                <a class="dropdown-item" href="#">
                  <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                  Profile
                </a>
                <a class="dropdown-item" href="#">
                  <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                  Settings
                </a>
                <a class="dropdown-item" href="#">
                  <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                  Activity Log
                </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                  <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                  Logout
                </a>
              </div>
            </li>

          </ul>

        </nav>
        <!-- End of Topbar -->

        <!-- Begin Page Content -->
        <div class="container-fluid">
	<% List<String> table= (List<String>)request.getAttribute("table");
        %>
          <!-- Page Heading -->
          <h1 class="h3 mb-4 text-gray-800">Blank Page</h1>

<form method="post" action="saveDetails">
						<div class="form-group">
							<label for="email">Title:</label> <input type="text"
								class="form-control" id="title" placeholder="Enter Title"
								name="Title">
						</div>
						
						<!-- <div class="row"><div class="col-lg-6">
						<div class="form-group">
							<label for="col_no">Column No:</label> <input type="number"
								class="form-control" id="col_no" placeholder="Enter Column NO"
								name="col_no">
						</div>
						</div><div class="col-lg-6">
						<div class="form-group">
							<label for="col_no">Column NAME:</label> <input type="text"
								class="form-control" id="col_name"
								placeholder="Enter Column Names" name="col_name">
						</div>
</div></div> -->
<div class="row"><div class="col-lg-6">
						<div class="form-group">
						<label for="col_no">Column NAME:</label> <input type="text"
								class="form-control" id="col_name"
								placeholder="Enter Column Names" name="col_name">
						</div>
						</div></div>
						
						
						<div class="form-group">
						<div class="row">
					<div class="col-lg-6">
							<label for="sql_query">Select Column:</label> <select id="table_name">
							<option disabled selected value> -- select an option -- </option>
								<% for(String t : table){ %>
								<option value="<%=t%>"><%=t%></option>
								<%} %>
							</select> <select id="column_name"></select>
							<button type="button" id="selected_column">ADD</button>
							<button type="button" id="next1">Next</button>
							
							</div><div class="col-lg-6">
							<p id="fields"></p>
</div>

						</div></div>
						<fieldset id="where_fieldset" disabled>
						<div class="form-group" id="whereGroup">
					<div class="row">
					<div class="col-lg-6">
							<label for="formGroupExampleInput">Where</label> <select
								id="where_column"></select>
								
								<div class="row">
					<div class="col-lg-6">
					<input type="text"
								class="form-control" id="condition"
								placeholder="Enter Condition" name="condition">
							</div>
						<div class="col-lg-6">	<button type="button" id="where_condition" onclick="where_clause('AND')">AND</button>
							<button type="button" id="where_condition" onclick="where_clause('OR')">OR</button>
							
							<button type="button" id="next2">Next</button>
							<button type="button" id="submit">submit</button>
							
							</div></div></div>
					
					<div class="col-lg-6">
					<p id="where_list"></p>
					</div></div>
						</div></fieldset>
						<fieldset id="join_fieldset" disabled>
						<div class="form-group" id="JoinGroup">
							<label for="formGroupExampleInput">Join Table</label>
							 <select id="where_table1"
								onchange="column_list('where_column1',this.value)">
							</select>
							<select id="where_column1"></select> 
							<select id="condition2">
								<option value="&lt;">&lt;</option>
								<option value="&lt;">&gt;</option>
							</select> <select id="where_table2"
								onchange="column_list('where_column2',this.value)">
							</select><select id="where_column2"></select>
							<button type="button" id="join_condition" onclick="join_clause()">ADD</button>
							
							<button type="button" id="next2">Next</button>
							<p id="joins"></p>
						</div>
						</fieldset>
                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#devModal">
                  <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                  Developer Module
                </a>

						<input type="submit" value="Submit">
						
<!-- Developer Modal-->
  <div class="modal fade" id="devModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Developer Module</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">Ã</span>
          </button>
        </div>
        <div class="modal-body">
        		<div class="row"><div class="col-lg-6">
						<div class="form-group">
							<label for="col_no">Column No:</label> <input type="number"
								class="form-control" id="col_no" placeholder="Enter Column NO"
								name="col_no">
						</div>
						</div><div class="col-lg-6">
						<div class="form-group">
							<label for="col_no">Column Type:</label> <input type="text"
								class="form-control" id="col_type"
								placeholder="Enter Column Names" name="col_type">
						</div>
</div></div>
<div class="row"><div class="col-lg-6">
						<div class="form-group">
							<label for="col_no"> SQL Query </label> 
						</div>
						</div><div class="col-lg-6">
						<div class="form-group">
						<input type="text"
								class="form-control" id="sql_query"
								placeholder="Enter Column Names" name="sql_query">
						
						</div>
</div></div>
        
        
       
      
        
						<input type="submit" value="Submit">
        </div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
          <a class="btn btn-primary" href="login.html">Logout</a>
        </div>
      </div>
    </div>
  </div>						
						
					</form>
        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

      <!-- Footer -->
      <footer class="sticky-footer bg-white">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Copyright &copy; Your Website 2019</span>
          </div>
        </div>
      </footer>
      <!-- End of Footer -->

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">Ã</span>
          </button>
        </div>
        <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
          <a class="btn btn-primary" href="login.html">Logout</a>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="js/sb-admin-2.min.js"></script>

</body>

</html>
