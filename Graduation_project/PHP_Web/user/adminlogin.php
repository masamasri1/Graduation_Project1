<?php 
include 'connect.php';
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With, Access-Control-Allow-Origin");
header("Access-Control-Allow-Methods: POST, OPTIONS , GET");
$username = $_POST["admin_gmail"];
$password1 = $_POST["admin_pass"];
$sql="SELECT * FROM admin WHERE admin_gmail ='$username'AND admin_pass='$password1' ";
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
   ?>