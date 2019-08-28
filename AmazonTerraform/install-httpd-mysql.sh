### USAGE: MySQL Install for AWS EC2 Server / httpd Install
#! /bin/bash
sudo yum update
sudo yum install -y httpd
sudo chkconfig httpd on
sudo service httpd start
echo "<h1>ELB Has Been Deployed</h1>" | sudo tee /var/www/html/index.html
echo "<h2>Author: Paris</h2>" | sudo tee /var/www/html/index.html
echo
echo "*** Install MySQl *****"
sudo yum install mysql-server
sudo chkconfig mysql-server on
sudo service mysql-server start
exit $?