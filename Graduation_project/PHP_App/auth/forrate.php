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
        $data = array();
        while($row = $result->fetch_assoc()) {
            $data[] = $row['rating'];
        }
        echo json_encode(['status' => 'success', 'data' => $data]);
    } else {
        echo json_encode(['status' => 'error', 'message' => '0 results']);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid craftmen_id']);
}

$con->close();




// include 'connect.php';



// $sql = "SELECT 
//             rate.*, 
//             craftmen.user_name AS craftmen_user_name, 
//             users.user_name AS users_user_name,
// 			craftmen.*,
// 			users.*
//         FROM rate
//         JOIN craftmen ON rate.craftmen_id = craftmen.user_id
//         JOIN users ON rate.user_id = users.user_id";

// $result = $con->query($sql);

// if ($result->num_rows > 0) {
//     $data = array();
//     while($row = $result->fetch_assoc()) {
//         $data[] = $row;
//     }
//     echo json_encode(['status' => 'success', 'data' => $data]);
// } else {
//     echo json_encode(['status' => 'error', 'message' => '0 results']);
// }

// $con->close();
?>