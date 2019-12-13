<%@page import="java.util.ArrayList"%>
<%@page import="com.av.model.QueryDetails"%>
<html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*,com.av.model.QueryDetails,com.av.model.QueryPair" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
  <style>
  body {
  min-height: 100vh; 
}
  </style>
</head>
<body>
<div class="container-fluid flex-grow-1">


<nav class="navbar navbar-light navbar-expand-md bg-light">
    <a href="/" class="navbar-brand">Brand</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsingNavbar3">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="navbar-collapse collapse" id="collapsingNavbar3">
        <ul class="navbar-nav justify-content-center">
            <li class="nav-item active">
                <a class="nav-link" href="/">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="allQuery">Query List</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="/">Add Query</a>
            </li>
        </ul>
        <ul class="nav navbar-nav ml-auto w-100 justify-content-end">
            <li class="nav-item">
                <a class="nav-link" href="#">Right</a>
            </li>
        </ul>
    </div>
</nav>
<section class="container-fluid flex-grow-1">
    <div class="row">
            <div class="col-sm-8 text-left"> 
       <table class="table table-dark table-hover">
    <thead>
      <tr>
     	 <th>id</th>
        <th>Title</th>
        <th>Sql Query</th>
        <th>Column Name</th>
        <th>Column No</th>
        <th>graphs</th>
      </tr>
    </thead>
    <tbody>
     
  <% 
      List<QueryDetails> queryList=( List<QueryDetails> )request.getAttribute("list");
     
 for(QueryDetails q : queryList){
      %>
      <tr>
     <td><%=q.getId() %></td>
       <td><%=q.getTitle() %></td>
         <td><%=q.getSql_query() %></td>
           <td><%=q.getCol_name() %></td>
             <td><%=q.getCol_no() %></td>
             <td><a href="/graphs?r_id=<%=q.getId() %>&type=1"> Bar</a>,
             <a href="/graphs?r_id=<%=q.getId() %>&type=2"> AreaChart</a>,
             <a href="/graphs?r_id=<%=q.getId() %>&type=3"> Bubble</a>,
             <a href="/graphs?r_id=<%=q.getId() %>&type=4"> Scatter</a>,
             <a href="/graphs?r_id=<%=q.getId() %>&type=5"> Histrogram</a>,
             <a href="/graphs?r_id=<%=q.getId() %>&type=6"> Column</a>,
             <a href="/graphs?r_id=<%=q.getId() %>&type=7"> Pie</a>,
             <a href="/graphs?r_id=<%=q.getId() %>&type=8"> Donut</a>
             </td> 
             <%-- <td> <a href="/graphs?r_id=<%=q.getId() %>"> Graphs</a>
             </td> --%> 
             
      </tr>
      
      <%} %>
  
    </tbody>
  </table>

    </div>
        <div class="col-md-3 order-md-1 pt-3">
            <div class="bg-faded mb-3">
                <h5 class="card-header">List of things</h5>
                <div class="card-body">
                    <h6>Ain't nobody got time for:</h6> 1. That
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
</footer> -->

</div>












</body>
</html>
