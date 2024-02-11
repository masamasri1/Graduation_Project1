<?php


// Assuming you have a MySQL database with tables: 'users', 'craftsmen', 'reservations'
// Columns in 'reservations': id, start_date, end_date, craftsman_id (foreign key), user_id (foreign key)

// Database configuration
$host = 'localhost';
$db   = 'onduty';
$user = 'root';
$pass = '';

// Create a connection
$conn = new mysqli($host, $user, $pass, $db);

// Check the connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get data from Flutter app
$start_date = $_POST['start_date'];
$end_date = $_POST['end_date'];
$craftsman_id = $_POST['craftmen_id'];
$user_id = $_POST['user_id'];
$duration = $_POST['duration'];

// Check if the user_id and craftsman_id exist in their respective tables
$userCheck = $conn->query("SELECT user_id FROM users WHERE user_id = '$user_id'");
$craftsmanCheck = $conn->query("SELECT user_id FROM craftmen WHERE user_id = '$craftsman_id'");

if ($userCheck === FALSE || $craftsmanCheck === FALSE) {
    echo "Error in user or craftsman check query: " . $conn->error;
} else {
    // Both user_id and craftsman_id exist, proceed with the reservation
    if ($userCheck->num_rows > 0 && $craftsmanCheck->num_rows > 0) {
        // Insert into the 'reservation' table
        $sql1 = "INSERT INTO reservation (user_id, craftmen_id, start_date, end_date, duration) VALUES ('$user_id', '$craftsman_id', '$start_date', '$end_date', '$duration')";
        if ($conn->query($sql1) === TRUE) {
            echo "Reservation successfully saved in 'reservation' table. ";
        } else {
            echo "Error in reservation query: " . $conn->error;
        }

        // Insert into the 'reser' table
        $sql2 = "INSERT INTO reser (user_id, craftmen_id, start_date, end_date, duration) VALUES ('$user_id', '$craftsman_id', '$start_date', '$end_date', '$duration')";
        if ($conn->query($sql2) === TRUE) {
            echo "Reservation successfully saved in 'reser' table.";
        } else {
            echo "Error in reservation query: " . $conn->error;
        }
    } else {
        echo "Invalid user_id or craftsman_id";
    }
}

// Close the connection
$conn->close();
// // Assuming you have a MySQL database with tables: 'users', 'craftsmen', 'reservations'
// // Columns in 'reservations': id, start_date, end_date, craftsman_id (foreign key), user_id (foreign key)

// // Database configuration
// $host = 'localhost';
// $db   = 'onduty';
// $user = 'root';
// $pass = '';

// // Create a connection
// $conn = new mysqli($host, $user, $pass, $db);

// // Check the connection
// if ($conn->connect_error) {
//     die("Connection failed: " . $conn->connect_error);
// }

// // Get data from Flutter app
// $start_date = $_POST['start_date'];
// $end_date = $_POST['end_date'];
// $craftsman_id = $_POST['craftmen_id'];
// $user_id = $_POST['user_id'];
// $duration=$_POST['duration'];
// // Check if the user_id and craftsman_id exist in their respective tables
// $userCheck = $conn->query("SELECT user_id FROM users WHERE user_id = '$user_id'");
// $craftsmanCheck = $conn->query("SELECT user_id FROM craftmen WHERE user_id = '$craftsman_id'");

// if ($userCheck === FALSE || $craftsmanCheck === FALSE) {
//     echo "Error in user or craftsman check query: " . $conn->error;
// } else {
//     // Both user_id and craftsman_id exist, proceed with the reservation
//     if ($userCheck->num_rows > 0 && $craftsmanCheck->num_rows > 0) {
//         $sql = "INSERT INTO reservation (user_id, craftmen_id, start_date, end_date,duration) VALUES ('$user_id', '$craftsman_id', '$start_date', '$end_date','$duration')";
//         $sql = "INSERT INTO reser (user_id, craftmen_id, start_date, end_date,duration) VALUES ('$user_id', '$craftsman_id', '$start_date', '$end_date','$duration')";
//         if ($conn->query($sql) === TRUE) {
//             echo "Reservation successfully saved";
//         } else {
//             echo "Error in reservation query: " . $conn->error;
//         }
//     } else {
//         echo "Invalid user_id or craftsman_id";
//     }
// }

// // Close the connection
// $conn->close();
?>




