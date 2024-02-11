<?php
include 'connn.php';
$email = filterRequest("craftmen_gmail");
$password = filterRequest("password");
$confirm_password = filterRequest("cpassword");
$data = array ("password" => $password,"cpassword"=>$confirm_password);
updateData("craftmen",$data,"craftmen_gmail = '$email'");