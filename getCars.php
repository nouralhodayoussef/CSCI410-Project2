<?php
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");
header("Content-Type: application/json");

$con = mysqli_connect("localhost", "root", "", "cars");

// Check connection
if (mysqli_connect_errno()) {
    echo json_encode(["error" => "Failed to connect to MySQL: " . mysqli_connect_error()]);
    exit();
}

$sql = "SELECT * FROM carinfo";

if ($result = mysqli_query($con, $sql)) {
    $carsArray = array();

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
