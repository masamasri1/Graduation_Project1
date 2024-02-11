<?php
include 'connn.php';
$email = filterRequest("gmail");
$password = filterRequest("password");
$confirm_password = filterRequest("cpassword");
$data = array ("password" => $password,"cpassword"=>$confirm_password);
updateData("Users",$data,"gmail = '$email'");