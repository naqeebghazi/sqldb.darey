#!/bin/bash
git pull
git add .
git commit -am 'images'
git push


# ssh -i /Users/nghazi/Downloads/ec2-nghazi.pem ubuntu@ec2-18-132-15-167.eu-west-2.compute.amazonaws.com