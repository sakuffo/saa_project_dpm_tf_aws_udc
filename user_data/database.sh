#!/bin/bash
yum update -y
service mysqld start
chkconfig mysqld on
# # create random password
# PASSWDDB="pleasechangeme"
# # replace "-" with "_" for database username
# MAINDB=${USER_NAME//[^a-zA-Z0-9]/_}

# mysql -u root -p<<MYSQL_SCRIPT
# CREATE DATABASE $MAINDB;

# CREATE DATABASE ${MAINDB} /*\!40100 DEFAULT CHARACTER SET utf8 */;
# CREATE USER ${MAINDB}@localhost IDENTIFIED BY '${PASSWDDB}';
# GRANT ALL PRIVILEGES ON ${MAINDB}.* TO '${MAINDB}'@'localhost';
# FLUSH PRIVILEGES;
# USE ${MAINDB};
# CREATE TABLE Persons (PersonID int, LastName varchar(255), FirstName varchar(255));
# INSERT INTO `Persons`(`PersonID`, `LastName`, `FirstName`) VALUES (0, 'Sheldon Cooper','Male');
# MYSQL_SCRIPT