<?php

include 'connn.php';
$email = filterRequest("gmail");
$verfiycode = filterRequest("varify");

$stmt = $con->prepare ("SELECT * FROM Users  WHERE gmail = '$email' OR varify = '$verfiycode'");
$stmt->execute();
$count = $stmt->rowCount();
if($count > 0){
    echo json_encode(array("status" =>"success"));
}
else{
    echo json_encode(array("status" =>"fail"));
}