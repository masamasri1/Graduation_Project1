<?php

include 'connect.php';
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $base64Photo = $_POST['aphoto'];
    $adminEmail = $_POST['craftmen_gmail'];

    $decodedPhoto = base64_decode($base64Photo);

    if (!empty($decodedPhoto)) {
        $stmt = $con->prepare("UPDATE craftmen SET aphoto = ? WHERE craftmen_gmail = ?");
        $stmt->bind_param("ss", $base64Photo, $adminEmail);

        if ($stmt->execute()) {
            // Photo updated successfully

            // Fetch the updated photo URL from the database
            $selectStmt = $con->prepare("SELECT aphoto FROM craftmen WHERE craftmen_gmail = ?");
            $selectStmt->bind_param("s", $adminEmail);
            $selectStmt->execute();
            $result = $selectStmt->get_result();

            if ($result->num_rows > 0) {
                $row = $result->fetch_assoc();
                $photoUrl = $row['aphoto'];

                // Return JSON response with the photo URL
                echo json_encode(['status' => 'success', 'aphoto' => $photoUrl]);
            } else {
                echo json_encode(['status' => 'error', 'message' => 'craftmen not found']);
            }

        } else {
            // Error updating photo
            echo json_encode(['status' => 'error', 'message' => $stmt->error]);
        }

        $stmt->close();
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Failed to decode image data.']);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid request method']);
}

$con->close();
?>
