# REST API


<!-- tabs:start -->

#### **web service**
If you use logsight.ai web service, replace the placeholder ```$URL``` with ```$URL = https://logsight.ai```

#### **on-premise**
If you use logsight.ai on-premise, replace the placeholder ```$URL``` with ```$URL = http://localhost:8080```

<!-- tabs:end -->

Steps:
1. Create and activate user
2. Get token
3. Send logs
4. Verify


## Create and activate user

### Create user

To create a user, send the following request ([specification](https://logsight.ai/swagger-ui/index.html#/Users/createUserUsingPOST)):

<!-- tabs:start -->
#### **Request**

Endpoint
```
POST /api/v1/users
```
Data
```json
{
  "email": "user@company.com",
  "password": "userPassword"
}
```

Example
```
curl -X POST "https://logsight.ai/api/v1/users" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"email\": \"user@company.com\", \"password\": \"userPassword\"}"
```

#### **Response**

The `userId` of the created user is returned. 
The `userId` is used in subsequent requests.

```
Status 201 CREATED
```
```json
{
    "userId": "5441e771-1ea3-41c4-8f31-2e71828693de"
}
```
<!-- tabs:end -->

After the user creation, an email is sent with an activation link containing the `userId` and `activationToken`: 

```
$URL/auth/activate?userId=5441e771-1ea3-41c4-8f31-2e71828693de&activationToken=60af8472-fed8-46f0-9e9b-4f986c2b24dc
```

### Activate user 

> User activation if not required for on-premise installations

To activate a user, send the following request ([specification](https://logsight.ai/swagger-ui/index.html#/Users/activateUserUsingPOST)) using the `userId` and the `activationToken` received by email.


<!-- tabs:start -->
#### **Request**
Endpoint
```
POST /api/v1/users/activate
```
Data
```json
{
  "activationToken": "60af8472-fed8-46f0-9e9b-4f986c2b24dc",
  "userId": "5441e771-1ea3-41c4-8f31-2e71828693de"
}
```
Example
```
curl -X POST "https://logsight.ai:443/api/v1/users/activate" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"activationToken\": \"60af8472-fed8-46f0-9e9b-4f986c2b24dc\", \"userId\": \"5441e771-1ea3-41c4-8f31-2e71828693de\"}"
```
#### **Response**
```
Status 200 OK
```
<!-- tabs:end -->


## Get token

An authorization token is required to invoke functionalities.
Each token is valid for 10 days.
To receive a token, send the following request ([specification](https://logsight.ai/swagger-ui/index.html#/Authentication/loginUsingPOST)):

<!-- tabs:start -->
#### **Request**
Endpoint
```
POST /api/v1/auth/login
```
Data
```json
{
  "email": "user@company.com",
  "password": "userPassword"
}
```
Example
```
curl -X POST "https://logsight.ai/api/v1/auth/login" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"email\": \"user@company.com\", \"password\": \"userPassword\"}"
```
#### **Response**
```
Status 200 OK
```
Data
```json
{
  "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9…",
  "user": {
    "userId": "5441e771-1ea3-41c4-8f31-2e71828693de",
    "email": "user@company.com"
  }
}
```
<!-- tabs:end -->

## Send logs

After setting up the prerequisites (i.e., creating user, activate user, and login), you can send logs of an application.
We recommend sending logs in larger batches to minimize network calls. 
You can send as many log batches as you need. 
They will be automatically processed though our analysis pipeline.

To send logs, execute the following request ([specification](https://logsight.ai/swagger-ui/index.html#/Logs/sendLogListUsingPOST)):

<!-- tabs:start -->
#### **Request**
Endpoint
```
POST /api/v1/logs
```
Data

+ `tags` are custom pairs (key, value) you choose to index and identify sets of logs, e.g., (version, v1.0.0), (namespace, docker_01)
+ `logs` is a list of log messages
+ `timestamp` follow the formats supported by [dateutil parser](https://dateutil.readthedocs.io/en/stable/parser.html)
+ `level` is the log level
+ `message` is a text string

```json
{
  "tags": {"my_tag": "my_key", "version": "v1.0.0", "namespace": "docker_01", "region": "EU"},
  "logs": [
        {
          "level": "INFO",
          "timestamp":"2021-03-23T01:02:51.00700",
          "message":"Finished job execution: Process received messages via MessagingSubsystems for: OpenText; Duration: 0:00:00.006"
        },
        {
          "level": "INFO",
          "timestamp":"2021-03-23T01:02:51.00700",
          "message":"Finished job execution: Send waiting messages via MessagingSubsystems; Duration: 0:00:00.005"
        }
        ]
}
```
Example
```
curl -X POST "https://logsight.ai/api/v1/logs" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"logs\": [ { \"id\": \"string\", \"level\": \"string\", \"message\": \"string\", \"tags\": { \"additionalProp1\": \"string\", \"additionalProp2\": \"string\", \"additionalProp3\": \"string\" }, \"timestamp\": \"string\" } ], \"tags\": { \"additionalProp1\": \"string\", \"additionalProp2\": \"string\", \"additionalProp3\": \"string\" }}"
```
#### **Response**
```
Status 200 OK
```
Data
```json
{
  "receiptId": "3eb1f26c-b3fa-44cc-93ef-db5a123e6dbd",
  "logsCount": 1,
  "batchId": "becc0a2b-4d52-4d82-a994-be9518126c0b",
  "status": "PROCESSING"
}
```
+ `receiptId` is identifier of the received log batch
+ `logsCount` is the count of the log messages sent in the batch
+ `batchId` id of the batch sent 
+ `status` status of the data sent
<!-- tabs:end -->


## Verify

After sending the logs, you can compare logs using the tags attached during indexing by send the following request ([specification](https://logsight.ai/swagger-ui/index.html#/Compare/getCompareResultsUsingPOST)):

<!-- tabs:start -->
#### **Request**
Endpoint
```
POST /api/v1/logs/compare
```
Data
```json
{
  "baselineTags": {"version": "v1.0.0", "namespace": "my_namespace"},
  "candidateTags": {"version": "v1.1.0", "namespace": "my_namespace"}
}
```
Example
```
curl -X POST "https://logsight.ai/api/v1/logs/compare" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"baselineTags\": { \"additionalProp1\": \"string\", \"additionalProp2\": \"string\", \"additionalProp3\": \"string\" }, \"candidateTags\": { \"additionalProp1\": \"string\", \"additionalProp2\": \"string\", \"additionalProp3\": \"string\" }, \"logReceiptId\": \"3fa85f64-5717-4562-b3fc-2c963f66afa6\"}"
```
#### **Response**
```
Status 200 OK
```
```json
{
  "link": "$URL/pages/compare?compareId=OEXgyoIBS8fluoWJkMPW",
  "baselineTags": {
    "version": "v1.0.0",
    "namespace": "my_namespace"
  },
  "candidateTags": {
    "version": "v1.1.0",
    "namespace": "my_namespace"
  },
  "compareId": "OEXgyoIBS8fluoWJkMPW",
  "risk": 100,
  "totalLogCount": 58,
  "baselineLogCount": 20,
  "candidateLogCount": 38,
  "candidateChangePercentage": 32,
  "addedStatesTotalCount": 1,
  "addedStatesReportPercentage": 0,
  "addedStatesFaultPercentage": 100,
  "deletedStatesTotalCount": 0,
  "deletedStatesReportPercentage": 0,
  "deletedStatesFaultPercentage": 0,
  "recurringStatesTotalCount": 4,
  "recurringStatesReportPercentage": 0,
  "recurringStatesFaultPercentage": 100,
  "frequencyChangeTotalCount": 4,
  "frequencyChangeReportPercentage": {
    "increase": 75,
    "decrease": 0
  },
  "frequencyChangeFaultPercentage": {
    "increase": 25,
    "decrease": 0
  }
}
```

+ `risk`. Deployment risk score.
+ `totalLogCount`. Total count of log messages from both `tags`.
+ `baselineLogCount`. Total count of log messages from the `baselineTag`.
+ `candidateLogCount`. Total count of log messages from the `compareTag`.
+ `candidateChangePercentage`. Percentage change in total count of logs from the `candidateTag` compared to `baselineTag`.
+ `addedStatesTotalCount`. Total number of added states from the `candidateTag` compared to `baselineTag`.
+ `addedStatesFaultPercentage`. Percentage of added states identified as FAULT.
+ `addedStatesReportPercentage`. Percentage of added states identified as REPORT.
+ `deletedStatesTotalCount`. Total count of deleted states from the `candidateTag` compared to `baselineTag`.
+ `deletedStatesFaultPercentage`. Percentage of deleted states identified as FAULT.
+ `deletedStatesReportPercentage`. Percentage of deleted states identified as REPORT.
+ `frequencyChangeTotalCount`. Total count of states that changed in occurrence frequency from the `candidateTag` compared to `baselineTag`.
+ `frequencyChangeFaultPercentage`. Percentage of states that changed in occurrence frequency identified as FAULT.
+ `frequencyChangeReportPercentage`. Percentage of states that changed in occurrence frequency identified as REPORT.
+ `recurringStatesTotalCount`. Total count of recurring states from the `candidateTag` compared to `baselineTag`.
+ `recurringStatesFaultPercentage`. Percentage of recurring states identified as REPORT.
+ `recurringStatesReportPercentage`. Percentage of recurring states identified as REPORT.
+ `link`. Webpage link with a detailed report.
<!-- tabs:end -->
