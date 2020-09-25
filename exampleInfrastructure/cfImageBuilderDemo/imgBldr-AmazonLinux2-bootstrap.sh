#!/bin/bash
#
# This script will install some basic packages as a demo for EC2 Image Builder
#
# Install Python 3 and Pip
echo Installing Python 3 and GCC
yum install -y python3 gcc &&
echo Installing and configuring Pip
curl -O https://bootstrap.pypa.io/get-pip.py &&
python3 get-pip.py &&
export PATH=/root/.local/bin:$PATH &&
source /root/.bash_profile &&
export PATH=/home/ec2-user/.local/bin:$PATH &&
source /home/ec2-user/.bash_profile &&

# Install the AWS Agent for Amazon Inspector
echo Installing the AWS agent for Amazon Inspector
wget https://d1wk0tztpsntt1.cloudfront.net/linux/latest/install &&
bash install &&

# Install the SSM agent
echo Installing the EC2 SSM agent
mkdir /tmp/ssm &&
yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm &&
systemctl status amazon-ssm-agent

# Install Sophos AV for Linux
echo Installing Sophos anti-virus for Linux
cd ~
aws s3 cp s3://cf-imagebuilder-demo/sav-linux-free-9.tgz sav-linux-free-9.tgz &&
tar xvzf sav-linux-free-9.tgz
cd sophos-av &&
./install.sh --automatic --acceptlicense /opt/sophos-av &&

# Clean up Instance
echo Removing all installation packages
rm -rf ~/install &&
rm -rf /tmp/ssm &&
rm -rf ~/sav-linux-free-9.tgz &&
rm -rf ~/sophos-av &&
