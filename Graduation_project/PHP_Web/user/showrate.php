<?php
include 'connect.php';

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With, Access-Control-Allow-Origin');
header('Access-Control-Allow-Methods: POST, OPTIONS, GET');

$sql = "SELECT 
            rate.*, 
            craftmen.user_name AS craftmen_user_name, 
            users.user_name AS users_user_name,
			craftmen.*,
			users.*
        FROM rate
        JOIN craftmen ON rate.craftmen_id = craftmen.user_id
        JOIN users ON rate.user_id = users.user_id";

$result = $con->query($sql);

if ($result->num_rows > 0) {
    $data = array();
    while($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
    echo json_encode(['status' => 'success', 'data' => $data]);
} else {
    echo json_encode(['status' => 'error', 'message' => '0 results']);
}

$con->close();
?>
