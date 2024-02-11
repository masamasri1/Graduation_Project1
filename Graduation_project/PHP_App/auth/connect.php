  <?php 
 
  $dsn = "localhost" ;
$user = "root" ;
$pass = "" ; 
$databas="onduty";
   $con= new mysqli($dsn,$user,$pass,$databas);

   if ($con->connect_error) {
    die("Connection failed: " . $con->connect_error);
}

 ?>