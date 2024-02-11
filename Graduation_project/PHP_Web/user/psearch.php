<?php
include 'connect.php';

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With, Access-Control-Allow-Origin');
header('Access-Control-Allow-Methods: POST, OPTIONS, GET');

// Check if it's a POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Check if 'price' is set in the POST parameters
    if (isset($_POST['price'])) {
        // Get the search query from the POST parameters
        $price = '%' . $_POST['price'] . '%';

        // Prepare the SQL statement with a WHERE clause for search
        $sql = "SELECT * FROM craftmen WHERE price LIKE ?";

        $stmt = $con->prepare($sql);

        // Error handling for statement preparation
        if (!$stmt) {
            die(json_encode(array("status" => "error", "message" => "Error in preparing the statement: " . $con->error)));
        }

        // Bind the parameter and execute the query
        $stmt->bind_param("s", $price);
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
            echo json_encode(array("status" => "fail", "message" => "No data found"));
        }

        // Close the result set and statement
        $result->close();
        $stmt->close();
    } else {
        // 'price' not set in the POST parameters
        echo json_encode(array("status" => "fail", "message" => "'price' parameter is required"));
    }
} else {
    // Only handle POST requests
    echo json_encode(array("status" => "fail", "message" => "Only POST requests are allowed"));
}

// Close the database connection
$con->close();
?>
