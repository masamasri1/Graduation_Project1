<?php
include 'connect.php';
require 'C:\Users\hp\StudioProjects\Responsive_flutter-main\Responsive_flutter-main\vendor/autoload.php';
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With, Access-Control-Allow-Origin');
header('Access-Control-Allow-Methods: POST, OPTIONS, GET');

// Function to send deletion notification email
/*
function sendDeletionEmail($user_id, $con) {
    $getEmailSQL = "SELECT gmail FROM users WHERE user_id = ?";
    $stmtGetEmail = $con->prepare($getEmailSQL);
    $stmtGetEmail->bind_param("i", $user_id);
    $stmtGetEmail->execute();
    $stmtGetEmail->bind_result($recipientEmail);
    $stmtGetEmail->fetch();
    $stmtGetEmail->close();

    if (!$recipientEmail) {
        // Handle the case where the email is not found
        echo json_encode(array("status" => "fail", "message" => "Recipient email not found"));
        return;
    }

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
        $mail->Subject = 'Email Delete code';
        $mail->Body = "this email $recipientEmail has been deleted";

        // Enable debugging
        $mail->SMTPDebug = 2;

        // Attempt to send the email
        if ($mail->send()) {
            echo 'Email sent successfully to ' . $recipientEmail;
        } else {
            echo json_encode(array("status" => "fail", "message" => "Error sending email: " . $mail->ErrorInfo));
        }
    } catch (Exception $e) {
        echo 'Sorry, failed while sending mail: ' . $e->getMessage();
    }
}*/

// Check if it's a POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Check if 'user_id' is set in the POST parameters
    if (isset($_POST['user_id'])) {
        // Get the user_id from the POST parameters
        $user_id = $_POST['user_id'];

        // Start a transaction to ensure data consistency
        $con->begin_transaction();

        try {
            // Prepare the SQL statement to delete reservations associated with the user
            $deleteReservationsSQL = "DELETE FROM reservation WHERE user_id = ?";
            $stmtReservations = $con->prepare($deleteReservationsSQL);
            $stmtReservations->bind_param("i", $user_id);
            $stmtReservations->execute();
			
			// Prepare the SQL statement to delete reservations associated with the user
            $deleteReservationsSQL = "DELETE FROM reser WHERE user_id = ?";
            $stmtReservations = $con->prepare($deleteReservationsSQL);
            $stmtReservations->bind_param("i", $user_id);
            $stmtReservations->execute();

            // Prepare the SQL statement to delete the user
            $deleteUserSQL = "DELETE FROM users WHERE user_id = ?";
            $stmtUser = $con->prepare($deleteUserSQL);
            $stmtUser->bind_param("i", $user_id);
            $stmtUser->execute();

            // Commit the transaction if everything is successful
            $con->commit();

            // Check if the queries were successful
            if ($stmtReservations->affected_rows > 0 && $stmtUser->affected_rows > 0) {
                // Successful deletion
                echo json_encode(array("status" => "success", "message" => "User and associated reservation deleted successfully"));

                // Send deletion notification email
              //  sendDeletionEmail($user_id, $con);
            } else {
                // No rows affected, user not found
                echo json_encode(array("status" => "fail", "message" => "User not found or already deleted"));
            }
        } catch (Exception $e) {
            // Rollback the transaction in case of an error
            $con->rollback();
            echo json_encode(array("status" => "error", "message" => "Error during deletion: " . $e->getMessage()));
        } finally {
            // Close the statements and connection
            $stmtReservations->close();
            $stmtUser->close();
            $con->close();
        }
    } else {
        // 'user_id' not set in the POST parameters
        echo json_encode(array("status" => "fail", "message" => "'user_id' parameter is required"));
    }
} else {
    // Only handle POST requests
    echo json_encode(array("status" => "fail", "message" => "Only POST requests are allowed"));
}
?>
