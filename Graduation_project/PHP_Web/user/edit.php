<?php
include 'connect.php';

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With, Access-Control-Allow-Origin');
header('Access-Control-Allow-Methods: POST, OPTIONS, GET');

// Check if it's a POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Check if 'user_id' is set in the POST parameters
    if (isset($_POST['user_id'])) {
        // Get the user_id and other updated user data from the POST parameters
        $user_id = $_POST['user_id'];
        $user_name = $_POST['user_name'];
        $gmail = $_POST['gmail'];
        $phone_number = $_POST['phone_number'];
        $password = $_POST['password'];
        $cpassword = $_POST['cpassword'];
        $city = $_POST['city'];

        // Example SQL statement to update user information
        $sql = "UPDATE users SET user_name = ?, gmail = ?, phone_number = ?, password = ?, cpassword = ?, city = ? WHERE user_id = ?";

        $stmt = $con->prepare($sql);

        // Error handling for statement preparation
        if (!$stmt) {
            die(json_encode(array("status" => "error", "message" => "Error in preparing the statement: " . $con->error)));
        }

        // Bind the parameters
        $stmt->bind_param("ssssssi", $user_name, $gmail, $phone_number, $password, $cpassword, $city, $user_id);
        $stmt->execute();

        // Check if the query was successful
        if ($stmt->affected_rows > 0) {
            // Successful update
            echo json_encode(array("status" => "success", "message" => "User updated successfully"));
        } else {
            // No rows affected, user not found or no changes
            echo json_encode(array("status" => "fail", "message" => "User not found or no changes made"));
        }

        // Close the statement and connection
        $stmt->close();
        $con->close();
    } else {
        // 'user_id' not set in the POST parameters
        echo json_encode(array("status" => "fail", "message" => "'user_id' parameter is required"));
    }
} else {
    // Only handle POST requests
    echo json_encode(array("status" => "fail", "message" => "Only POST requests are allowed"));
}
?>
