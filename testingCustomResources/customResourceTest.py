import json, boto3, logging
from botocore.vendored import requests

# Define logging properties
log = logging.getLogger()
log.setLevel(logging.INFO)



# Main Lambda function to be excecuted
def lambda_handler(event, context):
    # Initialize the status of the function
    status="SUCCESS"
    responseData = {}


    # Read and log the input value named "Input1"
    inputValue = event['ResourceProperties']['Input1']
    log.info("Input value is:" + inputValue)

    # Transform the input into a new value as an exmaple operation
    data = inputValue + "Thanks to AWS Lambda"
    responseData = {"Message" : data} #If you need to return data use this json object

    # Return the response back to the S3 URL to notify CloudFormation about the code being run
    response=respond(event,context,status,responseData,None)

    # Function returns the response from the S3 URL
    return {
        "Response" :response
    }

def respond(event, context, responseStatus, responseData, physicalResourceId):
    # Build response payload required by CloudFormation
    responseBody = {}
    responseBody['Status'] = responseStatus
    responseBody['Reason'] = 'Details in: ' + context.log_stream_name
    responseBody['PhysicalResourceId'] = context.log_stream_name
    responseBody['StackId'] = event['StackId']
    responseBody['RequestId'] = event['RequestId']
    responseBody['LogicalResourceId'] = event['LogicalResourceId']
    responseBody['Data'] = responseData

    # Convert json object to string and log it
    json_responseBody = json.dumps(responseBody)
    log.info("Response body: " + str(json_responseBody))

    # Set response URL
    responseUrl = event['ResponseURL']

    # Set headers for preparation for a PUT
    headers = {
    'content-type' : '',
    'content-length' : str(len(json_responseBody))
    }

    # Return the response to the signed S3 URL
    try:
        response = requests.put(responseUrl,
        data=json_responseBody,
        headers=headers)
        log.info("Status code: " + str(response.reason))
        status="SUCCESS"
        return status
    # Define what happens if the PUT operation fails
    except Exception as e:
        log.error("send(..) failed executing requests.put(..): " + str(e))
        status="FAILED"
        return status
