<?php
include 'connect.php';

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With, Access-Control-Allow-Origin");
header("Access-Control-Allow-Methods: POST, OPTIONS, GET");

// Check if it's a POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Check if 'user_name' is set in the POST parameters
    if (isset($_POST['user_name'])) {
        // Get the search query from the POST parameters
        $user_name = '%' . $_POST['user_name'] . '%';

        $sql = "SELECT 
                    reservation.*, 
                    craftmen.user_name AS craftmen_user_name, 
                    users.user_name AS users_user_name,
                    craftmen.*,
                    users.*
                FROM reservation
                JOIN craftmen ON reservation.craftmen_id = craftmen.user_id
                JOIN users ON reservation.user_id = users.user_id
                WHERE users.user_name LIKE ?";

        $stmt = $con->prepare($sql);

        // Error handling for statement preparation
        if (!$stmt) {
            die(json_encode(array("status" => "error", "message" => "Error in preparing the statement: " . $con->error)));
        }

        // Bind the parameter and execute the query
        $stmt->bind_param("s", $user_name);
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

        // Close the statement
        $stmt->close();
    } else {
        // 'user_name' not set in the POST parameters
        echo json_encode(array("status" => "fail", "message" => "'user_name' parameter is required"));
    }
} else {
    // Only handle POST requests
    echo json_encode(array("status" => "fail", "message" => "Only POST requests are allowed"));
}

// Close the connection
$con->close();
?>
