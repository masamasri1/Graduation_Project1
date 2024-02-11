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
$phone_number = $_POST["craftmen_phone"];
$gmail = $_POST["craftmen_gmail"];
$city = $_POST["craftmen_city"];
$jobId = $_POST["jop_id"];
$job = $_POST["job"];
$price = $_POST["price"];
$emergency = $_POST["emergency"];
$workingday = $_POST["working_day"];
$gender = $_POST["gender"];

$stmt = $con->prepare("INSERT INTO `craftmen`(`user_name`, `craftmen_gmail`, `craftmen_phone`,`gender`, `password`, `cpassword`, `craftmen_city`, `jop_id`, `job`, `price`, `emergency`, `working_day`) 
                      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

$stmt->execute(array($username, $gmail, $phone_number,$gender, $password1, $password2, $city, $jobId, $job, $price, $emergency, $workingday));

$count = $stmt->rowCount();

if ($count > 0) {
    echo json_encode(array("status" => "success"));
} else {
    echo json_encode(array("status" => "fail"));
}
?>
