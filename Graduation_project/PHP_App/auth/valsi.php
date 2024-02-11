<?php
include 'connect.php';
$gmail1 = $_POST["craftmen_gmail"];
$sqll="SELECT * FROM craftmen WHERE craftmen_gmail='$gmail1' ";
$ress=$con->query($sqll);
    if ($ress->num_rows >0){
        echo json_encode(array("emailfound" => true ));
    } else {
        echo json_encode(array("success" => false));
    }
   ?>