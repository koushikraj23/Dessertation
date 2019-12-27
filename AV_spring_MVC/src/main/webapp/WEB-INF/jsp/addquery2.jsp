<%@page import="java.util.ArrayList"%>
<%@page import="com.av.model.QueryDetails"%>
<html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page
	import="java.util.*,com.av.model.QueryData,com.av.model.QueryPair"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<style>
body {
	min-height: 100vh;
}
</style>
</head>
<body>
	<script>var where=null;
$(document).ready(function () {
	  
	     
	   
	     
	var list= null;
	
	var myObj={};
	var slected_tables=[];
	var selected_column=[];
	var no_of_fields=1;
	var no_of_tables=1;
	$("#lists").click(function() {
		
		
		for (index = 0; index < selected_column.length; index++) { 
		    console.log(selected_column[index]); 
		    
		    $('#where_column')
            .append($("<option></option>")
            .attr("value",selected_column[index])
            .text(selected_column[index]));
		} 
		
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
		}
		else if(temp[1]==("int"))
		{
		type="i"
		}
		else if(temp[1]==("float"))
		{
		type="d"
		}
		$('#fields')
        .append(table+"."+field+" as "+type+no_of_fields);
		
 	if(list==null){
			list="Select "+table+"."+field+" as "+type ;	
			console.log(list);
			slected_tables.push(table);
			selected_column.push(table+"."+field);
			console.log(slected_tables);
		}
		else{
			list=list+","+table+"."+field+" as "+type ;
			console.log(list);
			selected_column.push(table+"."+field);
			if (slected_tables.indexOf(table) >= 0) { 
				 
				} else { 
					slected_tables.push(table);
					console.log(slected_tables);
				}
		} 
 	
 	
		
		if(myObj.hasOwnProperty(table)){
			 myObj[table].push(", "+table+"."+field+" as "+type+no_of_fields )
		
		 }
		else{
		     myObj[table]=[table+"."+field+" as "+type+no_of_fields]
		   
		    }
		no_of_fields=no_of_fields+1;
		
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



function where_clause(value){
		var condition=$('#condition').val();
		
		var column=$("#where_column").val();	
		
	/* 	if(where==null){
			$('#where_list').append(column+condition+" ");
		}
		
		else 
			if (!where.includes(column+condition+" ")) {
		$('#where_list').append(" "+value+" "+ column+condition);
		}
		 else{
			 alert("Condition alreday added");
		 }
		  */
		
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


function fire_ajax_submit(value) {

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
	<div class="container-fluid flex-grow-1">

		<% List<String> table= (List<String>)request.getAttribute("table");
        %>
		<nav class="navbar navbar-light navbar-expand-md bg-light">
			<a href="/" class="navbar-brand">Query Addition</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#collapsingNavbar3">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="navbar-collapse collapse" id="collapsingNavbar3">
				<ul class="navbar-nav justify-content-center">
					<li class="nav-item active"><a class="nav-link" href="/">Home</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="allQuery">QueryList</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="/">Add
							Query</a></li>
				</ul>
				<ul class="nav navbar-nav ml-auto w-100 justify-content-end">
					<li class="nav-item"><a class="nav-link" href="#">Right</a></li>
				</ul>
			</div>
		</nav>
		<section class="container-fluid flex-grow-1">
			<div class="row">
				<div class="col-sm-8 text-left">
					<form method="post" action="saveDetails">
						<div class="form-group">
							<label for="email">Title:</label> <input type="text"
								class="form-control" id="title" placeholder="Enter Title"
								name="Title">
						</div>
						<div class="form-group">
							<label for="col_no">Column No:</label> <input type="number"
								class="form-control" id="col_no" placeholder="Enter Column NO"
								name="col_no">
						</div>
						<div class="form-group">
							<label for="col_no">Column NAME:</label> <input type="text"
								class="form-control" id="col_name"
								placeholder="Enter Column Names" name="col_name">
						</div>

						<div class="form-group">
							<label for="col_type">Column Type:</label> <input type="text"
								class="form-control" id="col_type"
								placeholder="Enter Column Names" name="col_type">
						</div>
						<div class="form-group">
							<label for="sql_query">Sql Query:</label> <select id="table_name">
								<% for(String t : table){ %>
								<option value="<%=t%>"><%=t%></option>
								<%} %>
							</select> <select id="column_name"></select>
							<button type="button" id="selected_column">ADD</button>
							<button type="button" id="lists">ADD1</button>
							<p id="fields"></p>


						</div>
						<div class="form-group" id="whereGroup">
							<label for="formGroupExampleInput">Where</label> <select
								id="where_column"></select> <input type="text"
								class="form-control" id="condition"
								placeholder="Enter Condition" name="col_type">
							<p id="where_list"></p>
							<button type="button" id="where_condition" onclick="where_clause('AND')">AND</button>
							<button type="button" id="where_condition" onclick="where_clause('OR')">OR</button>
							<button type="button" id="lists">ADD1</button>
						</div>
						<div class="form-group" id="JoinGroup">
							<label for="formGroupExampleInput">Example label</label> <select
								id="where_table1"
								onchange="column_list('where_column1',this.value)">
							</select><select id="where_column1"></select> <select id="condition">
								<option value="&lt;">&lt;</option>
								<option value="&lt;">&gt;</option>
							</select> <select id="where_table2"
								onchange="column_list('where_column2',this.value)">
							</select><select id="where_column2"></select>

						</div>

						<input type="submit" value="Submit">
					</form>
				</div>
				<div class="col-md-3 order-md-1 pt-3">
					<div class="bg-faded mb-3">
						<h5 class="card-header">List of things</h5>
						<div class="card-body">
							<h6>Ain't nobody got time for:</h6>
							1. That
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- <footer class="bg-dark text-white mt-4">
    <div class="container-fluid py-3">
        <div class="row">
            <div class="col-md-3">
                <h5>Footer</h5></div>
            <div class="col-md-3"></div>
            <div class="col-md-3"></div>
            <div class="col-md-3"></div>
        </div>
        <div class="row">
            <div class="col-md-6">I stay at the bottom of the viewport! <span class="small"><br>Unless the page content pushes me further.</span></div>
            <div class="col-md-3"></div>
            <div class="col-md-3 text-right small align-self-end">©2017 Brand, Inc.</div>
        </div>
    </div>
</footer>
 -->
	</div>












</body>
</html>
