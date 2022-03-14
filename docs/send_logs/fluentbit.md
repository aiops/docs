# FluentBit

logsight.ai enables integration with FluentBit.

## Prerequisites
1. [Create and activate logsight.ai account](https://docs.logsight.ai/#/detect_incidents/using_the_rest_api?id=create-and-activate-user)
2. [Create application](https://docs.logsight.ai/#/detect_incidents/using_the_rest_api?id=create-application)

Depending on your deployment (i.e., web service, demo or on-premise), you need to replace the placeholder ```$URL``` 
with the correct value.

+ web service: ```$URL = https://logsight.ai``` 
+ demo service: ```$URL = https://demo.logsight.ai``` 
+ on-premise service: ```$URL = http://localhost:8080```

## Install and Configure FluentBit
[Install Fluentbit](https://docs.fluentbit.io/manual/installation/getting-started-with-fluent-bit) using the official documentation.

### Configure FluentBit
At first, you need to add two fields vial FluentBit filter which are important to make it compatible with logsight.ai
```
[FILTER]
    Name modify
    Match *
    Rename YOUR_MESSAGE_FIELD message
    Add applicationId APPLICATION_ID # e.g., 70e975af-1761-4a1d-b135-0cbdfc2db080
    # your tag, e.g., ("container_image_id")
    Add "tag" "your_tag" # e.g., version of your deployment
```

Logstash HTTP output is needed to send the logs from FluentBit. 

> It is necessary that you MUST have message field (therefore, Rename YOUR_MESSAGE_FIELD message). Once can also Add message YOUR_MESSAGE_FIELD, however, this might be more tricky and it might require having a look at the [FluentBit Docs](https://docs.fluentbit.io/manual/).
>
> It is also necessary that you MUST have `json_date_key timestamp` in the [ OUTPUT ].
> 
```
[OUTPUT]
    Name http
    Host $URL
    Port 8080
    http_User LOGSIGHT_USERNAME
    http_Passwd LOGSIGHT_PASSWORD
    uri /api/v1/logs/singles
    Format json
    json_date_format iso8601
    json_date_key timestamp
```


Restart FluentBit with the new config, and the logs will start flowing to logsight.ai.