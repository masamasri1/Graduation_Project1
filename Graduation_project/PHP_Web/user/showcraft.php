<?php
include 'connect.php';

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With, Access-Control-Allow-Origin");
header("Access-Control-Allow-Methods: POST, OPTIONS, GET");

// Check the database connection
if ($con->connect_error) {
    die(json_encode(array("status" => "fail", "message" => "Connection failed: " . $con->connect_error)));
}

$sql = "SELECT * FROM craftmen";
$result = $con->query($sql);

// Check for SQL errors
if ($result === false) {
    die(json_encode(array("status" => "fail", "message" => "SQL error: " . $con->error)));
}

// Check if the query was successful (at least one row found)
if ($result->num_rows > 0) {
    // Fetch the data
    $craftmen = $result->fetch_all(MYSQLI_ASSOC);
    echo json_encode(array("status" => "success", "data" => $craftmen));
} else {
    // No rows found
    echo json_encode(array("status" => "fail", "message" => "No data found"));
}

// Close the connection
$con->close();
?>
