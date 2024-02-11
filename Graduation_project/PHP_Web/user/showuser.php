<?php
include 'connect.php';

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With, Access-Control-Allow-Origin");
header("Access-Control-Allow-Methods: POST, OPTIONS, GET");

$sql = "SELECT * FROM users";
$stmt = $con->prepare($sql);

// Execute the query
$stmt->execute();

// Get the result set
$result = $stmt->get_result();

// Check if the query was successful (at least one row found)
if ($result->num_rows > 0) {
    // Fetch the data
    $users = $result->fetch_all(MYSQLI_ASSOC);
    echo json_encode(array("status" => "success", "data" => $users));
} else {
    // No rows found
    echo json_encode(array("status" => "fail", "message" => "No data found"));
}

// Close the statement and connection
$stmt->close();
$con->close();
?>
