<?php
// Database connection parameters
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "onduty";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// SQL query to select all rows from the table
$sql = "SELECT * FROM craftmen";

// Perform the query
$result = $conn->query($sql);

// Check if there are rows returned
if ($result->num_rows > 0) {
    // Output data of each row
    while ($row = $result->fetch_assoc()) {
        // Access individual fields using $row['field_name']
       // echo "User ID: " . $row['user_id'] . " - User Name: " . $row['user_name'] . "<br>";
       foreach ($row as $field => $value) {
        echo $field . ": " . $value . "<br>";
    }
    echo "<hr>";
        // Add more fields as needed
    }
} else {
    echo "0 results";
}

// Close the connection
$conn->close();
?>
