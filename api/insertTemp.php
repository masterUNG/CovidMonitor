<?php
	include 'connected.php';
	header("Access-Control-Allow-Origin: *");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
				
		$idUser = $_GET['idUser'];
		$recDateTime = $_GET['recDateTime'];
		$recHourTime = $_GET['recHourTime'];
		$recTemp = $_GET['recTemp'];
		$urlTemp = $_GET['urlTemp'];

							
		$sql = "INSERT INTO `temp`(`id`, `idUser`, `recDateTime`, `recHourTime`, `recTemp`, `urlTemp`) VALUES (Null,'$idUser','$recDateTime','$recHourTime','$recTemp','$urlTemp')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Master UNG";
   
}
	mysqli_close($link);
?>