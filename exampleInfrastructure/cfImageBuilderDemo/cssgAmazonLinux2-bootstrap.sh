#!/bin/bash
#
# This script will install all CSSG required packages and applications, and enable them on an Amazon Linux 2 based instance
#
# Install necessary tools required on CSSG AMI's
echo Installing Python 3 and GCC
yum install -y python3 gcc &&
echo Installing and configuring Pip
curl -O https://bootstrap.pypa.io/get-pip.py &&
python3 get-pip.py &&
export PATH=/root/.local/bin:$PATH &&
source /root/.bash_profile &&
export PATH=/home/ec2-user/.local/bin:$PATH &&
source /home/ec2-user/.bash_profile &&

# Configure the AWS CLI
## Create an AWS CLI credentials and config file
echo Creating an AWS CLI credentials and config file
mkdir /home/ec2-user/.aws
chown -R ec2-user: /home/ec2-user/.aws
cat <<'EOF' > /home/ec2-user/.aws/credentials
[default]
aws_access_key=
aws_secret_access_key=
EOF
cat <<'EOF' > /home/ec2-user/.aws/config
[default]
region=us-east-1
output=json
EOF
mkdir /root/.aws
cat <<'EOF' > /root/.aws/credentials
[default]
aws_access_key=
aws_secret_access_key=
EOF
cat <<'EOF' > /root/.aws/config
[default]
region=us-east-1
output=json
EOF

# Install, configure and enable CloudWatch Logs on the AMI
## Install the CloudWatch logs agent
echo Installing the CloudWatch logs agent
yum install -y awslogs
## Configure the CloudWatch logs agent
echo Configuring the CloudWatch logs agent
STREAM=gold-amznLinux_$(date +%Y-%m-%d)
sed -i 's/log_stream_name = {instance_id}/log_stream_name = {hostname}/' /etc/awslogs/awslogs.conf
sed -i 's,log_group_name = /var/log/messages,log_group_name = Syslog-Log-Group,' /etc/awslogs/awslogs.conf
systemctl start awslogsd &&
systemctl enable awslogsd.service &&

# Install the AWS Agent for Amazon Inspector
echo Installing the AWS agent for Amazon Inspector
wget https://d1wk0tztpsntt1.cloudfront.net/linux/latest/install &&
bash install &&

# Install and configure the Splunk universal forwarder
## Install and start the Splunk universal forwarder
echo Installing and starting the Splunk universal forwarder
wget -O splunkforwarder-6.5.2-67571ef4b87d-linux-2.6-x86_64.rpm 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=6.5.2&product=universalforwarder&filename=splunkforwarder-6.5.2-67571ef4b87d-linux-2.6-x86_64.rpm&wget=true' &&
rpm -i splunkforwarder-6.5.2-67571ef4b87d-linux-2.6-x86_64.rpm &&
/opt/splunkforwarder/bin/splunk start --accept-license &&
## Configure the Splunk universal forwarder
echo Configuring the Splunk universal forwarder
/opt/splunkforwarder/bin/splunk enable boot-start &&
/opt/splunkforwarder/bin/splunk add forward-server 10.4.5.135:9997 -auth admin:changeme &&
/opt/splunkforwarder/bin/splunk add forward-server 10.4.5.230:9997 -auth admin:changeme &&
/opt/splunkforwarder/bin/splunk add monitor /var/log &&
/opt/splunkforwarder/bin/splunk restart &&
wait 45
/opt/splunkforwarder/bin/splunk show default-hostname -auth admin:changeme &&
cat /opt/splunkforwarder/etc/system/local/outputs.conf &&

# Install the SSM agent
echo Installing the EC2 SSM agent
mkdir /tmp/ssm &&
yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm &&
systemctl status amazon-ssm-agent

# Install the Tenable scanner
echo Installing the Nessus Tenable scanner
cd /tmp &&
aws s3 cp s3://cssg-sndbx-ami-artifacts/NessusAgent-7.6.1-amzn.x86_64.rpm NessusAgent-7.6.1-amzn.x86_64.rpm &&
rpm -ivh NessusAgent-7.6.1-amzn.x86_64.rpm &&

# Install Sophos AV for Linux
echo Installing Sophos anti-virus for Linux
cd ~
aws s3 cp s3://cssg-sndbx-ami-artifacts/sav-linux-free-9.tgz sav-linux-free-9.tgz &&
tar xvzf sav-linux-free-9.tgz
cd sophos-av &&
./install.sh --automatic --acceptlicense /opt/sophos-av &&

# Set motd with Northrop InfoSec Mandated Banner
echo Setting the instance logon banner
touch /etc/update-motd.d/40-notification
echo -e "#!/bin/sh\ncat << EOF\nThis system is for authorized users only. Individual use of this computer system and/or network without authority, or in excess of your authority, is strictly prohibited. Monitoring of transimissions or transactional information may be conducted to ensure the proper funcitoning and security of electronic communication resources.\nEOF" | tee -a /etc/update-motd.d/40-notification &&
chmod +x /etc/update-motd.d/40-notification
update-motd &&

# Configure Ansible user for instance
useradd -G wheel AnsibleUser &&
SSM_PARAM=$(aws ssm get-parameters --names "AnsibleUser" --with-decryption --query "Parameters[0].Value" | tr -d '"') &&
echo $SSM_PARAM | passwd --stdin AnsibleUser &&

#Configure NTP Client to attach to CSSG NTP Server
yum update -y
yum install ntp -y
sed -i 's/^server /#&/' /etc/ntp.conf
awk '/#server 3.amazon.pool.ntp.org iburst/ {print; print "server 10.4.2.21 prefer"; next}1' /etc/ntp.conf >> /tmp/ntp3.conf
mv /tmp/ntp3.conf /etc/ntp.conf
systemctl enable ntpd
systemctl start ntpd

# Clean up Instance
echo Removing all installation packages
rm -rf ~/install &&
rm -rf /tmp/ssm &&
rm -rf /tmp/NessusAgent-7.6.1-amzn.x86_64.rpm &&
rm -rf ~/sav-linux-free-9.tgz &&
rm -rf ~/sophos-av &&
rm -rf /tmp/splunkforwarder-6.5.2-67571ef4b87d-linux-2.6-x86_64.rpm
