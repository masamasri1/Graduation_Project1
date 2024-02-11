<?php


// $host = 'localhost';
// $db = 'onduty';
// $user = 'root';
// $pass = '';

// // Create a connection
// $conn = new mysqli($host, $user, $pass, $db);

// // Check the connection
// if ($conn->connect_error) {
//     die("Connection failed: " . $conn->connect_error);
// }

// // Function to fetch craftsmen data based on reservation
// function fetchCraftmenData($conn, $craftmenId) {
//     $sqlQuery = "SELECT c.user_id, c.jop_id, c.craftmen_city 
//                  FROM craftmen c 
//                  INNER JOIN reser r ON c.user_id = r.craftmen_id
//                  WHERE r.craftmen_id = '$craftmenId'";

//     $result = $conn->query($sqlQuery);

//     if ($result === FALSE) {
//         error_log("Error in fetchCraftmenData query: " . $conn->error);
//         return null;
//     }

//     return ($result->num_rows > 0) ? $result->fetch_assoc() : null;
// }

// $craftmenId = isset($_POST['craftmen_id']) ? $_POST['craftmen_id'] : null;
// $resId = isset($_POST['res_id']) ? $_POST['res_id'] : null;
// $startDate = isset($_POST['start_date']) ? $_POST['start_date'] : null;
// $endDate = isset($_POST['end_date']) ? $_POST['end_date'] : null;

// // Validate input parameters
// if (empty($craftmenId) || empty($resId) || empty($startDate) || empty($endDate)) {
//     header('Content-Type: application/json');
//     echo json_encode(['error' => 'Craftmen ID, Res ID, Start Date, or End Date is empty']);
//     exit;
// }

// // Fetch craftsmen data
// $craftmenData = fetchCraftmenData($conn, $craftmenId);

// if ($craftmenData !== null) {
//     $jobId = $craftmenData['jop_id'];
//     $city = $craftmenData['craftmen_city'];

//     $result = $conn->query("SELECT user_id, user_name, craftmen_gmail, craftmen_phone, password, cpassword, craftmen_city, jop_id, job, price, emergency, working_day
//                             FROM craftmen 
//                             WHERE jop_id = '$jobId' AND craftmen_city = '$city' 
//                             AND user_id != '{$craftmenData['user_id']}'");

//     if ($result !== FALSE) {
//         $otherCraftsmen = [];
//         while ($row = $result->fetch_assoc()) {
//             // Check availability for each craftsman during the specified time range
//             $craftsmanId = $row['user_id'];
//             $availabilityQuery = "SELECT * FROM reser 
//                                   WHERE craftmen_id = '$craftsmanId' 
//                                   AND (
//                                     (start_date BETWEEN '$startDate' AND '$endDate') 
//                                     OR (end_date BETWEEN '$startDate' AND '$endDate')
//                                     OR ('$startDate' BETWEEN start_date AND end_date)
//                                     OR ('$endDate' BETWEEN start_date AND end_date')
//                                   )";
//             $availabilityResult = $conn->query($availabilityQuery);

//             if ($availabilityResult !== FALSE) {
//                 if ($availabilityResult->num_rows == 0) {
//                     $otherCraftsmanInfo = [
//                         'user_id' => $row['user_id'],
//                         'user_name' => $row['user_name'],
//                         'craftmen_gmail' => $row['craftmen_gmail'],
//                         'craftmen_phone' => $row['craftmen_phone'],
//                         'password' => $row['password'],
//                         'cpassword' => $row['cpassword'],
//                         'craftmen_city' => $row['craftmen_city'],
//                         'jop_id' => $row['jop_id'],
//                         'job' => $row['job'],
//                         'price' => $row['price'],
//                         'emergency' => $row['emergency'],
//                         'working_day' => $row['working_day'],
//                     ];

//                     $otherCraftsmen[] = $otherCraftsmanInfo;
//                 }
//             } else {
//                 $error = $conn->error; // Save error for debugging
//                 error_log("Error in availability check query: $error");
//             }
//         }

//         // Output the data as JSON (you can modify this based on your needs)
//         header('Content-Type: application/json');
//         echo json_encode(['craftmenData' => $craftmenData, 'otherCraftsmen' => $otherCraftsmen, 'debug' => 'Print debug information']);
//     } else {
//         $error = $conn->error; // Save error for debugging
//         error_log("Error in other craftsmen query: $error");
//         header('Content-Type: application/json');
//         echo json_encode(['error' => 'Error fetching other craftsmen']);
//     }
// } else {
//     header('Content-Type: application/json');
//     echo json_encode(['error' => 'No data found for the given craftmen ID']);
// }

// // Close the database connection
// $conn->close();



$host = 'localhost';
$db = 'onduty';
$user = 'root';
$pass = '';

// Create a connection
$conn = new mysqli($host, $user, $pass, $db);

// Check the connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Function to fetch craftsmen data based on reservation
function fetchCraftmenData($conn, $craftmenId) {
    $sqlQuery = "SELECT c.user_id, c.jop_id, c.craftmen_city 
                 FROM craftmen c 
                 INNER JOIN reser r ON c.user_id = r.craftmen_id
                 WHERE r.craftmen_id = '$craftmenId'";

    $result = $conn->query($sqlQuery);

    if ($result === FALSE) {
        error_log("Error in fetchCraftmenData query: " . $conn->error);
        return null;
    }

    return ($result->num_rows > 0) ? $result->fetch_assoc() : null;
}

$craftmenId = isset($_POST['craftmen_id']) ? $_POST['craftmen_id'] : null;
$resId = isset($_POST['res_id']) ? $_POST['res_id'] : null;
$startDate = isset($_POST['start_date']) ? $_POST['start_date'] : null;
$endDate = isset($_POST['end_date']) ? $_POST['end_date'] : null;

// Validate input parameters
if (empty($craftmenId) || empty($resId) || empty($startDate) || empty($endDate)) {
    header('Content-Type: application/json');
    echo json_encode(['error' => 'Craftmen ID, Res ID, Start Date, or End Date is empty']);
    exit;
}

// Fetch craftsmen data
$craftmenData = fetchCraftmenData($conn, $craftmenId);

if ($craftmenData !== null) {
    $jobId = $craftmenData['jop_id'];
    $city = $craftmenData['craftmen_city'];

    $result = $conn->query("SELECT user_name, user_id 
                            FROM craftmen 
                            WHERE jop_id = '$jobId' AND craftmen_city = '$city' 
                            AND user_id != '{$craftmenData['user_id']}'");

    if ($result !== FALSE) {
        $otherCraftsmen = [];
        while ($row = $result->fetch_assoc()) {
            // Check availability for each craftsman during the specified time range
            $craftsmanId = $row['user_id'];
            $availabilityQuery = "SELECT * FROM reser WHERE craftmen_id = '$craftsmanId' AND (start_date BETWEEN '$startDate' AND '$endDate' OR end_date BETWEEN '$startDate' AND '$endDate')";
            $availabilityResult = $conn->query($availabilityQuery);

            if ($availabilityResult !== FALSE) {
                if ($availabilityResult->num_rows == 0) {
                    $otherCraftsmen[] = $row['user_name'];
                }
            } else {
                $error = $conn->error; // Save error for debugging
                error_log("Error in availability check query: $error");
            }
        }

        // Output the data as JSON (you can modify this based on your needs)
        header('Content-Type: application/json');
        echo json_encode(['craftmenData' => $craftmenData, 'otherCraftsmen' => $otherCraftsmen, 'debug' => 'Print debug information']);
    } else {
        $error = $conn->error; // Save error for debugging
        error_log("Error in other craftsmen query: $error");
        header('Content-Type: application/json');
        echo json_encode(['error' => 'Error fetching other craftsmen']);
    }
} else {
    header('Content-Type: application/json');
    echo json_encode(['error' => 'No data found for the given craftmen ID']);
}

// Close the database connection
$conn->close();

?>
