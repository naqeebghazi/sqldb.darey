

mysqlClient: ssh -i /Users/nghazi/Downloads/ec2-nghazi.pem ubuntu@ec2-3-9-180-167.eu-west-2.compute.amazonaws.com

mysqlServer: ssh -i /Users/nghazi/Downloads/ec2-nghazi.pem ubuntu@ec2-13-41-108-200.eu-west-2.compute.amazonaws.com

###############

$ scp -r directoryname/ user1@ipaddress:/home/user1/uploadfiles 

scp -r ubuntu@ec2-3-8-208-169.eu-west-2.compute.amazonaws.com:/home/pem /Users/nghazi/Downloads/ec2-nghazi.pem

scp ~/.ssh/id_rsa.pub ubuntu@ec2-3-8-208-169.eu-west-2.compute.amazonaws.com:~/.ssh/authorized_keys


scp -i /Users/nghazi/Downloads/ec2-nghazi.pem -r /Users/nghazi/Downloads/ec2-nghazi.pem ubuntu@3.8.208.169:/var/www/html/pem/

sudo chown user1:admin /var/www/html/pem


File to transfer:
/Users/nghazi/Downloads/ec2-nghazi.pem

ssh-copy-id -i /Users/nghazi/.ssh/id_rsa.pub ubuntu@3.8.208.169

ssh-copy-id ubuntu@3.8.208.169
ssh-copy-id ubuntu@ip-172-31-36-34

cat ~/.ssh/id_rsa.pub | ssh ubuntu@ec2-3-8-208-169.eu-west-2.compute.amazonaws.com "cat >> ~/.ssh/authorized_keys"


#################

sudo ufw allow from 172.31.16.206 to any port 3306      # Ref: https://phoenixnap.com/kb/mysql-remote-connection
#Create zones for mysql server traffic:

    sudo firewall-cmd --new-zone=mysqlrule --permanent
    sudo firewall-cmd --reload
    sudo firewall-cmd --permanent --zone=mysqlrule --add-source=172.31.16.206
    sudo firewall-cmd --permanent --zone=mysqlrule --add-port=3306/tcp
    sudo firewall-cmd --reload

# To limit access to a specific ip address:
sudo iptables -A INPUT -p tcp -s 172.31.16.206 --dport 3306 -j ACCEPT

#Connect to remote mysql server from your local machine:
mysql -u ubuntu -h 13.41.108.200 -p

MySQL

# Check MySQL User and Host permissions:
SELECT host, user FROM mysql.user WHERE user = 'ubuntu'


GRANT ALL PRIVILEGES ON *.* TO ubuntu@172.31.16.206 IDENTIFIED BY 'pop'

On mysqlClient to connect to mysqlServer:

    mysql -h 172.31.43.152 -u ubuntu -p