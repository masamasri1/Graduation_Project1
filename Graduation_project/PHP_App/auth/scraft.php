<?php

// Database configuration
// $servername = "localhost";
// $username = "root";
// $password = "";
// $database = "onduty";

// // Connect to the database
// $conn = new mysqli($servername, $username, $password, $database);

// // Check connection
// if ($conn->connect_error) {
//     die("Connection failed: " . $conn->connect_error);
// }

include 'connect.php';

// Get the POST data
$user_name = $_POST["user_name"];
$craftmen_gmail = $_POST["craftmen_gmail"];
$craftmen_phone = $_POST["craftmen_phone"];
$password = $_POST["password"];
$cpassword = $_POST["cpassword"];
$craftmen_city = $_POST["craftmen_city"];
$jop_id = $_POST["jop_id"];
$job = $_POST["job"];
$price = $_POST["price"];
$emergency = $_POST["emergency"];
$working_day = $_POST["working_day"];

// Passwords should match
// if($password !== $cpassword) {
//     echo json_encode(['status' => 'error', 'message' => 'Passwords do not match.']);
//     exit;
// }

// Hash the password before storing in database
// $hashed_password = password_hash($password, PASSWORD_DEFAULT);

// Insert into database
$sql = "INSERT INTO craftmen SET user_name='$user_name', craftmen_gmail='$craftmen_gmail', craftmen_phone='$craftmen_phone', password='$password', cpassword='$cpassword', craftmen_city='$craftmen_city', job='$job', jop_id='$jop_id', price='$price', emergency='$emergency', working_day='$working_day' ";
$res=$con->query($sql);
if ($res){
    echo json_encode(array("success" => true ));
}  else {
    // Echo the MySQL error
    echo json_encode(array("success" => false, "error" => $con->error));
}


// $stmt = $conn->prepare($sql);
// $stmt->bind_param("ssssssissss", $user_name, $craftmen_gmail, $craftmen_phone, $hashed_password, $cpassword, $craftmen_city, $jop_id, $job, $price, $emergency, $working_day);

// if ($stmt->execute()) {
//     echo json_encode(['status' => 'success', 'message' => 'Signup successful']);
// } else {
//     echo json_encode(['status' => 'error', 'message' => 'Error during signup: ' . $stmt->error]);
// }

// $stmt->close();
// $conn->close();

?>
