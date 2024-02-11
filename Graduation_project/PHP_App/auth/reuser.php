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
$userId = $_POST['user_id'];

// Fetch information from the reservation and users tables
$sql = "SELECT reservation.start_date, reservation.end_date, reservation.craftmen_id,craftmen.user_name,reservation.res_id ,craftmen.price,reservation.duration
        FROM reservation
        JOIN craftmen ON reservation.craftmen_id = craftmen.user_id
        WHERE reservation.user_id = '$userId'";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Craftsman and user information found
    $response = array();
    while ($row = $result->fetch_assoc()) {
        $response[] = array(
            'start_date' => $row['start_date'],
            'end_date' => $row['end_date'],
            'user_name' => $row['user_name'],
            'res_id'=>$row['res_id'],
            'price'=>$row['price'],
            'duration'=>$row['duration'],
            'craftmen_id'=>$row['craftmen_id'],
           
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
