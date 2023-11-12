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

Client inbound rules (in client's Security Group):

![Client inbound rules](https://github.com/naqeebghazi/sqldb.darey/blob/main/images/clientInboundrules.png?raw=true)

Server inbound rules (in servers's Security Group):

![serverinboundrules](https://github.com/naqeebghazi/sqldb.darey/blob/main/images/serverInboundrules.png?raw=true)

Update the package manager. Install MySQL on both servers. 

    $ sudo apt update -y
    $ sudo apt install mysql-server -y
    $ sudo mysql_secure_installation -y

Last command is optional for secure_installation. Enter Y for everything or do the -y flag to automate this process. When you're practising, you can enter no for the first prompt about password validation/strength.

Check MySQL is running on both systems, client and server:

    $ sudo systemctl status mysql

You should see 'active(running)' in green:

![mysqlrunning](https://github.com/naqeebghazi/sqldb.darey/blob/main/images/mysqlrunning.png?raw=true)


## Connect CLient to Server via SSH

Connecting remotely from one MySQL server to another without using SSH involves configuring the MySQL servers to allow remote connections and then using MySQL client commands to connect from one server to another. 

Here are the general steps to achieve this:

### 1. Configure MySQL for Remote Access

  On the mysqlServer that you want to connect to (i.e. target server):

  Edit MySQL Configuration:
  Open the MySQL configuration file (usually my.cnf or mysqld.cnf, often found in /etc/mysql/).

      $ sudo vim /etc/mysql/mysql.conf.d/mysqld.cnf
    
  Ensure the 'bind-address' is set to 0.0.0.0 to allow connections from any IP, or set it to the specific IP address of the server you'll be connecting from:

  ![bindaddress](https://github.com/naqeebghazi/sqldb.darey/blob/main/images/bindAddress.png?raw=true)
    
  Save and close the file:

      Esc > :wq
        
  Grant Remote Access to a MySQL User:
  Log in to MySQL: 
    
    sudo mysql -u root -p

If you arent able to login, restart the mysql then re-enter the above login and press ENTER when prompted for a password:

    $ sudo systemctl restart mysql
  
  Grant access to a user: 
  
    GGRANT ALL PRIVILEGES ON *.* TO 'ubuntu'@'%' WITH GRANT OPTION;
  
  Replace username and password with appropriate values. Maintain apotrophes. The '%' allows connection from any host; replace it with a specific IP if needed.
  
  Flush privileges: 
    
    FLUSH PRIVILEGES
    
  Exit MySQL: 
  
    exit
  
  Restart MySQL Service:
    
  Restart the MySQL service to apply changes: 
  
    $ sudo systemctl restart mysql
    

### 2. Open Necessary Ports on Firewall
  Ensure that the firewall on the target server allows incoming connections on MySQL's default port, which is 3306 (unless you've changed it). 
  
  This might involve configuring the server's firewall or the cloud platform's security groups (if it's a cloud-hosted server).

### 3. Connect from the Source Server
  On the server you want to connect from (mysqlClient):

  Use MySQL Client Command:
  Connect using: 
  
    mysql -u ubuntu -h 172.32.55.45 -p
  
  Replace 'ubuntu' with the target server's username and the IP address with your target private/public IP address. This is what the suucessful login will look like on the client:

  ![sqlLoginSuccess](https://github.com/naqeebghazi/sqldb.darey/blob/main/images/mysqlLoginSuccess.png?raw=true)
  
You can then create a username on the client ('lex' in this example:

    > CREATE USER 'lex'@'%' IDENTIFIED BY 'pop';

The name must be in ''. The '%' means any ip address.  
Login to the server seperately and check the username 'lex' (as in this example) is there by typing:

      > select user from mysql.`user`;

  Result is that the server has a new user written into its databse:

  ![lexuser](https://github.com/naqeebghazi/sqldb.darey/blob/main/images/lexuser.png?raw=true)
  

Important Considerations
Security Risks: 

  Allowing remote connections to your MySQL server can be a significant security risk. Ensure you have strong passwords and consider limiting access to specific IP addresses.

Encryption: 
 
  If security is a concern, consider using SSL/TLS for MySQL connections to encrypt data in transit.

Alternative Methods: 

  VPNs or SSH tunneling are often used for more secure remote connections, but since you've specified not using SSH, these methods are not applicable in this context.
