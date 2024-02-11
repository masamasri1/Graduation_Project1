<?php
include 'connect.php';

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With, Access-Control-Allow-Origin');
header('Access-Control-Allow-Methods: POST, OPTIONS, GET');

// Check if it's a POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Check if 'res_id' is set in the POST parameters
    if (isset($_POST['res_id'])) {
        // Get the res_id from the POST parameters
        $res_id = $_POST['res_id'];

        // Start a transaction to ensure data consistency
        $con->begin_transaction();

        try {
            // Prepare the SQL statement to delete the reservation
            $deleteReservationSQL = "DELETE FROM reservation WHERE res_id = ?";
            $stmtReservation = $con->prepare($deleteReservationSQL);
            $stmtReservation->bind_param("i", $res_id);
            $stmtReservation->execute();

            // Commit the transaction if the query is successful
            $con->commit();

            // Check if the query was successful
            if ($stmtReservation->affected_rows > 0) {
                // Successful deletion
                echo json_encode(array("status" => "success", "message" => "Reservation deleted successfully"));
            } else {
                // No rows affected, reservation not found
                echo json_encode(array("status" => "fail", "message" => "Reservation not found or already deleted"));
            }
        } catch (Exception $e) {
            // Rollback the transaction in case of an error
            $con->rollback();
            echo json_encode(array("status" => "error", "message" => "Error during deletion: " . $e->getMessage()));
        } finally {
            // Close the statement and connection
            $stmtReservation->close();
            $con->close();
        }
    } else {
        // 'res_id' not set in the POST parameters
        echo json_encode(array("status" => "fail", "message" => "'res_id' parameter is required"));
    }
} else {
    // Only handle POST requests
    echo json_encode(array("status" => "fail", "message" => "Only  allowed"));
}
?>
