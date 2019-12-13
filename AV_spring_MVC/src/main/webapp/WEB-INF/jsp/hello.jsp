<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    
    <link href="/css/main.css" rel="stylesheet">
</head>
<script>

var modelAttributeValue = '${data}';

alet(modelAttributeValue);
</script>
<body>
   
  <c:if test="${not empty data}">  
    
       <table class="table table-striped">
            <caption><h3>Result (People):</h3></caption>
            <thead>
                <tr class="tr tr-success">
                    <td>Id</td>
                    <td>Name</td>
                    <td>PIN</td>
                </tr>   
            </thead>
            <tbody>
                <c:forEach items="${data}" var="temp">
                  <tr>
                   <td>${temp.getI1()}</td>
                        <td> ${temp.getCol_2()}</td>
                        <td> ${temp.getCol_3()}</td>
                        </tr>
                </c:forEach>
            </tbody>
        </table>
        </c:if>
    <script src="/js/main.js"></script>
</body>
</html>