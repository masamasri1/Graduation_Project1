<?php
// Assuming you have a database connection established
include 'connect.php';

// Check if craftmen_id is sent via POST
if (isset($_POST['craftmen_id'])) {
    $targetCraftmenID = $_POST['craftmen_id'];

    // Use prepared statement to avoid SQL injection
    $query = "SELECT craftmen.price
              FROM craftmen
              WHERE craftmen.craftmen_id IN (
                  SELECT reservation.craftmen_id
                  FROM reservation
                  WHERE reservation.craftmen_id = ?
              )";

    $stmt = mysqli_prepare($con, $query);
    mysqli_stmt_bind_param($stmt, "i", $targetCraftmenID); // "i" represents an integer parameter

    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);

    if ($result) {
        $row = mysqli_fetch_assoc($result);

        if ($row) {
            $price = $row['price'];
            echo "Price for craftmen_id $targetCraftmenID: $price";
        } else {
            // Handle case where no matching row is found
            echo "No matching record found for craftmen_id $targetCraftmenID";
        }
    } else {
        // Handle error in the query
        echo "Error retrieving price information: " . mysqli_error($con);
    }

    mysqli_stmt_close($stmt); // Close the prepared statement
} else {
    // Handle case where craftmen_id is not provided via POST
    echo "Please provide a valid craftmen_id via POST.";
}

// Close the database connection
mysqli_close($con);
?>
