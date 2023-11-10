# How to implement a Client-Server Architecture using a MySQL Database Management system

## Create 2 Linux servers on AWS with the names:
  - mysqlServer
  - mysqlClient

On mysqlServer, install: MySQL Server
On mysqlClient, install: MySQL Client

Change the server hostnames by going to this file and typing the above names for each server. then reboot the instances.

    $ sudo vim /etc/hostname
    $ sudo reboot now

Ensure both ec2 instances are on the same VPC network. 

![ec2instances](https://github.com/naqeebghazi/sqldb.darey/blob/main/images/ec2instances.png?raw=true)

Ensure there is a seperate Security Group (SG) for the mysqlServer. Allows two connection types, ssh and mysql on ports 22 and 3306 respectively. 
Ensure the outbound rules for both SGs are set to All traffic and All ipv4 addresses. 

![mysqlserverSG](https://github.com/naqeebghazi/sqldb.darey/blob/main/images/mysqlServerSG.png?raw=true)

Update the package manager. Install MySQL on both servers. 

    $ sudo apt update
    $ sudo apt install mysql-server
    $ sudo mysql_secure_installation

For the last command of secure_installation, enter Y for everything. As your practising, you can enter no for the first prompt about password validation/strength.

Check MySQL is running on both systems:

    $ sudo systemctl status mysql

You should see 'active(running)' in green:

![mysqlrunning](https://github.com/naqeebghazi/sqldb.darey/blob/main/images/mysqlrunning.png?raw=true)

mysqlServer needs to accept connections from remote hosts. if rmeote host connections arent going through, edit this file to enable this:

    $ sudo vim /etc/mysql/mysql.conf.d/mysqld.cnf

And replace 127.0.0.1 with 0.0.0.0

