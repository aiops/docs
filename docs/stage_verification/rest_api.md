# REST API


<!-- tabs:start -->

#### **web service**
For a web service deployment, replace the placeholder ```$URL``` with ```$URL = https://logsight.ai```

#### **on-premise**
For an on-premise deployment, replace the placeholder ```$URL``` with ```$URL = http://localhost:8080```

<!-- tabs:end -->


## Steps

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

After setting up the prerequisites (i.e., creating user, activate user, and login user), you can send logs to an application.
We recommend sending logs in larger batches to minimize network calls. 
The user can send as many log batches as he wants. 
They will be automatically processed though our analysis pipeline.

To send logs, execute the following request ([specification](https://logsight.ai/swagger-ui/index.html#/Logs/sendLogListUsingPOST)):

<!-- tabs:start -->
#### **Request**
Endpoint
```
POST /api/v1/logs
```
Data

+ `applicationId` or `applicationName` must be provided
+ `logs` is a list of log messages
+ `timestamp` supported follow the formats supported by [dateutil parser](https://dateutil.readthedocs.io/en/stable/parser.html))
+ `level` is the log level
+ `message` is a string

```json
{
  "applicationId": "a26ab2f2-89e9-4e3a-bc9e-66011537f32f", // nullable
  "applicationName": "myapp", // nullable
  "tags": {"tag1": "value1", "tag2": "value2", "tagN": "valueN"},
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
  "applicationId": "a26ab2f2-89e9-4e3a-bc9e-66011537f32f",
  "logsCount": 2,
  "receiptId": "525c5234-9012-4f3b-8f64-c8a6ec418e7a",
  "source": "restBatch"
}
```
+ `logsCount` is the count of the log messages sent in the batch.
+ `receiptId` is identifier of the received log batch.
+ `source` tells the way that this batch was sent (via REST API)
<!-- tabs:end -->


The Stage Verifier can use `tags` to index the logs and to identify a particular set of log records to compare.
Tags are pairs (key, value). For example,

+ version = v1.0.0
+ test_id = AB123CD

To send logs with tags, execute the following request ([specification](https://logsight.ai/swagger-ui/index.html#/Logs/sendLogListUsingPOST)):

<!-- tabs:start -->
#### **Request**
Endpoint
```
POST /api/v1/logs
```
Data
```json
{
  "applicationId": "a26ab2f2-89e9-4e3a-bc9e-66011537f32f", // nullable
  "applicationName": "myapp", // nullable
  "tags": {"version": "v1.1.0", "namespace": "my_namespace"},
  "logs": [
        {
          "level": "INFO",
          "timestamp":"2021-03-23T01:02:51.00700",
          "message":"Finished job execution: Process received messages via MessagingSubsystems for: OpenText; Duration: 0:00:00.006"},
        {
          "level": "INFO",
          "timestamp":"2021-03-23T01:02:51.00700",
          "message":"Finished job execution: Send waiting messages via MessagingSubsystems; Duration: 0:00:00.005"}
        ]
}
```
Example
```
---
```
#### **Response**
```
Status 200 OK
```
```json
{
  "applicationId": "a26ab2f2-89e9-4e3a-bc9e-66011537f32f",
  "logsCount": 2,
  "receiptId": "525c5234-9012-4f3b-8f64-c8a6ec418e7a",
  "source": "restBatch"
}
```
<!-- tabs:end -->


## Verify

After sending the logs, you can compare logs indexed with different tags by send the following request ([specification](https://logsight.ai/swagger-ui/index.html#/Compare/getCompareResultsUsingPOST)):

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
  "candidateTags": {"version": "v1.1.0", "namespace": "my_namespace"},
}
```
Example
```
---
```
#### **Response**
```
Status 200 OK
```
```json
{
  "compareId": "10293ksxXHSAix992",
  "baselineTags": {"version": "v1.0.0", "namespace": "my_namespace"},
  "candidateTags": {"version": "v1.1.0", "namespace": "my_namespace"},
  "link": "$URL/pages/compare?compareId=10293ksxXHSAix992",
  "risk": 0,
  "totalLogCount": 4,
  "baselineLogCount": 2,
  "candidateLogCount": 2,
  "candidateChangePercentage": 0,
  "addedStatesTotalCount": 0,
  "addedStatesFaultPercentage": 0,
  "addedStatesReportPercentage": 0,
  "deletedStatesTotalCount": 0,
  "deletedStatesFaultPercentage": 0,
  "deletedStatesReportPercentage": 0,
  "frequencyChangeTotalCount": 0, 
  "frequencyChangeFaultPercentage": {"decrease": 0, "increase": 0},
  "frequencyChangeReportPercentage": {"decrease": 0, "increase": 0},
  "recurringStatesTotalCount": 2,
  "recurringStatesFaultPercentage": 0,
  "recurringStatesReportPercentage": 0
}
```

+ `risk` - Risk score of the comparison. In case of deployments (new version comparing with old version), the risk translates to `deployment risk`.
+ `totalLogCount` - The total count of log messages from both `tags`.
+ `baselineLogCount` - The total count of log messages from the `baselineTag`.
+ `candidateLogCount` -  The total count of log messages from the `compareTag`.
+ `candidateChangePercentage` - The percentage change in total count of logs from the `candidateTag` compared to `baselineTag`.
+ `addedStatesTotalCount` - Total number of added states from the `candidateTag` compared to `baselineTag`.
+ `addedStatesFaultPercentage` - Percentage of added states, which are identified as faults.
+ `addedStatesReportPercentage` - Percentage of added states, which are identified as report (normal behaviour).
+ `deletedStatesTotalCount` - The total count of deleted states from the `candidateTag` compared to `baselineTag`.
+ `deletedStatesFaultPercentage` - Percentage of deleted states, which are identified as faults.
+ `deletedStatesReportPercentage` - Percentage of deleted states, which are identified as report.
+ `frequencyChangeTotalCount` - The total count of states that changed in occurrence frequency from the `candidateTag` compared to `baselineTag`.
+ `frequencyChangeFaultPercentage` - Percentage of states that changed in occurrence frequency, which are identified as faults.
+ `frequencyChangeReportPercentage` - Percentage of states that changed in occurrence frequency, which are identified as report.
+ `recurringStatesTotalCount` -  The total count of recurring states from the `candidateTag` compared to `baselineTag`.
+ `recurringStatesFaultPercentage` - Percentage of recurring states, which are identified as fault.
+ `recurringStatesReportPercentage` - Percentage of recurring states, which are identified as report.
+ `link` - Link that points to the UI where the user can see a detailed report.
<!-- tabs:end -->
