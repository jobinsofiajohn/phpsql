yum install httpd
yum install php php-sql

//assuming you have mariadb installed already

mysql -u root -p

MariaDB [(none)]> create database clad;
MariaDB [(none)]> use clado;
MariaDB [(none)]> create table students(NAME CHAR(20), MARK INT(3));

MariaDB [(none)]> insert students values ('jobin','30');
MariaDB [(none)]> insert students values ('amal','30');
MariaDB [(none)]> insert students values ('ajay','30');

MariaDB [(none)]> create user 'jobin'@'localhost' identified by 'jobin';
MariaDB [(none)]> grant all on clado.* to 'jobin'@'localhost';
MariaDB [(none)]> flush privileges;

MariaDB [(none)]> exit

systemctl start httpd
systemctl enable httpd

vim /etc/http/conf/httpd.conf

<VirtualHost *:80>

servername php.table.com
DirectoryIndex index.html
    <Directory /var/www/html/>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

</VirtualHost>


save and exit


vim /var/www/html/table.php

$username = 'jobin';
$password = 'jobin';
$database = 'clado';

$connection = mysqli_connect($hostname, $username, $password, $database);

// Check if the connection was successful
if (!$connection) {
    die("Connection failed: " . mysqli_connect_error());
}
?>

<?php
// Perform the query
$query = "SELECT * FROM students";
$result = mysqli_query($connection, $query);

// Check if the query was successful
if (!$result) {
    die("Query failed: " . mysqli_error($connection));
}
?>

<?php
// Display the table details
echo "<table>";
echo "<tr><th>NAME</th><th>MARK</th>";

while ($row = mysqli_fetch_assoc($result)) {
    echo "<tr>";
    echo "<td>" . $row['NAME'] . "</td>";
    echo "<td>" . $row['MARK'] . "</td>";
    echo "</tr>";
}

echo "</table>";
?>

save and exit



vim /var/www/html/index.html

<html>
<head>
    <title>JOBIN</title>
</head>
<body>
    <h1>Click the link below to view the contents of table students</h1>
    <a href="table.php">table.php</a>
</body>
</html>
save and exit


systemctl restart httpd


//open web browser and search

php.table.com/













