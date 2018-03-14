<?php

	// this will avoid mysql_connect() deprecation error.
	error_reporting( ~E_DEPRECATED & ~E_NOTICE );
	// but I strongly suggest you to use PDO or MySQLi.

	define('DBHOST', 'db720567166.db.1and1.com:3306');/*db720567166.db.1and1.com:3306*/
	define('DBUSER', 'dbo720567166');/*dbo720567166*/
	define('DBPASS', 'Lovetest1&');/*Lovetest1&*/
	define('DBNAME', 'db720567166');

	$conn = mysql_connect(DBHOST,DBUSER,DBPASS);
	$dbcon = mysql_select_db(DBNAME);

	if ( !$conn ) {
		die("Connection failed : " . mysql_error());
	}

	if ( !$dbcon ) {
		die("Database Connection failed : " . mysql_error());
	}
