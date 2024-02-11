<?php

$host = 'localhost';
$username = 'root';
$password = '';
$database = 'onduty';

// Connect to the database
$conn = new mysqli($host, $username, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Log received data
file_put_contents('log.txt', 'Received data: ' . file_get_contents('php://input') . PHP_EOL, FILE_APPEND);

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (
        isset($_POST["user_name"]) && isset($_POST["craftmen_gmail"]) &&
        isset($_POST["craftmen_phone"]) && isset($_POST["password"]) &&
        isset($_POST["cpassword"]) && isset($_POST["craftmen_city"]) &&
        isset($_POST["emergency"]) && isset($_POST["working_day"])
    ) {
        $username = $_POST["user_name"];
        $gmail = $_POST["craftmen_gmail"];
        $phonenumber = $_POST["craftmen_phone"];
        $password = $_POST["password"];
        $cpassword = $_POST["cpassword"];
        $city = $_POST["craftmen_city"];
        $price = $_POST["price"];
        $emergency = $_POST["emergency"];
        $workingDay = $_POST["working_day"];

        // Add validation and sanitization for user input here to prevent SQL injection

        // Check if the password and confirm password match
        if ($password !== $cpassword) {
            echo json_encode(array("status" => "fail", "message" => "Passwords do not match"));
        } else {
            // Passwords match, so you can proceed with updating the profile
            // Perform an SQL UPDATE statement to update the user's profile
            $sql = "UPDATE craftmen SET craftmen_gmail = '$gmail', craftmen_phone = '$phonenumber', password = '$password', cpassword = '$cpassword', craftmen_city = '$city',  price = '$price', emergency = '$emergency', working_day = '$workingDay' WHERE user_name = '$username'";

            if ($conn->query($sql) === TRUE) {
                echo json_encode(array("status" => "success", "message" => "Profile updated successfully"));
            } else {
                echo json_encode(array("status" => "fail", "message" => "Error updating profile: " . $conn->error));
            }
        }
    } else {
        echo json_encode(array("status" => "fail", "message" => "Incomplete data received from Flutter app"));
    }
} else {
    echo json_encode(array("status" => "fail", "message" => "Only POST requests are allowed"));
}

// Close the database connection
$conn->close();
?>
