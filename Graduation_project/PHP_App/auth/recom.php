<?php

$serverKey = 'AAAAn9tZv8U:APA91bFiPSZaVkm2KygNE3RIpBcgtqdhCIKPmGbhyE-AIJvTmWXQ8YHdIHcY7iuyEPmjutxMrds5sJ32yHNE83vtR4SxuvEyr7I1KEZ0HoWW_sBujurPt7P1k-KwWhQe5XA8gtyHRs0H';

// Craftsmen FCM token (received from the Flutter app)
$craftsmenFcmToken = $_POST['fcm_token'];

// Message to be sent in the notification
$message = $_POST['message'];

// Firebase Cloud Messaging endpoint
$endpoint = 'https://fcm.googleapis.com/fcm/send';

// Construct the FCM payload
$data = [
    'to' => $craftsmenFcmToken,
    'notification' => [
        'title' => 'Reservation Deleted',
        'body' => $message,
        'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
    ],
    'data' => [
        'notification_type' => 'recommendation',
    ],
    'android' => [
        'notification' => [
            'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
            'channel_id' => 'your_channel_id',
            'icon' => 'your_icon',
        ],
    ],
    'apns' => [
        'payload' => [
            'aps' => [
                'category' => 'your_category',
            ],
        ],
    ],
];

// Prepare headers
$headers = [
    'Authorization: key=' . $serverKey,
    'Content-Type: application/json',
];

// Initialize cURL session
$ch = curl_init();

// Set cURL options
curl_setopt($ch, CURLOPT_URL, $endpoint);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));

// Execute cURL session and get the response
$response = curl_exec($ch);

// Check for cURL errors
if (curl_errno($ch)) {
    echo 'FCM request failed: ' . curl_error($ch);
}

// Close cURL session
curl_close($ch);

// Output the FCM response (for debugging purposes)
echo $response;

?>
