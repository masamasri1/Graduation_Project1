<?php

$host = 'localhost';
$db = 'onduty';
$user = 'root';
$pass = '';

// Create a connection
$conn = new mysqli($host, $user, $pass, $db);

// Check the connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Function to fetch reservation details
function fetchReservationDetails($conn, $resId) {
    $sqlQuery = "SELECT r.res_id, r.start_date, r.end_date, c.price, c.emergency, 
                        c.user_id AS craftmen_id, c.user_name AS craftmen_name, c.craftmen_phone, 
                        u.user_name AS user_name
                 FROM reser r
                 JOIN craftmen c ON r.craftmen_id = c.user_id
                 JOIN users u ON r.user_id = u.user_id
                 WHERE r.res_id = '$resId'";

    error_log("SQL Query: $sqlQuery"); // Log the SQL query

    $result = $conn->query($sqlQuery);

    if ($result === FALSE) {
        error_log("Error in fetchReservationDetails query: " . $conn->error);
        return null;
    }

    if ($result->num_rows > 0) {
        // Fetch data from the result set
        $reservationDetails = $result->fetch_assoc();

        // Log the fetched data
        error_log("Fetched Data: " . json_encode($reservationDetails));

        return $reservationDetails;
    } else {
        error_log("No data found for the reservation ID: $resId");
        return ['error' => 'No data found for the given reservation ID'];
    }
}

// Validate input parameters
$resId = isset($_POST['res_id']) ? $_POST['res_id'] : null;

if (empty($resId)) {
    header('Content-Type: application/json');
    echo json_encode(['error' => 'Reservation ID is empty'], JSON_NUMERIC_CHECK);
    exit;
}

// Fetch reservation details
$reservationDetails = fetchReservationDetails($conn, $resId);

if ($reservationDetails !== null && !isset($reservationDetails['error'])) {
    // Output the data as JSON (you can modify this based on your needs)
    header('Content-Type: application/json');
    echo json_encode(['reservationDetails' => $reservationDetails, 'debug' => 'Print debug information'], JSON_NUMERIC_CHECK);
} else {
    header('Content-Type: application/json');
    echo json_encode($reservationDetails, JSON_NUMERIC_CHECK);
}

// Close the database connection
$conn->close();

?>
