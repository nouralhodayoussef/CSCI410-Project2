<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "cars"; 

$conn = new mysqli($servername, $username, $password, $dbname);


if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$user_name = $_POST['user_name'];
$user_email = $_POST['user_email'];
$car_name = $_POST['car_name'];
$car_brand = $_POST['car_brand'];
$car_details = $_POST['car_details'];

$sql = "INSERT INTO car_requests (user_name, user_email, car_name, car_brand, car_details)
VALUES ('$user_name', '$user_email', '$car_name', '$car_brand', '$car_details')";

if ($conn->query($sql) === TRUE) {
    echo "New request submitted successfully!";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
