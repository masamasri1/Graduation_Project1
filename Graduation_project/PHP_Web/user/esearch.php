<?php
include 'connect.php';

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With, Access-Control-Allow-Origin');
header('Access-Control-Allow-Methods: POST, OPTIONS, GET');

// Check if it's a POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Check if 'emergency' is set in the POST parameters
    if (isset($_POST['emergency'])) {
        // Get the search query from the POST parameters
        $emergency = '%' . $_POST['emergency'] . '%';

        // Prepare the SQL statement with a WHERE clause for search
        $sql = "SELECT * FROM craftmen WHERE LOWER(emergency) LIKE LOWER(?)";

        $stmt = $con->prepare($sql);

        // Error handling for statement preparation
        if (!$stmt) {
            die(json_encode(array("status" => "error", "message" => "Error in preparing the statement: " . $con->error)));
        }

        // Bind the parameter and execute the query
        $stmt->bind_param("s", $emergency);
        $stmt->execute();

        // Get the result set
        $result = $stmt->get_result();

        // Check if the query was successful (at least one row found)
        if ($result->num_rows > 0) {
            // Fetch the data
            $craftsmen = $result->fetch_all(MYSQLI_ASSOC);
            echo json_encode(array("status" => "success", "data" => $craftsmen));
        } else {
            // No rows found
            echo json_encode(array("status" => "fail", "message" => "No data found for emergency: $emergency"));
        }

        // Close the result set and statement
        $result->close();
        $stmt->close();
    } else {
        // 'emergency' not set in the POST parameters
        echo json_encode(array("status" => "fail", "message" => "'emergency' parameter is required"));
    }
} else {
    // Only handle POST requests
    echo json_encode(array("status" => "fail", "message" => "Only POST requests are allowed"));
}

// Close the database connection
$con->close();
?>
