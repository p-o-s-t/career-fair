<?php
if (isset($_POST['ip'])) {
    $ip = $_POST['ip'];
    // VULNERABLE: Direct concatenation of user input into a shell command
    $output = shell_exec("ping -c 4 " . $ip);
    echo "<pre>$output</pre>";
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Network Diagnostics Tool</title>
</head>
<body>
    <h1>Internal Network Ping Tool</h1>
    <p>Enter an IP address to ping:</p>
    <form method="POST">
        <input type="text" name="ip" placeholder="127.0.0.1">
        <input type="submit" value="Ping">
    </form>
</body>
</html>
