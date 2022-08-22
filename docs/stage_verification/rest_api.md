# REST API


<!-- tabs:start -->

#### **web service**
For a web service deployment, replace the placeholder ```$URL``` with ```$URL = https://logsight.ai```

#### **on-premise**
For an on-premise deployment, replace the placeholder ```$URL``` with ```$URL = http://localhost:8080```

<!-- tabs:end -->


## Steps

1. `Create and activate user`
2. `Get token`
3. `Send logs`
4. `Verify`


## Create and activate user

### Create user

To create a user, send the following request.

[Request](https://logsight.ai/swagger-ui/index.html#/Users/createUserUsingPOST)

```
POST /api/v1/users
```

```json
{
  "email": "user@company.com",
  "password": "userPassword",
  "repeatPassword": "userPassword"
}
```

[Response](https://logsight.ai/swagger-ui/index.html#/Users/createUserUsingPOST)

```
Status 201 CREATED
```

```json
{
    "userId": "5441e771-1ea3-41c4-8f31-2e71828693de"
}
```
The response that is returned by the endpoint will be the `userId` of the created user. The `userId` has usages in subsequent requests (e.g., when creating application).


### Activate user 

> Not needed in on-premise installation

After the user creation, the user receives an email with activation link. The activation link, for example:

`$URL/auth/activate?userId=5441e771-1ea3-41c4-8f31-2e71828693de&activationToken=60af8472-fed8-46f0-9e9b-4f986c2b24dc`

consists of `userId` and a `activationToken`. There are two options to activate the user:
1. Clicking on the link
2. Taking the `userId` and the `activationToken` and sending an activation request:


[Request](https://logsight.ai/swagger-ui/index.html#/Users/activateUserUsingPOST)

```
POST /api/v1/users/activate
```

```json
{
  "activationToken": "60af8472-fed8-46f0-9e9b-4f986c2b24dc",
  "userId": "5441e771-1ea3-41c4-8f31-2e71828693de"
}
```

[Response](https://logsight.ai/swagger-ui/index.html#/Users/activateUserUsingPOST)

```
Status 200 OK
```

After user activation, the user needs to authenticate by sending the following request


## Get token

Requests, such as creating application, sending logs and verify, require to obtain an authorization token (valid for 10 days).

```
curl -X POST '$URL/api/v1/application'
     -H 'Content-Type: application/json'
     -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9...'
     -d '{"applicatonName": "myservice"}'
```

Clients can obtain a token by making the following call. 

[Request](https://logsight.ai/swagger-ui/index.html#/Authentication/loginUsingPOST)

```
POST /api/v1/auth/login
```

```json
{
  "email": "user@company.com",
  "password": "userPassword"
}
```

[Response](https://logsight.ai/swagger-ui/index.html#/Authentication/loginUsingPOST)

```
Status 200 OK
```

```json
{
  "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9…",
  "user": {
    "userId": "5441e771-1ea3-41c4-8f31-2e71828693de",
    "email": "user@company.com"
  }
}
```

## Send logs

After setting up the prerequisites (i.e., creating user, activate user, and login user), you can send logs to an application.
`logs` is a list of log messages.

JSON-formatted log messages require a `timestamp` (we support timestamp formats supported by [dateutil parser](https://dateutil.readthedocs.io/en/stable/parser.html)), a field `message` (string), and `level`, which is the log level.

We recommend sending logs in larger batches to minimize network calls. The user can send as many log batches as he wants. They will be automatically processed though our analysis pipeline and the deep learning methods.

To send logs, execute the following request.

[Request](https://logsight.ai/swagger-ui/index.html#/Logs/sendLogListUsingPOST)
```
POST /api/v1/logs
```


JSON
```json
{
  "applicationId": "a26ab2f2-89e9-4e3a-bc9e-66011537f32f", //nullable
  "applicationName": "myapp", //nullable
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
One of `applicationId` or `applicationName` must be provided


[Response](https://logsight.ai/swagger-ui/index.html#/Logs/sendLogListUsingPOST)
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

+ `logsCount` is the count of the log messages sent in the batch.
+ `receiptId` is identifier of the received log batch.
+ `source` tells the way that this batch was sent (via REST API)

### Tag

The `Stage Verifier` uses tags to compare logs. 
`Tags` are any (key, value) paris of strings that can identify a particular set of log records. 
For example,

+ [Semantic versioning](https://semver.org/) (e.g., v1.0.0, v1.0.1)
+ Test run number (e.g., run_1, run_2)

[Request](https://logsight.ai/swagger-ui/index.html#/Logs/sendLogListUsingPOST)
```
POST /api/v1/logs
```
```json
{
  "applicationId": "a26ab2f2-89e9-4e3a-bc9e-66011537f32f", //nullable
  "applicationName": "myapp", //nullable
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

[Response](https://logsight.ai/swagger-ui/index.html#/Logs/sendLogListUsingPOST)
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

## Verify

After sending the logs, the client can compare logs indexed with different tags by making the following call.

[Request](https://logsight.ai/swagger-ui/index.html#/Compare/getCompareResultsUsingPOST)
```
POST /api/v1/logs/compare
```
```json
{
  "baselineTags": {"version": "v1.0.0", "namespace": "my_namespace"},
  "candidateTags": {"version": "v1.1.0", "namespace": "my_namespace"},
}
```

[Response](https://logsight.ai/swagger-ui/index.html#/Compare/getCompareResultsUsingPOST)
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


### Detailed report view
![Logs](./insights_verification.png ':size=1200')











 