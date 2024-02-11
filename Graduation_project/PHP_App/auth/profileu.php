<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// Replace these with your database details
$host = 'localhost';
$db   = 'onduty';
$user = 'root';
$pass = '';
$charset = 'utf8mb4';

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
try {
    $pdo = new PDO($dsn, $user, $pass);
} catch (\PDOException $e) {
    echo json_encode(["error" => $e->getMessage()]);
    exit();
}

// Check if "user_name" parameter is provided
if (!isset($_GET["user_name"])) {
    echo json_encode(["error" => "user_name parameter not provided"]);
    exit();
}
$userId = $_GET["user_name"];

$stmt = $pdo->prepare("SELECT user_name FROM Users WHERE user_name = ?");
$stmt->execute([$userId]);

$user = $stmt->fetch();
if (!$user) {
    echo json_encode(["error" => "No user found with the given user_name"]);
    exit();
}

echo json_encode($user);
?>
