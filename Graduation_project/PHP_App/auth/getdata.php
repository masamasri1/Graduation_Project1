<?php
include 'connect.php';  // Include your database connection file

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['user_name'])) {
        $user_name = $_POST['user_name'];

        $sql = "SELECT * FROM users WHERE user_name = ?";
        $stmt = $con->prepare($sql);

        if (!$stmt) {
            die(json_encode(array("status" => "error", "message" => "Error in preparing the statement: " . $con->error)));
        }

        $stmt->bind_param("s", $user_name);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $user_data = array(
                'user_id' => $row['user_id'],
                'user_name' => $row['user_name'],
                'gmail' => $row['gmail'],
                'phone_number' => $row['phone_number'],
                'password' => $row['password'],
                'cpassword' => $row['cpassword'],
                'city' => $row['city'],
            );

            echo json_encode(array("status" => "success", "user_data" => $user_data));
        } else {
            echo json_encode(array("status" => "fail", "message" => "User not found"));
        }

        $stmt->close();
    } else {
        echo json_encode(array("status" => "fail", "message" => "'user_name' parameter is required"));
    }
} else {
    echo json_encode(array("status" => "fail", "message" => "Only POST requests are allowed"));
}

$con->close();
?>
