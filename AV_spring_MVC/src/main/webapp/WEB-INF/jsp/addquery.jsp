
<!DOCTYPE html>
<html lang="en">
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
                <a class="nav-link" href="allQuery">QueryList</a>
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
      <form method="post" action="saveDetails"> 
      <div class="form-group">
      <label for="email">Title:</label>
      <input type="text" class="form-control" id="title" placeholder="Enter Title" name="Title">
    </div>
 <div class="form-group">
      <label for="col_no">Column No:</label>
      <input type="number" class="form-control" id="col_no" placeholder="Enter Column NO" name="col_no">
    </div>
 <div class="form-group">
      <label for="col_no">Column NAME:</label>
      <input type="text" class="form-control" id="col_name" placeholder="Enter Column Names" name="col_name">
    </div>  
    
     <div class="form-group">
      <label for="col_type">Column Type:</label>
      <input type="text" class="form-control" id="col_type" placeholder="Enter Column Names" name="col_type">
    </div>
     <div class="form-group">
      <label for="sql_query">Sql Query:</label>
      <input type="text" class="form-control" id="sql_query" placeholder="Enter SQL Query" name="sql_query">
    </div>
  
   

    <input type="submit" value="Submit">
</form>
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
</footer>
 -->
</div>












</body>
</html>
