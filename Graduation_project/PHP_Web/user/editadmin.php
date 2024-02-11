<?php
include 'connect.php';

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With, Access-Control-Allow-Origin');
header('Access-Control-Allow-Methods: POST, OPTIONS, GET');

// Check if it's a POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Check if 'admin_id' is set in the POST parameters
    if (isset($_POST['admin_id'])) {
        // Get the admin_id and other updated user data from the POST parameters
        $admin_id = $_POST['admin_id'];
        $user_name = $_POST['admin_name'];
        $gmail = $_POST['admin_gmail'];
        $phone_number = $_POST['admin_phone'];
        $password = $_POST['admin_pass'];
        $cpassword = $_POST['admin_cpass'];

        // Example SQL statement to update user information
        $sql = "UPDATE admin SET admin_name = ?, admin_gmail = ?, admin_phone = ?, admin_pass = ?, admin_cpass = ? WHERE admin_id = ?";

        $stmt = $con->prepare($sql);

        // Error handling for statement preparation
        if (!$stmt) {
            die(json_encode(array("status" => "error", "message" => "Error in preparing the statement: " . $con->error)));
        }

        // Bind the parameters
        $stmt->bind_param("sssssi", $user_name, $gmail, $phone_number, $password, $cpassword, $admin_id);
        $stmt->execute();

        // Error handling for SQL execution
        if ($stmt->error) {
            echo json_encode(array("status" => "error", "message" => "Error in SQL execution: " . $stmt->error));
        } else {
            // Check if the query was successful
            if ($stmt->affected_rows > 0) {
                // Successful update
                echo json_encode(array("status" => "success", "message" => "User updated successfully"));
            } else {
                // No rows affected, user not found or no changes
                echo json_encode(array("status" => "fail", "message" => "User not found or no changes made"));
            }
        }

        // Close the statement and connection
        $stmt->close();
        $con->close();
    } else {
        // 'admin_id' not set in the POST parameters
        echo json_encode(array("status" => "fail", "message" => "'admin_id' parameter is required"));
    }
} else {
    // Only handle POST requests
    echo json_encode(array("status" => "fail", "message" => "Only POST requests are allowed"));
}
?>
