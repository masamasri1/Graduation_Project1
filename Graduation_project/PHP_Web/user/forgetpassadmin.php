<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With, Access-Control-Allow-Origin");
header("Access-Control-Allow-Methods: POST, OPTIONS , GET");
require 'C:\Users\hp\StudioProjects\Responsive_flutter-main\Responsive_flutter-main\vendor/autoload.php';
    use PHPMailer\PHPMailer\PHPMailer;
    use PHPMailer\PHPMailer\SMTP;
    use PHPMailer\PHPMailer\Exception;
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
$your_email = $_POST['admin_gmail'];
$stmt = $con->prepare("SELECT * FROM admin WHERE admin_gmail= :admin_gmail");
$stmt->bindParam(':admin_gmail', $your_email);
$stmt->execute();
$result = $stmt->fetch(PDO::FETCH_ASSOC);
if(!$result) {
    ob_end_clean(); // Clear the buffer
    echo json_encode(array("status" => "failer"));
    exit;
}

$verificationCode = rand(1000, 9999);
//$subject = 'Password Reset Verification Code';
//$message = "Your verification code for password reset is: $verificationCode";
//$headers = 'From: OnDuty';


$mail_sent = sendVerificationEmail($your_email,$verificationCode );
if (!$mail_sent) {
    $error_message = "Email sending failed. Error: " . error_get_last()['message'];
}
$stmt = $con->prepare("UPDATE admin SET varify = ? WHERE admin_gmail = ?");
$stmt->execute([$verificationCode, $your_email]);

ob_end_clean(); // Clear the buffer
echo json_encode(array("status" => "success"));

function sendVerificationEmail($recipientEmail, $verificationCode) {

    $senderEmail = 'ondutymis.2000@gmail.com';
    $senderName = 'OnDuty';
    $appPassword = 'pqug bdxk zujn nozp'; // Replace with your actual App Password

    $mail = new PHPMailer(true);

    try {
        // Server settings
        $mail->isSMTP();
        $mail->Host = 'smtp.gmail.com';
        $mail->SMTPAuth = true;
        $mail->Username = 'ondutymis.2000@gmail.com';
        $mail->Password = $appPassword;
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
        $mail->Port = 587;

        // Recipients
        $mail->setFrom($senderEmail, $senderName);
        $mail->addAddress($recipientEmail);

        // Content
        $mail->isHTML(true);
        $mail->Subject = 'Password Reset Verification Code';
        $mail->Body = "Your verification code for password reset is: $verificationCode";

        // Enable debugging
        $mail->SMTPDebug = 2;

        // Attempt to send the email
        $mail->send();
        echo 'Email sent successfully to ' . $recipientEmail;
    } catch (Exception $e) {
        echo 'Sorry, failed while sending mail: ' . $e->getMessage();
    }
}
?>