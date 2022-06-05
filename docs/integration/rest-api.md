# REST API

## Steps

Prerequisites ([Already performed these steps? Jump to Send Logs and Verify](/monitor_deployments/using_the_rest_api.md?id=send-logs))
1. `Create and activate user`
3. `Create application`

Depending on your deployment (i.e., web service, or on-premise), you need to replace the placeholder ```$URL``` 
with the correct value.

+ web service: ```$URL = https://logsight.ai```
+ on-premise service: ```$URL = http://localhost:8080```

After setting up the prerequisites (i.e., creating `user`, activate `user`, login `user`, and create `application`), you can send logs to an application.
`logs` is a list of log messages.

JSON-formatted log messages require a `timestamp` (we support timestamp formats supported by [dateutil parser](https://dateutil.readthedocs.io/en/stable/parser.html)), and field `message` (string).

We recommend sending logs in larger batches to minimize network calls. The user can send as many log batches as he wants. They will be automatically processed though our analysis pipeline and the deep learning methods.

To send logs, execute the following request.

[Request](https://logsight.ai/swagger-ui/index.html#/Logs/sendLogListUsingPOST) (For more information click on the Request)
```
POST /api/v1/logs
```

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

