<?php

require 'C:\Users\hp\StudioProjects\Responsive_flutter-main\Responsive_flutter-main\vendor/autoload.php';
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

$verificationCode = 1256;
$your_email = 'ondutymis.2000@gmail.com';

$mail = new PHPMailer(true);

try {
    // Server settings
    $mail->isSMTP();
    $mail->Host = 'smtp.gmail.com';
    $mail->SMTPAuth = true;
    $mail->Username = 'ondutymis.2000@gmail.com';
    $mail->Password = 'pqug bdxk zujn nozp';
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
    $mail->Port = 587;

    // Recipients
    $mail->setFrom('ondutymis.2000@gmail.com', 'OnDuty');
    $mail->addAddress($your_email);

    // Content
    $mail->isHTML(true);
    $mail->Subject = 'Password Reset Verification Code';
    $mail->Body = "Your verification code for password reset is: $verificationCode";

    // Enable debugging
    $mail->SMTPDebug = 2;

    // Attempt to send the email
    $mail->send();
    echo 'Email sent successfully to ' . $your_email;
} catch (Exception $e) {
    echo 'Sorry, failed while sending mail: ' . $e->getMessage();
}