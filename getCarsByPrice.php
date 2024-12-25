<?php
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");
header("Content-Type: application/json");

$con = mysqli_connect("localhost", "root", "", "cars");

if (mysqli_connect_errno()) {
    echo json_encode(["error" => "Failed to connect to MySQL: " . mysqli_connect_error()]);
    exit();
}

$min_price = isset($_GET['min_price']) ? (float)$_GET['min_price'] : 0;
$max_price = isset($_GET['max_price']) ? (float)$_GET['max_price'] : 0;


$sql = "SELECT * FROM carinfo WHERE price BETWEEN ? AND ?";

$stmt = mysqli_prepare($con, $sql);
mysqli_stmt_bind_param($stmt, "dd", $min_price, $max_price);

if (mysqli_stmt_execute($stmt)) {
    $result = mysqli_stmt_get_result($stmt);
    $carsArray = [];

    while ($row = mysqli_fetch_assoc($result)) {
        $carsArray[] = $row;
    }

    echo json_encode($carsArray);

    mysqli_free_result($result);
    mysqli_close($con);
} else {
    echo json_encode(["error" => "Failed to execute query: " . mysqli_error($con)]);
    mysqli_close($con);
}
?>
