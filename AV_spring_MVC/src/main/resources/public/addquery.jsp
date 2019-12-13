<html>
<head>
    <title>spring boot form submit example</title>
</head>
<body>
<h2>Employee Details</h2>
<form method="post" action="saveDetails">   // saveDetails url mapping in EmployeeController
    Enter Employee Name : <input type="text" name="id"/>
    Enter Employee Email Address: <input type="email" name="title">
    <input type="submit" value="Submit">
</form>
</body>
</html>