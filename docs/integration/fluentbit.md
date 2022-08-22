# FluentBit

[FluentBit](https://docs.fluentbit.io/manual/) can be **natively** integrated with logsight.ai. 
No proprietary output plugins are needed. 
The standard [HTTP](https://docs.fluentbit.io/manual/pipeline/outputs/http) output is used to send log data to logsight.ai. 
This allows to use all FluentBit [inputs](https://docs.fluentbit.io/manual/pipeline/inputs) to connect to a variety of systems. 

## Prerequisites

1. Create a logsight.ai account by either using the web service at [https://logsight.ai](https://logsight.ai) or a [local installation](/get_started/installation.md).
<!-- TODO: The app creation together with other general things needs to be explained in a "User Guide" section -->

## Install and configure FluentBit

You need to install Fluentbit on your system. There are different ways to do so. Refer to the official [documentation](https://docs.fluentbit.io/manual/installation/getting-started-with-fluent-bit) for more details.

### Configure the FluentBit filter

You need to configure filters to make the log format of FluentBit compatible with logsight.ai.

```ini
[INPUT]
    Name $inputName
    Path $fileLocation
    multiline.parser  docker, cri
    DB /tail_docker.db
    Refresh_Interval 1
[SERVICE]
    Flush 1
    Daemon Off
[FILTER]
    Name modify
    Match $matchPattern
    Rename $message message
    Add tags.version $version
    Add tags.repository $repository
[FILTER]
    Name nest
    Match $matchPattern
    Operation nest
    Wildcard tags.*
    Nested_under tags
    Remove_prefix tags.
[OUTPUT]
    Name http
    Match $matchPattern
    Host $host
    Port $port
    http_User $logsightUsername
    http_Passwd $logsightPassword
    tls On
    uri /api/v1/logs/singles
    Format json
    json_date_format iso8601
    json_date_key timestamp
    Retry_Limit False"

```

This modification filter (`Name modify`) is applied to all log messages (`Match *`).

If it is not already the case, the key of the log message needs to be renamed to `message`.

Furthermore, logsight.ai expects `tags`. 
An example of `tags` could be the name of your service or repository.
We recommend to set the `tags` in a way that allows to **distinguish different versions/locations/deployments** of the system from which the logs are collected. You can specify **any** amount of tags.

For the web service, the `Host` and `Port` parameters need to be set to `Host https://logsight.ai` and `Port 443`. For the default [local installation](/get_started/installation) they are set to `Host http://localhost` and `Port 4200` (or any other URL and Port that was configured during the installation).

The account credentials need to be used to set the parameters `http_User` and `http_Passwd`.

Logs received by logsight.ai are expected to contain an ISO8601 timestamp which can be set using the parameter `json_date_format iso8601`. Furthermore, the timestamp key needs to be named `timestamp` which is ensured by setting `json_date_key timestamp`.

Adding this configuration to FluentBit allows is to send log data to logsight.ai.
