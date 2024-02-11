<?php
include 'connect.php';
$gmail1 = $_POST["gmail"];
$sqll="SELECT * FROM Users WHERE gmail='$gmail1' ";
$ress=$con->query($sqll);
    if ($ress->num_rows >0){
        echo json_encode(array("emailfound" => true ));
    } else {
        echo json_encode(array("success" => false));
    }
   ?>