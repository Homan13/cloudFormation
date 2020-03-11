#!/bin/bash
#
# Create a new AWS account in AWS Organizations using CloudFormation custom resources
# and the AWS pyton boto library
#

# Remove existing .zip files in working directory
echo Removing any zip files in this directory
rm -rf *.zip

# Zip up the python script for storage to S3
echo Zipping up Lambda code
zip createAccount.zip createAccount.py && chmod 755 createAccount.zip

# Copy zip file over to S3
echo Copying Lambda code to S3
aws s3 cp createAccount.zip s3://create-account/createAccount.zip

# Read in script variables
echo What would you like to name your new account?
read -p 'Account Name: ' AccountName

echo What would you like to name your new Organizational Unit?
read -p 'Organizational Unit: ' OUName

echo What is the account email address?
read -p 'Email Address: ' EmailAddress

echo What is the Parent OU ID?
read -p 'Parent OU ID: ' ParentId

echo What is the Root OU ID?
read -p 'Root OU ID: ' RootID

echo What is your stack name?
read -p 'Stack Name: ' StackName

# Variables
accountName=$AccountName
ouName=$OUName
emailAddress=$EmailAddress
parentId=$ParentId
rootId=$RootID
stackName=$StackName

# Launch CloudFormation stack
aws cloudformation create-stack --stack-name $stackName --template-body file://createAccount.yaml --capabilities CAPABILITY_IAM \
--parameters ParameterKey=AccountName,ParameterValue=$accountName ParameterKey=OUName,ParameterValue=$ouName \
ParameterKey=Email,ParameterValue=$emailAddress ParameterKey=ParentOUID,ParameterValue=$parentId ParameterKey=RootOUID,ParameterValue=$rootId \
ParameterKey=ModuleName,ParameterValue=createAccount ParameterKey=S3Bucket,ParameterValue=create-account ParameterKey=S3Key,ParameterValue=createAccount.zip
