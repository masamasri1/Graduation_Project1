 <?php
// include 'connect.php';

// $gmail = $_POST["gmail"];
// $varify = $_POST["varify"];

// // You should at least sanitize the user inputs, but this is STILL NOT FULLY SECURE.
// //$gmail = $con->quote($gmail);
// //$varify = $con->quote($varify);

// // Using the sanitized variables in the SQL statement
// $result = $con->query("SELECT * FROM Users WHERE gmail = $gmail OR varify = $varify");

// if($result && $result->rowCount() > 0){
//     echo json_encode(array("status" => "success"));
// } else {
//     echo json_encode(array("status" => "failer"));
// } 


 include 'connect.php';

if (isset($_POST["gmail"]) && isset($_POST["varify"])) {
    $gmail = $_POST["gmail"];
    $varify = $_POST["varify"];

    // Using prepared statements
    $stmt = $con->prepare("SELECT * FROM Users WHERE gmail = :gmail AND varify = :varify");
    $stmt->bindParam(':gmail', $gmail);
    $stmt->bindParam(':varify', $varify);
    
    if ($stmt->execute()) {
        if($stmt->rowCount() > 0) {
            echo json_encode(array("status" => "success"));
        } else {
            echo json_encode(array("status" => "failer", "error" => "No matching records found"));
        }
    } else {
        echo json_encode(array("status" => "failer", "error" => $stmt->errorInfo()));
    }
} else {
    echo json_encode(array("status" => "failer", "error" => "Missing input data"));
} 
