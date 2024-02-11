<?php
session_start();
include 'connect.php';

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With, Access-Control-Allow-Origin");
header("Access-Control-Allow-Methods: POST, OPTIONS, GET");

// Assuming filterRequest is an associative array, use $_POST to access POST data
$username = $_POST["user_name"];
$password1 = $_POST["password"];
$password2 = $_POST["cpassword"];
$phone_number = $_POST["phone_number"];
$gmail = $_POST["gmail"];
$city = $_POST["city"];

$stmt = $con->prepare("INSERT INTO `users`(`user_name`, `gmail`, `phone_number`, `password`, `cpassword`, `city`) 
                      VALUES (?, ?, ?, ?, ?, ?)");

$stmt->execute(array($username, $gmail, $phone_number, $password1, $password2, $city));

$count = $stmt->rowCount();

if ($count > 0) {
    echo json_encode(array("status" => "success"));
} else {
    echo json_encode(array("status" => "fail"));
}
?>
