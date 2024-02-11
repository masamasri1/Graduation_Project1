<?php
include 'connn.php';
$email = filterRequest("admin_gmail");
$password = filterRequest("admin_pass");
$confirm_password = filterRequest("admin_cpass");
$data = array ("admin_pass" => $password,"admin_cpass"=>$confirm_password);
updateData("admin",$data,"admin_gmail = '$email'");