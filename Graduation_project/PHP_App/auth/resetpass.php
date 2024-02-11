<?php
// include 'connect.php';

// $message = "";
// $token = $_GET['newpass'];

// // Check if token exists and hasn't expired
// $sql = "SELECT gmail, datee FROM resetpass WHERE newpass='$token' LIMIT 1";
// $result = $con->query($sql);
// $row = $result->fetch_assoc();

// if (!$row) {
//     $message = "Invalid token!";
// } elseif (strtotime($row['datee']) < time()) {
//     $message = "Token has expired!";
// }

// if ($_SERVER["REQUEST_METHOD"] == "POST" && empty($message)) {
//     $newPassword = $_POST["new_password"];
//     $hashedPassword = password_hash($newPassword, PASSWORD_DEFAULT);
//     $email = $row['gmail'];

//     // Update the password in the Users table
//     $sql = "UPDATE Users SET password='$hashedPassword' WHERE gmail='$email'";
//     if ($con->query($sql) === TRUE) {
//         $message = "Password updated successfully!";
//         // Optionally delete the token so it can't be reused
//         $con->query("DELETE FROM resetpass WHERE newpass='$token'");
//     } else {
//         $message = "Error updating password: " . $con->error;
//     }
// }
include 'connect.php';
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = $_POST["gmail"];
    $newPassword = $_POST["password"];
    $confirmPassword = $_POST["cpassword"];
    
    // Check if new password and confirmation password match
    if ($newPassword === $confirmPassword) {
        
        // Hash the new password using bcrypt
        $hashedPassword = password_hash($newPassword, PASSWORD_DEFAULT);
        
        // Prepare the SQL statement to update the password
        $stmt = $con->prepare("UPDATE Users SET password = ?,cpassword=? WHERE gmail = ?");
        $result = $stmt->execute([$hashedPassword, $email]);
        
        // Check if the password was updated successfully
        if ($result) {
            echo json_encode(array("status" => "success"));
    } else {
        echo json_encode(array("status" => "failer"));
    }
    } else {
        echo "Passwords do not match!";
    }
}
?>