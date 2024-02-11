<?php


$to = 'zainabhalawa2@gmail.com'; // Replace with your actual email address
$subject = 'Test Email';
$message = 'This is a test email sent from the mail() function.';
$headers = 'From: no-reply@example.com' . "\r\n" .
    'Reply-To: no-reply@example.com' . "\r\n" .
    'X-Mailer: PHP/' . phpversion();

if (mail($to, $subject, $message, $headers)) {
    echo "Email sent successfully!";
} else {
    echo "Failed to send the email.";
}

?>

