<?php
// Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Collect user input
    $name = trim($_POST["name"]);
    $email = trim($_POST["email"]);
    $password = $_POST["password"];
    $userType = $_POST["userType"];

    // Validate email format
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        die("Invalid email address");
    }

    // Validate password length (you can add more criteria)
    if (strlen($password) < 6) {
        die("Password must be at least 6 characters long");
    }

    // Replace these values with your actual database credentials
    $servername = "your_server";
    $username = "your_username";
    $password_db = "your_password";
    $dbname = "your_database";

    // Create a connection
    $conn = new mysqli($servername, $username, $password_db, $dbname);

    // Check the connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Insert user data into the database (you may need to hash the password)
    $hashedPassword = password_hash($password, PASSWORD_DEFAULT);
    $sql = "INSERT INTO users (name, email, password, user_type) VALUES ('$name', '$email', '$hashedPassword', '$userType')";

    if ($conn->query($sql) === TRUE) {
        // Redirect to the appropriate dashboard based on user type
        if ($userType === 'seller') {
            header("Location: seller_dashboard.html");
        } else {
            // Redirect buyers or other user types to their respective dashboards
            header("Location: buyer_dashboard.html");
        }
        exit();
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }

    // Close the database connection
    $conn->close();
} else {
    // Redirect to the signup page if the form is not submitted
    header("Location: signup.html");
    exit();
}
?>
