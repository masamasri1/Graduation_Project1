
<?php
include 'connect.php';

// Establish a connection to your database
//$con = new mysqli($servername, $username, $password, $dbname);

// Check the connection
if ($con->connect_error) {
    die("Connection failed: " . $con->connect_error);
}

// Fetch user_id based on user_name
if (isset($_POST['user_name'])) {
    $userName = $_POST['user_name'];

    $sql = "SELECT craftmen_gmail FROM craftmen WHERE user_name = '$userName'";
    $result = $con->query($sql);

    if ($result) {
        if ($result->num_rows > 0) {
            // User found
            $row = $result->fetch_assoc();
            $response = array("status" => "success", "craftmen_gmail" => $row['craftmen_gmail']);
            echo json_encode($response);
        } else {
            // User not found
            $response = array("status" => "error", "message" => "User not found");
            echo json_encode($response);
        }
    } else {
        // SQL query execution error
        $response = array("status" => "error", "message" => "Error executing SQL query: " . $con->error);
        echo json_encode($response);
    }
} else {
    // Invalid or missing parameters
    $response = array("status" => "error", "message" => "Invalid or missing parameters");
    echo json_encode($response);
}

$con->close();
?>
