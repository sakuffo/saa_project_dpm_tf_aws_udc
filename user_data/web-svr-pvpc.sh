#!/bin/bash
sudo su
yum -y install httpd
sudo systemctl enable httpd
sudo systemctl start httpd
RDS_MYSQL_ENDPOINT="ec2-user"
RDS_MYSQL_USER="your-username-goes-here"
RDS_MYSQL_PASS="pleasechangeme"
RDS_MYSQL_BASE="your-database-name-goes here"
mysql -h $RDS_MYSQL_ENDPOINT -u $RDS_MYSQL_USER -p$RDS_MYSQL_PASS -D $RDS_MYSQL_BASE -e 'quit'
if [[ $? -eq 0 ]]; then
    echo "<p> My Instance! PRIMARY VPC!</p>" \n "MySQL connection: OK"; >> /var/www/html/index.html
else
    echo "<p> My Instance! PRIMARY VPC!</p>" \n "MySQL connection: FAIL"; >> /var/www/html/index.html
fi;

