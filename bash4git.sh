#!/bin/bash
git pull
git add .
git commit -am 'images'
git push


mysqlClient: ssh -i /Users/nghazi/Downloads/ec2-nghazi.pem ubuntu@ec2-3-8-208-169.eu-west-2.compute.amazonaws.com

mysqlServer: ssh -i /Users/nghazi/Downloads/ec2-nghazi.pem ubuntu@ec2-18-132-15-167.eu-west-2.compute.amazonaws.com





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