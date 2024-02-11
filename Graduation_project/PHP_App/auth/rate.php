<?php

include 'connect.php';

// Enable error reporting for debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);

if ($con->connect_error) {
    die('Connection failed: ' . $con->connect_error);
}

// Get user_id, craftmen_id, rating, and comment from the Flutter app
$user_id = $_POST['user_id'];
$craftmen_id = $_POST['craftmen_id'];
$rating = $_POST['rating'];
$comment = $_POST['comment'];

// Sanitize inputs to prevent SQL injection
$user_id = $con->real_escape_string($user_id);
$craftmen_id = $con->real_escape_string($craftmen_id);
$rating = $con->real_escape_string($rating);
$comment = $con->real_escape_string($comment);

// Perform the INSERT operation
$insertQuery = "INSERT INTO rate (user_id, craftmen_id, rating, comment) 
                VALUES ('$user_id', '$craftmen_id', '$rating', '$comment')";

if ($con->query($insertQuery) === TRUE) {
    echo 'Rating and comment submitted successfully';
} else {
    echo 'Error submitting rating and comment: ' . $con->error . '<br>' . $insertQuery;
}

$con->close();





// include 'connect.php';

// if ($con->connect_error) {
//     die('Connection failed: ' . $con->connect_error);
// }

// // Get user_id, craftmen_id, rating, and comment from the Flutter app
// $user_id = $_POST['user_id'];       // Replace 'user_id' with the actual parameter name
// $craftmen_id = $_POST['craftmen_id']; // Replace 'craftmen_id' with the actual parameter name
// $rating = $_POST['rating'];
// $comment = $_POST['comment'];

// // Sanitize inputs to prevent SQL injection
// $user_id = $con->real_escape_string($user_id);
// $craftmen_id = $con->real_escape_string($craftmen_id);
// $rating = $con->real_escape_string($rating);
// $comment = $con->real_escape_string($comment);

// // Use a single SQL query to perform two inner joins and the INSERT operation
// $insertQuery = "INSERT INTO rate(user_id, craftmen_id, rating, comment) 
//                 SELECT u.user_id, c.user_id AS craftmen_id, '$rating', '$comment'
//                 FROM users u
//                 INNER JOIN craftmen c ON u.user_id = c.user_id
//                 WHERE u.user_id = '$user_id' AND c.user_id = '$craftmen_id'";

// if ($con->query($insertQuery) === TRUE) {
//     echo 'Rating and comment submitted successfully';
// } else {
//     echo 'Error submitting rating and comment: ' . $con->error;
// }

// $con->close();
?>
