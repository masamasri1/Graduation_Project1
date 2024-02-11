<?php

// Database configuration
$host = 'localhost';
$db   = 'onduty';
$user = 'root';
$pass = '';

// Create a connection
$conn = new mysqli($host, $user, $pass, $db);

// Check the connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Assuming you have the craftmen_id available (replace 'YOUR_CRAFTSMAN_ID' with the actual ID)
$craftmenId = $_POST['craftmen_id'];

// Fetch information from the reservation and users tables
$sql = "SELECT reservation.start_date, reservation.end_date, users.user_name, users.phone_number,users.gmail,reservation.res_id
        FROM reservation
        JOIN users ON reservation.user_id = users.user_id
        WHERE reservation.craftmen_id = '$craftmenId'";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Craftsman and user information found
    $response = array();
    while ($row = $result->fetch_assoc()) {
        $response[] = array(
            'start_date' => $row['start_date'],
            'end_date' => $row['end_date'],
            'user_name' => $row['user_name'],
            'phone_number' => $row['phone_number'],
            'gmail' => $row['gmail'],
            'res_id' => $row['res_id']
        );
    }
    echo json_encode($response);
} else {
    // No information found
    echo json_encode(array("status" => "error", "message" => "Craftsman information not found"));
}

// Close the connection
$conn->close();

?>
