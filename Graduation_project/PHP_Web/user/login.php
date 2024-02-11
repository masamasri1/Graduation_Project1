<?php 
include 'connect.php';
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type, Authorization');
$username = $_POST["craftmen_gmail"];
$password1 = $_POST["password"];
$sql="SELECT * FROM craftmen WHERE craftmen_gmail ='$username'AND password='$password1' ";
$res=$con->query($sql);
    if ($res->num_rows>0){
      $logi=array();
      while($row=$res->FETCH_ASSOC()){
        $logi[]=$row;

      }
        echo json_encode(array("success" => true ));
    } else {
        echo json_encode(array("success" => false));
    }
   