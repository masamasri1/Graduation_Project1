<?php
// Replace these values with your actual database credentials
$host = 'localhost'; // Change to your MySQL server host
$db_user = 'root'; // Change to your MySQL username
$db_password = ''; // Change to your MySQL password
$database = 'onduty'; // Change to your MySQL database name

// Create connection
$conn = new mysqli($host, $db_user, $db_password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check if the required POST parameters are set
$username = isset($_POST["user_name"]) ? $_POST["user_name"] : null;
$password = isset($_POST["password"]) ? $_POST["password"] : null;

// Check if parameters are not set
if ($username === null || $password === null) {
    echo json_encode(array("error" => "Missing parameters"));
    exit;
}

// Add or remove tables as needed
$tables = ["users", "craftmen"];
$foundInTable = null;

foreach ($tables as $table) {
    $sql = "SELECT * FROM $table WHERE user_name = ? AND password = ? LIMIT 1";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ss", $username, $password);
    $stmt->execute();

    $res = $stmt->get_result();

    if ($res && $res->num_rows > 0) {
        $foundInTable = $table;
        break;
    }
}

ob_clean(); // Clean the output buffer

if ($foundInTable == "users") {
    echo json_encode(array("success" => "success1"));
} elseif ($foundInTable == "craftmen") {
    echo json_encode(array("success" => "success2"));
} else {
    echo json_encode(array("success" => false));
}

// Close the database connection
$conn->close();
?>
