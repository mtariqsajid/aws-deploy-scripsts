#!/bin/bash

# Install MySQL
sudo apt-get update
sudo apt-get install mysql-server

# Start MySQL service
sudo systemctl start mysql


# Create my.cnf file with MySQL native password configuration
echo "[mysqld]" | sudo tee /etc/mysql/my.cnf > /dev/null
echo "default_authentication_plugin=mysql_native_password" | sudo tee -a /etc/mysql/my.cnf > /dev/null


# Create new user with password
sudo mysql -u root -e "CREATE USER 'root'@'%' IDENTIFIED BY 'root';"

# Enable native password for all users
sudo mysql -u root -e "ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'root';"

# Grant necessary permissions to new user
sudo mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';"

# Restart MySQL service
sudo systemctl restart mysql

echo "MySQL installation complete!"
