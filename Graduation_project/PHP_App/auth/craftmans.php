<?php

// Turn ON PHP error reporting
error_reporting(E_ALL);
ini_set('display_errors', '1');

$servername = "localhost";
$username = "root";
$password = "";
$database = "onduty";

// Set headers for JSON response
header('Content-Type: application/json');

// Create a connection
$conn = new mysqli($servername, $username, $password, $database);

// Set the charset to UTF-8
$conn->set_charset("utf8");

// Check connection
if ($conn->connect_error) {
    echo json_encode(array("status" => "error", "message" => "Connection failed: " . $conn->connect_error));
    exit;
}

$response_data = [];

for ($jop_id = 1; $jop_id <= 10; $jop_id++) {
    $sql = "SELECT user_id,user_name, price, craftmen_phone ,craftmen_city,emergency,working_day FROM craftmen WHERE jop_id = $jop_id";
    $result = $conn->query($sql);

    if ($conn->error) {
        echo json_encode(array("status" => "error", "message" => $conn->error));
        exit;
    }

    $data_for_jop_id = [];

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $data_for_jop_id[] = array(
                "user_name" => $row["user_name"],
                "price" => $row["price"],
                "craftmen_phone" => $row["craftmen_phone"],
                "emergency" => $row["emergency"],
                "user_id" => $row["user_id"],
                "craftmen_city" => $row["craftmen_city"],
                "working_day" => $row["working_day"]
            );
        }
    }

    $response_data[$jop_id] = $data_for_jop_id;
}

// Always send a success status
echo json_encode(array("status" => "success", "data" => $response_data));

?>

