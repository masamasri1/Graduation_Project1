<?php
// include 'connect.php';

// $email = $_POST["gmail"];  // The email address to send the new password to

// // Generate a new random password
// $newPassword = bin2hex(random_bytes(5));  // This will give a 10-character random string

// // Hash the new password
// $hashedPassword = password_hash($newPassword, PASSWORD_DEFAULT);

// // Update the user's password in the database
// $sql = "UPDATE Users SET password='$hashedPassword' WHERE gmail='$email'";
// if ($con->query($sql) === TRUE) {
//     // The password was updated successfully
//     // Send the new password to the user's email
//     $to = $email;
//     $subject = "Your new password";
//     $message = "Your new password is: $newPassword";
//     $headers = "From: webmaster@example.com";  // Change this to your domain

//     if (mail($to, $subject, $message, $headers)) {
//         echo "Email sent successfully!";
//     } else {
//         echo "Error sending email.";
//     }
// } else {
//     echo "Error updating password: " . $con->error;
// }

// include 'connect.php';

// $email = $_POST["gmail"];

// // 1. Check if the email exists in your users table
// $sql = "SELECT * FROM Users WHERE gmail='$email'";
// $result = $con->query($sql);

// if ($result->num_rows > 0) {
//     // 2. Generate a unique token for password reset
//     $token = bin2hex(random_bytes(50));

//     // Store this token in the database with an expiration time (e.g., 1 hour)
//     $expiry = date("Y-m-d H:i:s", strtotime('+1 hour'));
//     $sql = "INSERT INTO resetpass (gmail, newpass, datee) VALUES ('$email', '$token', '$expiry')";
//     $con->query($sql);

//     // 3. Send an email to the user with the reset link
//     $to = $email;
//     $subject = "Reset Your Password";
//     $message = "To reset your password, click on the link below:\n\n";
//     $message .= "https://localhost/ONDUTY/auth/resetpass.php?newpass=$token";
//     $headers = "From: webmaster@example.com";

//     if (mail($to, $subject, $message, $headers)) {
//         echo "Password reset link sent to your email!";
//     } else {
//         echo "Error sending email.";
//     }
// } else {
//     echo "No account associated with this email.";
// }

// include 'connect.php';
// $email=$_POST['gmail'];
// $verfiycode  = rand(1000,9999);
// $stmt = $con->prepare("SELECT * FROM  User  WHERE gmail =  ? ");
// $stmt->execute(array($email));
// $count = $stmt->rowCount();
// //result($count);
// if($count > 0){
//   $data = array(
//     "gmail" => $email,
// );
//    //$res =$con->query("UPDATE `user` SET `password` = '$password',`confirm_password` = '$confirm_password' WHERE `email` = '$email'");
//    updatedata("User",$data,"gmail = '$email'",false);
//    sendEmail($email,"varify","varify is : $verfiycode");
//    echo json_encode(array("success" => true ));
// } else {
//     echo json_encode(array("success" => false ));
  

// }

// Database credentials
ob_start();  // Start output buffering

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

$host = 'localhost';
$dbname = 'onduty';
$user = 'root';
$pass = '';

try {
    $con = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $user, $pass);
    $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    // Capture the error message and handle it gracefully later.
    $error_message = "Failed to connect to the database: " . $e->getMessage();
}

$your_email = $_POST['gmail'];

$stmt = $con->prepare("SELECT * FROM Users WHERE gmail= :email");
$stmt->bindParam(':email', $your_email);
$stmt->execute();
$result = $stmt->fetch(PDO::FETCH_ASSOC);

if(!$result) {
    ob_end_clean(); // Clear the buffer
    echo json_encode(array("status" => "failer"));
    exit;
}

$verificationCode = rand(1000, 9999);
$subject = 'Password Reset Verification Code';
$message = "Your verification code for password reset is: $verificationCode";
$headers = 'From: no-reply@example.com' . "\r\n" .
    'X-Mailer: PHP/' . phpversion();

if(!mail($your_email, $subject, $message, $headers)) {
    $error_message = "Email sending failed";
}

$stmt = $con->prepare("UPDATE Users SET varify = ? WHERE gmail = ?");
$stmt->execute([$verificationCode, $your_email]);

ob_end_clean(); // Clear the buffer
echo json_encode(array("status" => "success"));

?>



