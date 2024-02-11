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

// Check if a username is provided via POST
if(isset($_POST['username'])) {
    $searchUserName = $_POST['username'];

    // SQL query to select data for a specific user
    $sql = "SELECT * FROM users WHERE user_name = '$searchUserName'";

    // Perform the query
    $result = $conn->query($sql);

    // Check if there are rows returned
    if ($result->num_rows > 0) {
        // Output data of each row
        while ($row = $result->fetch_assoc()) {
            // Access individual fields using $row['field_name']
            foreach ($row as $field => $value) {
                echo $field . ": " . $value . "<br>";
            }
            echo "<hr>";
            // Add more fields as needed
        }
    } else {
        echo "0 results";
    }
} else {
    echo "No username provided via POST.";
}

// Close the connection
$conn->close();
?>
