<?php
include 'connect.php';

// Assuming 'craftmen_id' is the name of the POST parameter
$craftmen_id = isset($_POST['craftmen_id']) ? intval($_POST['craftmen_id']) : 0;

if ($craftmen_id > 0) {
    $sql = "SELECT 
                rate.rating
            FROM rate
            JOIN craftmen ON rate.craftmen_id = craftmen.user_id
            WHERE craftmen.user_id = $craftmen_id";

    $result = $con->query($sql);

    if ($result->num_rows > 0) {
        $totalRating = 0;
        $numberOfRatings = 0;

        while($row = $result->fetch_assoc()) {
            $totalRating += $row['rating'];
            $numberOfRatings++;
        }

        $averageRating = $numberOfRatings > 0 ? round($totalRating / $numberOfRatings, 2) : 0;

        echo json_encode(['status' => 'success', 'average_rating' => (string)$averageRating]);
    } else {
        echo json_encode(['status' => 'error', 'message' => '0 results']);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid craftmen_id']);
}

$con->close();
?>
