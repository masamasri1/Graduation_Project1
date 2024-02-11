<?php 
//header("Access-Control-Allow-Origin: *");
 //header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With, Access-Control-Allow-Origin");
 //header("Access-Control-Allow-Methods: POST, OPTIONS , GET");
  $dsn = "localhost" ;
$user = "root" ;
$pass = "" ; 
$databas="onduty";

$con= new mysqli($dsn,$user,$pass,$databas);

?>