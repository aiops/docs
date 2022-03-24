# Detect incidents using the REST API


## Steps

Prerequisites ([Already performed these steps? Jump to Send Logs and Detect incidents](/detect_incidents/using_the_rest_api.md?id=send-logs))
1. `Create and activate user`
2. `Get token`
3. `Create application`

Detecting incidents
4. `Send logs`
5. `Flush (optional)`
6. `Detect incidents`

Depending on your deployment (i.e., web service, demo or on-premise), you need to replace the placeholder ```$URL``` 
with the correct value.

+ web service: ```$URL = https://logsight.ai``` 
+ on-premise service: ```$URL = http://localhost:8080```


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

## Create application

An application is an independent source of log data. An example of an application may be a payment
service, database, or authentication service (a single app). By writing Application name and creating the app in the
background, several services are enabled that are ready to provide insights and analysis for the shipped logs.

To create an application, send the following request (don't forget to add the token in the request header).
For example, POST /api/v1/users/5441e771-1ea3-41c4-8f31-2e71828693de/applications

[Request](https://logsight.ai/swagger-ui/index.html#/Applications/createApplicationUsingPOST)

```
POST /api/v1/users/{userId}/applications
```

```json
{
  "applicatonName": "myservice"
}
```

[Response](https://logsight.ai/swagger-ui/index.html#/Applications/createApplicationUsingPOST)

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
  "applicationId": "a26ab2f2-89e9-4e3a-bc9e-66011537f32f",
  "tag": "v1.0.1",
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


## Flush logs

### Flush

> (Optional) The flush operation guarantees that all the logs sent are processed by logsight.ai before getting the results.

To perform the `flush` operation after sending the logs, the client needs to send a request containing the last received `receiptId`.

[Request](https://logsight.ai/swagger-ui/index.html#/Control/createResultInitUsingPOST)
```
POST /api/v1/logs/flush
```
```json
{
  "receiptId": "525c5234-9012-4f3b-8f64-c8a6ec418e7a"
}
```

[Response](https://logsight.ai/swagger-ui/index.html#/Control/createResultInitUsingPOST)
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


## Detect Incidents

After sending the logs, the client can get insights from the logs in the form of summarized incidents. 

If the user did not perform `flush` prior to the getting results, the `flushId` field should be left out.

[Request](https://logsight.ai/swagger-ui/index.html#/Incidents/getIncidentResultUsingPOST)
```
POST /api/v1/logs/incidents
```
```json
{
  "applicationId": "a26ab2f2-89e9-4e3a-bc9e-66011537f32f",
  "flushId": "3fa85f64-5717-4562-b3fc-2c963f66afa6" // optional
  "startTime": "YYYY-MM-DDTHH:mm:ss.SSSSSS+HH:00",
  "stopTime": "YYYY-MM-DDTHH:mm:ss.SSSSSS+HH:00"
}
```

[Response](https://logsight.ai/swagger-ui/index.html#/Incidents/getIncidentResultUsingPOST)
```
Status 200 OK
```
```json
{
  "data": [
    {
      "applicationId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "semanticThreats": {},
      "startTimestamp": "string",
      "stopTimestamp": "string",
      "totalScore": 0
    }
  ]
}
```

+ `data` - List of incidents that are recorded in the specific interval.
+ `semanticThreats` -  List of log messages that were detected as threats by the semantic analysis. 
+ `startTimestamp` - Time when the incident started.
+ `stopTimestamp` - Time when the incident ended.
+ `totalScore` - Score that correlates with the severity of the incident.











 