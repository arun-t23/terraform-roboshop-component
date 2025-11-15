#!/bin/bash

component=$1
environment=$2
dnf install ansible -y
pip install botocore boto3


# ansible-pull -U https://github.com/arun-t23/ansible-roboshop-roles-tf.git -e component=$component main.yaml


REPO_URL=https://github.com/arun-t23/ansible-roboshop-roles-tf.git
REPO_DIR=/opt/roboshop/ansible
ANSIBLE_DIR=ansible-roboshop-roles-tf

mkdir -p $REPO_DIR
mkdir  -p /var/log/roboshop
touch ansible.log

cd $REPO_DIR

## check if the ansible repo is already cloned or not

if [ -d $ANSIBLE_DIR ]; then 
    cd $ANSIBLE_DIR
    git pull
else
    git clone $REPO_URL
    cd $ANSIBLE_DIR
fi

ansible-playbook -e component=$component -e env=$environment main.yaml
