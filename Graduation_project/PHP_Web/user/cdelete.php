<?php
include 'connect.php';

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With, Access-Control-Allow-Origin');
header('Access-Control-Allow-Methods: POST, OPTIONS, GET');

// Check if it's a POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Check if 'user_id' is set in the POST parameters
    if (isset($_POST['user_id'])) {
        // Get the user_id from the POST parameters
        $user_id = $_POST['user_id'];

        // Start a transaction to ensure data consistency
        $con->begin_transaction();

        try {
            // Prepare the SQL statement to delete reservations associated with the user
            $deleteReservationsSQL = "DELETE FROM reservation WHERE craftmen_id = ?";
            $stmtReservations = $con->prepare($deleteReservationsSQL);
            $stmtReservations->bind_param("i", $user_id);
            $stmtReservations->execute();

            // Prepare the SQL statement to delete the user
            $deleteUserSQL = "DELETE FROM craftmen WHERE user_id = ?";
            $stmtUser = $con->prepare($deleteUserSQL);
            $stmtUser->bind_param("i", $user_id);
            $stmtUser->execute();

            // Commit the transaction if everything is successful
            $con->commit();

            // Check if the queries were successful
            if ($stmtReservations->affected_rows > 0 && $stmtUser->affected_rows > 0) {
                // Successful deletion
                echo json_encode(array("status" => "success", "message" => "User and associated reservations deleted successfully"));
            } else {
                // No rows affected, user not found
                echo json_encode(array("status" => "fail", "message" => "User not found or already deleted"));
            }
        } catch (Exception $e) {
            // Rollback the transaction in case of an error
            $con->rollback();
            echo json_encode(array("status" => "error", "message" => "Error during deletion: " . $e->getMessage()));
        } finally {
            // Close the statements and connection
            $stmtReservations->close();
            $stmtUser->close();
            $con->close();
        }
    } else {
        // 'user_id' not set in the POST parameters
        echo json_encode(array("status" => "fail", "message" => "'user_id' parameter is required"));
    }
} else {
    // Only handle POST requests
    echo json_encode(array("status" => "fail", "message" => "Only POST requests are allowed"));
}
?>
