#Import modules
import json, boto3, logging
from botocore.vendored import requests

#Define logging properties
log = logging.getLogger()
log.setLevel(logging.INFO)



#Main Lambda function to be excecuted
def lambda_handler(event, context):
    #Initialize the status of the function
    status="SUCCESS"
    responseData = {}
    client = boto3.client('organizations')


    #Read and log the input values
    acctName = event['ResourceProperties']['AccountName']
    ouName = event['ResourceProperties']['OUName']
    emailAddress = event['ResourceProperties']['Email']
    parentId = event['ResourceProperties']['ParentOUID']
    rootId = event['ResourceProperties']['RootOUID']
    log.info("Account name is: " + acctName)
    log.info("Organizational Unit name is: " + ouName)
    log.info("Email Address is: " + emailAddress)
    log.info("Parent OU ID is: " + parentId)
    log.info("Root OU ID is: " + rootId )

    #create a new Organizational Unit
    orgResponse = client.create_organizational_unit(
        ParentId=parentId, #My Parent OU. Change for your environment
        Name=ouName
    )

    log.info(orgResponse['OrganizationalUnit']['Id'])
    OUID=str(orgResponse['OrganizationalUnit']['Id'])

    #Create a new Account in the OU Just Created
    acctResponse = client.create_account(
        Email=emailAddress,
        AccountName=acctName
    )

    #Check Account Status
    acctStatusID = acctResponse['CreateAccountStatus']['Id']
    log.info(acctStatusID)

    while True:
        createStatus = client.describe_create_account_status(
            CreateAccountRequestId=acctStatusID
        )
        log.info(createStatus['CreateAccountStatus']['State'])
        if str(createStatus['CreateAccountStatus']['State']) != 'IN_PROGRESS':
            newAccountId = str(createStatus['CreateAccountStatus']['AccountId'])
            break

    #Move Account to new OU
    moveResponse = client.move_account(
        AccountId=newAccountId,
        SourceParentId=rootId, #My root OU. Change for your environment
        DestinationParentId=OUID
    )

    #Set Return Data
    responseData = {"Message" : newAccountId} #If you need to return data use this json object

    #return the response back to the S3 URL to notify CloudFormation about the code being run
    response=respond(event,context,status,responseData,None)

    #Function returns the response from the S3 URL
    return {
        "Response" :response
    }

def respond(event, context, responseStatus, responseData, physicalResourceId):
    #Build response payload required by CloudFormation
    responseBody = {}
    responseBody['Status'] = responseStatus
    responseBody['Reason'] = 'Details in: ' + context.log_stream_name
    responseBody['PhysicalResourceId'] = context.log_stream_name
    responseBody['StackId'] = event['StackId']
    responseBody['RequestId'] = event['RequestId']
    responseBody['LogicalResourceId'] = event['LogicalResourceId']
    responseBody['Data'] = responseData

    #Convert json object to string and log it
    json_responseBody = json.dumps(responseBody)
    log.info("Response body: " + str(json_responseBody))

    #Set response URL
    responseUrl = event['ResponseURL']

    #Set headers for preparation for a PUT
    headers = {
    'content-type' : '',
    'content-length' : str(len(json_responseBody))
    }

    #Return the response to the signed S3 URL
    try:
        response = requests.put(responseUrl,
        data=json_responseBody,
        headers=headers)
        log.info("Status code: " + str(response.reason))
        status="SUCCESS"
        return status
    #Defind what happens if the PUT operation fails
    except Exception as e:
        log.error("send(..) failed executing requests.put(..): " + str(e))
        status="FAILED"
        return status
