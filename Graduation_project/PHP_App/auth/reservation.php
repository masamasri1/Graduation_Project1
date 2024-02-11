
<?php
$host = 'localhost';
$db   = 'onduty';
$user = 'root';
$pass = '';

// Create a connection
$conn = new mysqli($host, $user, $pass, $db);

// Check the connection
if ($conn->connect_error) {
    die(json_encode(['status' => 'error', 'message' => 'Connection failed: ' . $conn->connect_error]));
}

// Check if the user_id is set in the POST request
if (!isset($_POST['craftmen_id'])) {
    die(json_encode(['status' => 'error', 'message' => 'Craftsman ID not provided']));
}

// Craftsmen ID to search for
$craftmen_id = $conn->real_escape_string($_POST['craftmen_id']);

// Query to retrieve data
$sql = "SELECT reservation.res_id ,reservation.start_date, reservation.end_date,reservation.duration
        FROM reservation
        JOIN craftmen ON reservation.craftmen_id = craftmen.user_id
        WHERE reservation.craftmen_id = '$craftmen_id'";

$result = $conn->query($sql);

// Check for query execution error
if (!$result) {
    die(json_encode(['status' => 'error', 'message' => 'Query failed: ' . $conn->error]));
}

// Check if there are any results
if ($result->num_rows > 0) {
    // Output data of each row
    $data = array();
    while ($row = $result->fetch_assoc()) {
        $res_id = $row['res_id'];
        $start_date = $row['start_date'];
        $end_date = $row['end_date'];
        $duration=$row['duration'];

        // Use $start_date and $end_date as needed
        // For example, you can store them in an array for later use
        $data[] = ['res_id' => $res_id,'start_date' => $start_date, 'end_date' => $end_date,'duration'=>$duration];
    }

    // Send the response back to the Flutter app
    echo json_encode(['status' => 'success', 'data' => $data]);
} else {
    echo json_encode(['status' => 'error', 'message' => 'No reservations found for the given craftsman_id']);
}

// Close the database connection
$conn->close();
?>
