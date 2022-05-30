#!/bin/bash

sudo yum update -y

sudo yum install java-1.8.0-openjdk -y

sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key 

sudo yum install jenkins -y

sudo service jenkins start









