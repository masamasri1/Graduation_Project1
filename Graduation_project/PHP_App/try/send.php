<?php
include 'connn.php';
$email=filterRequest('gmail');
$verfiycode  = rand(1000,9999);
$stmt = $con->prepare("SELECT * FROM  Users  WHERE gmail =  ? ");
$stmt->execute(array($email));
$count = $stmt->rowCount();
//result($count);
if($count > 0){
  $data = array(
    "gmail" => $email,
);
   //$res =$con->query("UPDATE `user` SET `password` = '$password',`confirm_password` = '$confirm_password' WHERE `email` = '$email'");
   updatedata("Users",$data,"gmail = '$email'",false);
   sendEmail($email,"varify","varify is : $verfiycode");
   echo json_encode(array("status" => "success"));
} else {
    echo json_encode(array("status" => "failure"));
  

}