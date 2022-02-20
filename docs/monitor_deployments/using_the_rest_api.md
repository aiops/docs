# Verify stages using the REST API


## Steps

1. `Create and activate user`
2. `Login user`
3. `Create application`
4. `Send logs`
5. `Obtain results`

During the tutorial, the following placeholders can be found. Depending on the installation that you have (e.g., web service, or on-premise), you will be required to replace the placeholders with the corresponding value.

> ```$URL = https://logsight.ai``` for using the web service.
> 
> ```$URL = https://demo.logsight.ai``` for using the demo service.
> 
> ```$URL = http://localhost:8080``` for using on-premise service.
> 



### 1. Create and activate user
#### [Create user](https://demo.logsight.ai/swagger-ui/index.html#/Users/createUserUsingPOST)
To create logsight.ai user, send the following request.

Request:

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

Response:

```
Status 201 CREATED
```

```json
{
    "userId": "5441e771-1ea3-41c4-8f31-2e71828693de"
}
```
The response that is returned by the endpoint will be the `userId` of the created user. The `userId` has usages in subsequent requests (e.g., when creating application).

#### [Activate user](https://demo.logsight.ai/swagger-ui/index.html#/Users/activateUserUsingPOST) (not needed in on-premise installation)

After the user creation, the user receives an email with activation link. The activation link, for example:

`$URL/auth/activate?userId=5441e771-1ea3-41c4-8f31-2e71828693de&activationToken=60af8472-fed8-46f0-9e9b-4f986c2b24dc`

consists of `userId` and a `activationToken`. There are two options to activate the user:
1. Clicking on the link
2. Taking the `userId` and the `activationToken` and sending an activation request:


Request:

```
POST /api/v1/users/activate
```

```json
{
  "activationToken": "60af8472-fed8-46f0-9e9b-4f986c2b24dc",
  "userId": "5441e771-1ea3-41c4-8f31-2e71828693de"
}
```

Response:

```
Status 200 OK
```

After user activation, the user needs to authenticate by sending the following request

### 2. [Login user](https://demo.logsight.ai/swagger-ui/index.html#/Authentication/loginUsingPOST)

Request:

```
POST /api/v1/auth/login
```

```json
{
  "email": "user@company.com",
  "password": "userPassword"
}
```

Response:

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

All subsequent requests (e.g., creating application, sending logs, or obtaining results) require an authorization header with the received authorization
token. Example for creating application:

```
curl -X POST '$URL/api/v1/application'
     -H 'Content-Type: application/json'
     -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9...'
     -d '{"applicatonName": "myservice"}'
```

### 3. [Create application](https://demo.logsight.ai/swagger-ui/index.html#/Applications/createApplicationUsingPOST)

An application is an independent source of log data. An example of an application may be a payment
service, database, or authentication service (a single app). By writing Application name and creating the app in the
background, several services are enabled that are ready to provide insights and analysis for the shipped logs.

To create an application the user needs to send the following request (don't forget to add the token in the request header).

Request:

```
POST /api/v1/users/{userId}/applications
```
For example: POST /api/v1/users/5441e771-1ea3-41c4-8f31-2e71828693de/applications
```json
{
  "applicatonName": "myservice"
}
```

Response:

```
Status 201 OK
```

```json
{
  "applicationName": "myservice",
  "applicationId": "a26ab2f2-89e9-4e3a-bc9e-66011537f32f"
}
```

The response contains an `applicationId` which is an UUID data type. It is important for subsequent requests related to
that specific application.


### 4. [Send logs](https://demo.logsight.ai/swagger-ui/index.html#/Logs/sendLogListUsingPOST)
After setting up the prerequisites (i.e., creating user, activate user, login user, and create application) the user can now send logs for its application.

The `Stage Verifier` supports the continuous verification of deployments, comparing tests, detecting test flakiness and other log verification tasks. In all of these tasks the underlying operation on abstract level is comparing sets of logs from different deployment versions, running and failing tests, etc.

To send logs the user needs to send the following request.

Request:
```
POST /api/v1/logs
```
```json
{
  "applicationId": "a26ab2f2-89e9-4e3a-bc9e-66011537f32f",
  "tag": "v1.0.1",
  "logs": [
        "Feb  1 18:20:29 kernel: [33160.926181] audit: type=1400 audit(1643736029.672:10417): apparmor="DENIED" operation="open" profile="snap.whatsapp-for-linux.whatsapp-for-linux" name="/proc/zoneinfo" pid=58597 comm="PressureMonitor" requested_mask="r" denied_mask="r" fsuid=1000 ouid=0",
        "Feb  1 18:20:30 kernel: [33161.927066] audit: type=1400 audit(1643736030.676:10418): apparmor="DENIED" operation="open" profile="snap.whatsapp-for-linux.whatsapp-for-linux" name="/proc/zoneinfo" pid=58597 comm="PressureMonitor" requested_mask="r" denied_mask="r" fsuid=1000 ouid=0"
          ]
}
```

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
We recommend sending logs in larger batches to minimize network calls. The user can send as many log batches as he wants. They will be automatically processed though our analysis pipeline and the deep learning methods.

`tag` is an identifier variable that represents the version of the logs, which later is utilized in the aforementioned tasks. For example, in deployment verification the `Stage Verifier` performs an operation of intelligent compare between the logs that belong to two different tags. A tag could be a version tag (v1.0.0, v1.0.1), a test run number (run_1, run_2), or any kind of string that later can be utilized to refer to a particular set of log data.

`logs` is a list of log messages. The messages can be in raw format or JSON. logsight.ai automatically parses the log fields.

Response:
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

`logsCount` is the count of the log messages sent in the batch.
`receiptId` is identifier of the received log batch.
`source` tells the way that this batch was sent (via REST API)

### 4. Obtain results

After sending logs, the user can obtain results from the `Stage Verifier` by performing the following steps:
1. (Optional) Executing control (`flush`) operation on the log stream - This performs a flush operation and guarantees the user the all of his previoysly sent logs are processed by our pipeline before getting results.
2. Obtain the results

#### 1. [Flush](https://demo.logsight.ai/swagger-ui/index.html#/Control/createResultInitUsingPOST) (optional)
To perform `flush` operation after sending the logs, the user needs to send a request containing the <i>LAST RECEIVED</i> `receiptId`.

Request:
```
POST /api/v1/logs/flush
```
```json
{
  "receiptId": "525c5234-9012-4f3b-8f64-c8a6ec418e7a"
}
```

Response:
```
Status 200 OK
```
```json
{
  "flushId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "status": "PENDING"
}
```

`flushId` is identifier of the flush command. This can be optionally used as part of the result request below, which guarantees that all of the logs sent before the flush are already processed and results can be obtained in full.
`status` "PENDING" means that the flush is being performed.

#### 2. [Obtain results](https://demo.logsight.ai/swagger-ui/index.html#/Compare/getCompareResultsUsingPOST)
To obtain the results form the `Stage Verifier` the user needs to perform the following query. 

Request:
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

If the user did not perform `flush` prior getting the results, the `flushId` field should be left out. This is an optional parameter. Without `flush` the user will still get results from the `Stage Verifier`.

Response:
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

`risk` - Risk score of the comparison. In case of deployments (new version comparing with old version), the risk translates to `deployment risk`.

`totalLogCount` - The total count of log messages from both `tags`.

`baselineLogCount` - The total count of log messages from the `baselineTag`.

`candidateLogCount` -  The total count of log messages from the `compareTag`.

`candidateChangePercentage` - The percentage change in total count of logs from the `candidateTag` compared to `baselineTag`.

`addedStatesTotalCount` - Total number of added states from the `candidateTag` compared to `baselineTag`.

`addedStatesFaultPercentage` - Percentage of added states, which are identified as faults.

`addedStatesReportPercentage` - Percentage of added states, which are identified as report (normal behaviour).

`deletedStatesTotalCount` - The total count of deleted states from the `candidateTag` compared to `baselineTag`.

`deletedStatesFaultPercentage` - Percentage of deleted states, which are identified as faults.
 
`deletedStatesReportPercentage` - Percentage of deleted states, which are identified as report.

`frequencyChangeTotalCount` - The total count of states that changed in occurrence frequency from the `candidateTag` compared to `baselineTag`.

`frequencyChangeFaultPercentage` - Percentage of states that changed in occurrence frequency, which are identified as faults.

`frequencyChangeReportPercentage` - Percentage of states that changed in occurrence frequency, which are identified as report.

`recurringStatesTotalCount` -  The total count of recurring states from the `candidateTag` compared to `baselineTag`.

`recurringStatesFaultPercentage` - Percentage of recurring states, which are identified as fault.

`recurringStatesReportPercentage` - Percentage of recurring states, which are identified as report.

`link` - Link that points to the UI where the user can see a detailed report.


#### Detailed report view
![Logs](./detailed_report.png ':size=1200')











 