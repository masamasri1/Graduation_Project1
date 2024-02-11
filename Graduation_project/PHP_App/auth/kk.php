<?php


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

// Function to fetch craftmen details
function fetchCraftmenDetails($conn, $craftmenName) {
    $sqlQuery = "SELECT user_name, craftmen_phone, price, emergency,working_day 
                 FROM craftmen
                 WHERE user_name = '$craftmenName'";

    $result = $conn->query($sqlQuery);

    if ($result === FALSE) {
        error_log("Error in fetchCraftmenDetails query: " . $conn->error);
        return json_encode(['error' => $conn->error]);
    }

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        return json_encode([
            'craftmen_name' => $row['user_name'],
            'craftmen_phone' => $row['craftmen_phone'],
            'price' => $row['price'],
            'emergency' => $row['emergency'],
            'working_day' => $row['working_day'],
           
        ]);
    } else {
        return json_encode(['error' => "No data found for the craftmen name: $craftmenName"]);
    }
}

// Validate input parameters
$craftmenName = isset($_POST['user_name']) ? $_POST['user_name'] : null;

if (empty($craftmenName)) {
    header('Content-Type: application/json');
    echo json_encode(['error' => 'Craftmen name is empty']);
    exit;
}

// Fetch craftmen details
$craftmenDetails = fetchCraftmenDetails($conn, $craftmenName);

// Output the data as JSON (you can modify this based on your needs)
header('Content-Type: application/json');
echo $craftmenDetails;

// Close the database connection
$conn->close();








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

// // Function to fetch craftmen details
// function fetchCraftmenDetails($conn, $craftmenName) {
//     $sqlQuery = "SELECT user_name, craftmen_phone, price, emergency 
//                  FROM craftmen
//                  WHERE user_name = '$craftmenName'";

//     $result = $conn->query($sqlQuery);

//     if ($result === FALSE) {
//         error_log("Error in fetchCraftmenDetails query: " . $conn->error);
//         return ['error' => $conn->error];
//     }

//     if ($result->num_rows > 0) {
//         return $result->fetch_assoc();
//     } else {
//         return ['error' => 'No data found for the craftmen name: $craftmenName'];
//     }
// }

// // Validate input parameters
// $craftmenName = isset($_POST['user_name']) ? $_POST['user_name'] : null;

// if (empty($craftmenName)) {
//     header('Content-Type: application/json');
//     echo json_encode(['error' => 'Craftmen name is empty']);
//     exit;
// }

// // Fetch craftmen details
// $craftmenDetails = fetchCraftmenDetails($conn, $craftmenName);

// // Output the data as JSON (you can modify this based on your needs)
// header('Content-Type: application/json');
// echo json_encode($craftmenDetails);

// // Close the database connection
// $conn->close();

?>
