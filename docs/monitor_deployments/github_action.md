# Verify stages using the REST API

Depending on your deployment (i.e., web service, demo or on-premise), you need to replace the placeholder ```$URL``` 
with the correct value.

+ web service: ```$URL = https://logsight.ai``` 
+ demo service: ```$URL = https://demo.logsight.ai``` 
+ on-premise service: ```$URL = http://localhost:8080```

## Prerequisites

1. `Create and activate logsight user at https://logsight.ai`

## Workflow configuration
logsight.ai enables seamless integration with `Github Actions`.

To enable the logsight Stage Verifier quality gate check into your workflow add the following steps:

```text
    steps:
      - name: Logsight Init
        id: init
        uses: aiops/logsight-init-action@master
        with:
          logsight-url: $URL
          username: ${ {  secrets.LOGSIGHT_USERNAME } }
          password: ${ { secrets.LOGSIGHT_PASSWORD } }
          application-name: ${ { github.ref } } 

      - name: Install FluentBit for Log Collection
        run: |
          curl "https://raw.githubusercontent.com/aiops/log-verification-action/main/fluentbit_config_generator.sh" --output fluent_bit_config_generator.sh
          bash fluent_bit_config_generator.sh ${ { secrets.LOGSIGHT_USERNAME } } ${ { secrets.LOGSIGHT_PASSWORD } } FLUENTBIT_INPUT ${ { steps.init.outputs.application-id} } ${ { github.sha } } MESSAGE_FIELD $URL 12345 > fluent-bit.conf
          cat fluent-bit.conf
          curl "https://raw.githubusercontent.com/aiops/log-verification-action/main/docker-compose.yml" --output docker-compose.yml
          docker-compose up -d
          
      - name: 🚀 Conduct Tests from your application

      - name: Verify logs
        uses: aiops/log-verification-action@main
        id: verify-logs
        with:
          logsight-url: $URL
          username: ${ { secrets.LOGSIGHT_USERNAME } }
          password: ${ { secrets.LOGSIGHT_PASSWORD } }
          application-id: ${ { steps.init.outputs.application-id } }
          baseline-tag: ${ { github.event.before } }
          compare-tag: ${ { github.sha } }
          risk-threshold: '50'
```

#### Guide
> Important is that Logsight Init and Install FluentBit are executed as steps prior your application generates logs (e.g., prior testing). 
> 
> The Stage Verifier is called afterwards.


2. `application-name` is a string that usually refers to the name of the service. Currently with ${ { github.ref } } is set to the branch name. However, youm can change it to any desired string.
3. `FLUENTBIT_INPUT` is set according to the official FluentBit documentation (https://docs.fluentbit.io/manual/pipeline/inputs).
4. `MESSAGE_FIELD` is the field that contains the human-readable log message.
5. The config script located at https://raw.githubusercontent.com/aiops/log-verification-action/main/fluentbit_config_generator.sh is just a util script for FluentBit config. 
6. If you already have predefined config for FluentBit you can add the following config where $variables are replaced with concrete values. [Read more](../send_logs/fluentbit.md)
```
[FILTER]
    Name modify
    Match *
    Add applicationId $applicationId
    Add tag $tag
    Rename $message message
    Add basicAuthToken $basicAuthToken
[OUTPUT]
    Name http
    Host $host
    Port $port
    Format json_lines
    json_date_format iso8601"
```
6. `baseline-tag` refers to the version of your repository that is alredy working (e.g., in production).
7. `compare-tag` refers to the current release. 
8. Both `tags` are strings, and you can use any to tag. Often we relate tags to the commit id (${ { github.sha } }) 

