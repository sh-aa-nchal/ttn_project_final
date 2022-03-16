#!/bin/bash
sudo apt update -y
sudo apt install mysql-server -y
sudo mysql -u root <<MYSQL_SCRIPT
CREATE USER 'ttnproject'@'%' IDENTIFIED BY 'ttnproject';
GRANT PRIVILEGE ON *.* TO 'ttnproject'@'%';
CREATE DATABASE projectDB;
MYSQL_SCRIPT

echo "Mysql is created"

