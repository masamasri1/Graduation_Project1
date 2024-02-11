<?php


include 'connect.php';

    $username = $_POST["user_name"];
    $gmail1 = $_POST["gmail"];
    $phonenumber = $_POST["phone_number"];
    $password1 = $_POST["password"];
    $cpassword1 = $_POST["cpassword"];
    $city1 = $_POST["city"];
     $sql="INSERT INTO Users SET  user_name ='$username', gmail='$gmail1'  , phone_number = '$phonenumber' , password ='$password1', cpassword='$cpassword1', city='$city1'";
     $res=$con->query($sql);
    if ($res){
        echo json_encode(array("success" => true ));}
        else {
            // Echo the MySQL error
            echo json_encode(array("success" => false, "error" => $con->error));
        }
    // } else {
    //     echo json_encode(array("success" => false));
    // }
   


?>

