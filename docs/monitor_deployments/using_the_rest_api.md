# Verify stages using the REST API


## Steps

1. `Create and activate user`
2. `Get token`
3. `Create application`
4. `Send logs`
5. `Tag and flush`
6. `Verify`

Depending on your deployment (i.e., web service, demo or on-premise), you need to replace the placeholder ```$URL``` 
with the correct value.

+ web service: ```$URL = https://logsight.ai``` 
+ demo service: ```$URL = https://demo.logsight.ai``` 
+ on-premise service: ```$URL = http://localhost:8080```


## Create and activate user
### Create user

To create a user, send the following request.

[Request](https://demo.logsight.ai/swagger-ui/index.html#/Users/createUserUsingPOST)

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

[Response](https://demo.logsight.ai/swagger-ui/index.html#/Users/createUserUsingPOST)

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


[Request](https://demo.logsight.ai/swagger-ui/index.html#/Users/activateUserUsingPOST)

```
POST /api/v1/users/activate
```

```json
{
  "activationToken": "60af8472-fed8-46f0-9e9b-4f986c2b24dc",
  "userId": "5441e771-1ea3-41c4-8f31-2e71828693de"
}
```

[Response](https://demo.logsight.ai/swagger-ui/index.html#/Users/activateUserUsingPOST)

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

[Request](https://demo.logsight.ai/swagger-ui/index.html#/Authentication/loginUsingPOST)

```
POST /api/v1/auth/login
```

```json
{
  "email": "user@company.com",
  "password": "userPassword"
}
```

[Response](https://demo.logsight.ai/swagger-ui/index.html#/Authentication/loginUsingPOST)

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

## Create application

An application is an independent source of log data. An example of an application may be a payment
service, database, or authentication service (a single app). By writing Application name and creating the app in the
background, several services are enabled that are ready to provide insights and analysis for the shipped logs.

To create an application, send the following request (don't forget to add the token in the request header).
For example, POST /api/v1/users/5441e771-1ea3-41c4-8f31-2e71828693de/applications

[Request](https://demo.logsight.ai/swagger-ui/index.html#/Applications/createApplicationUsingPOST)

```
POST /api/v1/users/{userId}/applications
```

```json
{
  "applicatonName": "myservice"
}
```

[Response](https://demo.logsight.ai/swagger-ui/index.html#/Applications/createApplicationUsingPOST)

```
Status 201 OK
```

```json
{
  "applicationName": "myservice",
  "applicationId": "a26ab2f2-89e9-4e3a-bc9e-66011537f32f"
}
```

The response contains an `applicationId` to be used in subsequent requests.


## Send logs

After setting up the prerequisites (i.e., creating user, activate user, login user, and create application), you can send logs to an application.
`logs` is a list of log messages.

We support the following log formats: `syslog` and `JSON`. 

JSON-formatted log messages require a timestamp with field name that is one of ['@timestamp', 'timestamp', 'timestamp_iso8601', 'EventTime'].

We recommend sending logs in larger batches to minimize network calls. The user can send as many log batches as he wants. They will be automatically processed though our analysis pipeline and the deep learning methods.

To send logs, execute the following request.

[Request](https://demo.logsight.ai/swagger-ui/index.html#/Logs/sendLogListUsingPOST)
```
POST /api/v1/logs
```
```json
{
  "applicationId": "a26ab2f2-89e9-4e3a-bc9e-66011537f32f",
  "tag": "v1.0.1",
  //for syslog
  "logs": [
        "Feb  1 18:20:29 kernel: [33160.926181] audit: type=1400 audit(1643736029.672:10417): apparmor=DENIED operation=open profile=snap.whatsapp-for-linux.whatsapp-for-linux name=/proc/zoneinfo pid=58597 comm=PressureMonitor requested_mask=r denied_mask=r fsuid=1000 ouid=0",
        "Feb  1 18:20:30 kernel: [33161.927066] audit: type=1400 audit(1643736030.676:10418): apparmor=DENIED operation=open profile=snap.whatsapp-for-linux.whatsapp-for-linux name=/proc/zoneinfo pid=58597 comm=PressureMonitor requested_mask=r denied_mask=r fsuid=1000 ouid=0"
          ],
  //for json
  "logs": [
        "{\"@timestamp\":\"2021-03-23T01:02:51.007Z\",\"LoggerClassName\":\"org.slf4j.impl.Slf4jLogger\",\"LoggerName\":\"SCHEDULER\",\"Severity\":\"INFO\",\"message\":\"Started job execution\",\"Thread\":\"default - 2\",\"ThreadId\":315,\"mdc\":{},\"ndc\":\"\",\"SourceClassName\":\"com.admin.ad.co.frontend.common.si.SchedulableBase\",\"SourceMethodName\":\"perform\",\"SourceLineNumber\":80,\"exception\":null,\"StackTrace\":null,\"tag\":\"fail\"}",
        "{\"@timestamp\":\"2021-03-23T01:03:51.007Z\",\"LoggerClassName\":\"org.slf4j.impl.Slf4jLogger\",\"LoggerName\":\"SCHEDULER\",\"Severity\":\"INFO\",\"message\":\"Finished job execution: Process received messages via MessagingSubsystems for: OpenText; Duration: 0:00:00.006\",\"Thread\":\"default - 2\",\"ThreadId\":315,\"mdc\":{},\"ndc\":\"\",\"SourceClassName\":\"com.admin.ad.co.frontend.common.si.SchedulableBase\",\"SourceMethodName\":\"perform\",\"SourceLineNumber\":80,\"exception\":null,\"StackTrace\":null,\"tag\":\"fail\"}",
          ]
}
```

[Response](https://demo.logsight.ai/swagger-ui/index.html#/Logs/sendLogListUsingPOST)
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


## Tag and flush

### Tag

The `Stage Verifier` uses tags to compare logs. 
A `tag` is any string that can identify a particular set of log records. 
For example,

+ [Semantic versioning](https://semver.org/) (e.g., v1.0.0, v1.0.1)
+ Test run number (e.g., run_1, run_2)

[Request](https://demo.logsight.ai/swagger-ui/index.html#/Logs/sendLogListUsingPOST)
```
POST /api/v1/logs
```
```json
{
  "applicationId": "a26ab2f2-89e9-4e3a-bc9e-66011537f32f",
  "tag": "v1.0.2", // new version released
  "logs": [
        "Feb  2 18:21:22 kernel: [33160.926181] audit: type=1400 audit(1643736029.672:10417): apparmor="DENIED" operation="open" profile="snap.whatsapp-for-linux.whatsapp-for-linux" name="/proc/zoneinfo" pid=58597 comm="PressureMonitor" requested_mask="r" denied_mask="r" fsuid=1000 ouid=0",
        "Feb  2 18:21:10 kernel: [33161.927066] audit: type=1400 audit(1643736030.676:10418): apparmor="DENIED" operation="open" profile="snap.whatsapp-for-linux.whatsapp-for-linux" name="/proc/zoneinfo" pid=58597 comm="PressureMonitor" requested_mask="r" denied_mask="r" fsuid=1000 ouid=0"
          ]
}
```

[Response](https://demo.logsight.ai/swagger-ui/index.html#/Logs/sendLogListUsingPOST)
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

### Flush

> (Optional) The flush operation guarantees that all the logs sent are processed by logsight.ai before getting the results.

To perform the `flush` operation after sending the logs, the client needs to send a request containing the last received `receiptId`.

[Request](https://demo.logsight.ai/swagger-ui/index.html#/Control/createResultInitUsingPOST)
```
POST /api/v1/logs/flush
```
```json
{
  "receiptId": "525c5234-9012-4f3b-8f64-c8a6ec418e7a"
}
```

[Response](https://demo.logsight.ai/swagger-ui/index.html#/Control/createResultInitUsingPOST)
```
Status 200 OK
```
```json
{
  "flushId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "status": "PENDING"
}
```

+ `flushId` identifies a flush
+ `status` "PENDING" means that the flush is being performed. <span style="color:red">Which other states can be returned?</span> 


## Verify

After sending the logs, the client can compare logs indexed with different tags by making the following call. 

If the user did not perform `flush` prior to the verification, the `flushId` field should be left out.
Without `flush`, a verification will be made with the logs stored in logsight.ai.

[Request](https://demo.logsight.ai/swagger-ui/index.html#/Compare/getCompareResultsUsingPOST)
```
POST /api/v1/logs/compare
```
```json
{
  "applicationId": "a26ab2f2-89e9-4e3a-bc9e-66011537f32f",
  "baselineTag": "v1.0.1",
  "candidateTag": "v1.0.2",
  "flushId": "3fa85f64-5717-4562-b3fc-2c963f66afa6" // optional
}
```

[Response](https://demo.logsight.ai/swagger-ui/index.html#/Compare/getCompareResultsUsingPOST)
```
Status 200 OK
```
```json
{
  "applicationId": "a26ab2f2-89e9-4e3a-bc9e-66011537f32f",
  "flushId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
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
  "recurringStatesReportPercentage": 0,
  "link": "$URL/pages/compare?applicationId=a26ab2f2-89e9-4e3a-bc9e-66011537f32f&baselineTag=v1.0.1&compareTag=v1.0.2",
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
![Logs](./detailed_report.png ':size=1200')











 