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

mysqlServer needs to accept connections from remote hosts. if remote host connections arent going through, edit this file in mysqlServer to enable this:

    $ sudo vim /etc/mysql/mysql.conf.d/mysqld.cnf

    And replace 'bind-address' 127.0.0.1 with 0.0.0.0

## Connecting remotely from one MySQL server to another without using SSH involves configuring the MySQL servers to allow remote connections and then using MySQL client commands to connect from one server to another. 

Here are the general steps to achieve this:

### 1. Configure MySQL for Remote Access

  On the MySQL server that you want to connect to (let's call it the target server):

  Edit MySQL Configuration:
  Open the MySQL configuration file (usually my.cnf or mysqld.cnf, often found in /etc/mysql/).
    
  Ensure the bind-address is set to 0.0.0.0 to allow connections from any IP, or set it to the specific IP address of the server you'll be connecting from.
    
  Save and close the file.
  
  Grant Remote Access to a MySQL User:
  Log in to MySQL: 
    
    mysql -u root -p.
    
  Grant access to a user: 
  
    GRANT ALL PRIVILEGES ON *.* TO 'username'@'%' IDENTIFIED BY 'password';. 
  
  Replace username and password with appropriate values. The '%' allows connection from any host; replace it with a specific IP if needed.
  
  Flush privileges: 
    
    FLUSH PRIVILEGES;.
    
  Exit MySQL: 
  
    exit
  
  Restart MySQL Service:
    
  Restart the MySQL service to apply changes: 
  
    sudo systemctl restart mysql.

### 2. Open Necessary Ports on Firewall
  Ensure that the firewall on the target server allows incoming connections on MySQL's default port, which is 3306 (unless you've changed it). 
  
  This might involve configuring the server's firewall or the cloud platform's security groups (if it's a cloud-hosted server).

### 3. Connect from the Source Server
  On the server you want to connect from:

  Use MySQL Client Command:
  Connect using: 
  
    mysql -h target_server_ip -u username -p. 
  
  Replace target_server_ip with the target server's IP address and username with the user you granted access to.
  
  Enter the password when prompted.

Important Considerations
Security Risks: 

  Allowing remote connections to your MySQL server can be a significant security risk. Ensure you have strong passwords and consider limiting access to specific IP addresses.

Encryption: 
 
  If security is a concern, consider using SSL/TLS for MySQL connections to encrypt data in transit.

Alternative Methods: 

  VPNs or SSH tunneling are often used for more secure remote connections, but since you've specified not using SSH, these methods are not applicable in this context.
