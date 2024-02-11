

<?php



//include 'connect.php';


// Check if it's a POST request
// if ($_SERVER['REQUEST_METHOD'] === 'POST') {
//     // Check if 'user_id' is set in the POST parameters
//     if (isset($_POST['user_id'])) {
//         // Get the user_id and other updated user data from the POST parameters
//         $user_id = $_POST['user_id'];
//         $user_name = $_POST['user_name'];
//         $gmail = $_POST['gmail'];
//         $phone_number = $_POST['phone_number'];
//         $password = $_POST['password'];
//         $cpassword = $_POST['cpassword'];
//         $city = $_POST['city'];

//         // Example SQL statement to update user information
//         $sql = "UPDATE users SET user_name = ?, gmail = ?, phone_number = ?, password = ?, cpassword = ?, city = ? WHERE user_id = ?";

//         $stmt = $con->prepare($sql);

//         // Error handling for statement preparation
//         if (!$stmt) {
//             die(json_encode(array("status" => "error", "message" => "Error in preparing the statement: " . $con->error)));
//         }

//         // Bind the parameters
//         $stmt->bind_param("ssssssi", $user_name, $gmail, $phone_number, $password, $cpassword, $city, $user_id);
//         $stmt->execute();

//         // Check if the query was successful
//         if ($stmt->affected_rows > 0) {
//             // Successful update
//             echo json_encode(array("status" => "success", "message" => "User updated successfully"));
//         } else {
//             // No rows affected, user not found or no changes
//             echo json_encode(array("status" => "fail", "message" => "User not found or no changes made"));
//         }

//         // Close the statement and connection
//         $stmt->close();
//         $con->close();
//     } else {
//         // 'user_id' not set in the POST parameters
//         echo json_encode(array("status" => "fail", "message" => "'user_id' parameter is required"));
//     }
// } else {
//     // Only handle POST requests
//     echo json_encode(array("status" => "fail", "message" => "Only POST requests are allowed"));
// }


$host = 'localhost';
$username = 'root';
$password = '';
$database = 'onduty';

// Connect to the database
$conn = new mysqli($host, $username, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if (isset($_POST["user_name"]) && isset($_POST["gmail"]) && isset($_POST["phone_number"]) && isset($_POST["password"]) && isset($_POST["cpassword"]) && isset($_POST["city"])) {
    $username = $_POST["user_name"];
    $gmail1 = $_POST["gmail"];
    $phonenumber = $_POST["phone_number"];
    $password1 = $_POST["password"];
    $cpassword1 = $_POST["cpassword"];
    $city1 = $_POST["city"];

    // Add validation and sanitization for user input here to prevent SQL injection

    // Check if the password and confirm password match
    if ($password1 !== $cpassword1) {
        echo "Passwords do not match!";
    } else {
        // Passwords match, so you can proceed with updating the profile
        // Perform an SQL UPDATE statement to update the user's profile
        $sql = "UPDATE users SET gmail = '$gmail1', phone_number = '$phonenumber', password = '$password1',cpassword = '$cpassword1', city = '$city1' WHERE user_name = '$username'";

        if ($conn->query($sql) === TRUE) {
            echo "Profile updated successfully!";
        } else {
            echo "Error: " . $sql . "<br>" . $conn->error;
        }
    }
} else {
    echo "Incomplete data received from Flutter app.";
}

// // Close the database connection
// $conn->close();
//  include 'connect.php';

// if ($_SERVER['REQUEST_METHOD'] === 'POST') {
//     if (isset($_POST['user_id'])) {
//         $user_id = $_POST['user_id'];
//         $user_name = $_POST['user_name'];
//         $gmail = $_POST['gmail'];
//         $phone_number = $_POST['phone_number'];
//         $password = $_POST['password'];
//         $cpassword = $_POST['cpassword'];
//         $city = $_POST['city'];

//         $sql = "UPDATE users SET user_name = ?, gmail = ?, phone_number = ?, password = ?, cpassword = ?, city = ? WHERE user_id = ?";

//         $stmt = $con->prepare($sql);

//         if (!$stmt) {
//             die(json_encode(array("status" => "error", "message" => "Error in preparing the statement: " . $con->error)));
//         }

//         // Check if there are actual changes in user data
//         $stmt->bind_param("ssssssi", $user_name, $gmail, $phone_number, $password, $cpassword, $city, $user_id);
//         $stmt->execute();

//         if ($stmt->affected_rows > 0) {
//             // Successful update
//             echo json_encode(array("status" => "success", "message" => "User updated successfully"));
//         } else {
//             // No rows affected, user not found or no changes
//             echo json_encode(array("status" => "fail", "message" => "User not found or no changes made"));
//         }

//         $stmt->close();
//         $con->close();
//     } else {
//         echo json_encode(array("status" => "fail", "message" => "'user_id' parameter is required"));
//     }
// } else {
//     echo json_encode(array("status" => "fail", "message" => "Only POST requests are allowed"));
// }   
// Log incoming data


// include 'connect.php';

// // Log received data
// file_put_contents('log.txt', 'Received data: ' . file_get_contents('php://input') . PHP_EOL, FILE_APPEND);

// header('Content-Type: application/json');

// if ($_SERVER['REQUEST_METHOD'] === 'POST') {
//     $requestData = json_decode(file_get_contents('php://input'), true);

//     if (isset($requestData['user_id'])) {
//         $user_id = $requestData['user_id'];
//         $user_name = $requestData['user_name'];
//         $gmail = $requestData['gmail'];
//         $phone_number = $requestData['phone_number'];
//         $password = $requestData['password'];
//         $cpassword = $requestData['cpassword'];
//         $city = $requestData['city'];

//         $sql = "UPDATE users SET user_name = ?, gmail = ?, phone_number = ?, password = ?, cpassword = ?, city = ? WHERE user_id = ?";

//         $stmt = $con->prepare($sql);

//         if ($stmt) {
//             $stmt->bind_param("ssssssi", $user_name, $gmail, $phone_number, $password, $cpassword, $city, $user_id);
//             $stmt->execute();

//             if ($stmt->affected_rows > 0) {
//                 // Successful update
//                 echo json_encode(array("status" => "success", "message" => "User updated successfully"));
//             } else {
//                 // No rows affected, user not found or no changes
//                 echo json_encode(array("status" => "fail", "message" => "User not found or no changes made"));
//             }

//             $stmt->close();
//         } else {
//             // Error in preparing the statement
//             echo json_encode(array("status" => "error", "message" => "Error in preparing the statement: " . $con->error));
//         }

//         $con->close();
//     } else {
//         echo json_encode(array("status" => "fail", "message" => "'user_id' parameter is required"));
//     }
// } else {
//     echo json_encode(array("status" => "fail", "message" => "Only POST requests are allowed"));
// }






?>