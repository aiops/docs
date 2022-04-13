# Importing JSON log data into logsight.ai

Logs are essential for troubleshooting and increasingly become part of regulatory requirements. However, log data can offer far more than that. They provide critical insights into the behavior of your system during testing, staging, or deployment. Therefore, many organizations embrace the idea that logging leads to a growing prevalence of structured log management. A popular format to structure logs is JSON. This tutorial's focus will lie on JSON-structured logs. However, it can be applied to various other log formats such as Syslog or NCSA with few adjustments.

There might be situations where you want to analyze historical log data from your system. For example, given security threats like the [Log4Shell](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-45046) exploit, you want to know if your system was compromised in the past. Historic logs can also reveal frequently failing services that impact the performance of your system. Analyzing log data from several versions of your services allows tracking changes that help identify root causes of bugs.

This tutorial will describe how log files can be imported into logsight.ai. Aside from single file uploads, we will show possibilities to import log datasets consisting of multiple files potentially organized in specific directory structures.

## Filebeat and logsight.ai

We will use [Filebeat](https://www.elastic.co/beats/filebeat) with an logsight [plugin](https://github.com/aiops/logsight-filebeat) to import log files to logsight.ai. Filebeat is a lightweight service that can be configured to read logs from different [sources](https://www.elastic.co/guide/en/beats/filebeat/current/configuration-filebeat-options.html), [process](https://www.elastic.co/guide/en/beats/filebeat/current/defining-processors.html) them, and send them to a configured [output destination](https://www.elastic.co/guide/en/beats/filebeat/current/configuring-output.html). We provide an output [plugin](https://github.com/aiops/logsight-filebeat), allowing us to configure logsight.ai as the Filebeat's output destination. We will use the logsight Filebeat [container](https://hub.docker.com/repository/docker/logsight/filebeat). However, you can compile a custom Filebeat binary or build a custom container that contains the logsight output plugin yourselfe. More information can be found [here](https://github.com/aiops/logsight-filebeat).

Logsight.ai is a log analytics platform that supports system troubleshooting by detecting incidents, enables the continuous verification of deployments, analyses test executions to detect flakiness, and performs other log verification tasks. Therefore, it provides an API to manage log data sources and receive log messages. The logsight.ai [output](https://www.elastic.co/guide/en/beats/filebeat/current/configuring-output.html) plugin for Filebeat handles the API access and transmits logs in a structured JSON format.

Subsequently, a step-by-step tutorial shows how to configure Filebeat to import log files to logsight.ai. Thereby, we first show the import of a single file. After that, we describe how a dataset consisting of several log files can be imported.

### Logsight.ai

A logsight.ai endpoint is required to receive logs from Filebeat. One option is to use the web service available at [https://logsight.ai](https://logsight.ai) or install a local instance of logsight.ai. The installation process is described [here](/get_started/installation.md).


### Filebeat Configuration

Filebeat expects a configuration file that contains the definition of an input (log data source), all processing steps, and the output (log data destination). Create a text file and name it `filebeat.yml`. This file will contain the Filebeat configurations to import JSON log files.

## Reading a Single JSON Log File

First, we will show how to configure Filebeat to import a single log file into logsight.ai.

### Log Data Input

Filebeat expects a configuration block that specifies the log data source. Throughout this tutorial, we will use Filebeat's [log file input](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-input-log.html). Add the following to your `filebeat.yml` file.

```yml
filebeat.inputs:
- type: log
  paths:
    - /data/logs/go_app.json
  json.add_error_key: true
  json.keys_under_root: true
  json.overwrite_keys: true
  close_eof: true
```

The `filebeat.inputs` block contains a list of log data sources. We will use the `log` source type. This type can be configured by various parameters. Take a look at the [docs](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-input-log.html) for a complete list. We will focus on the parametrization for reading a historic JSON log file.
`paths`: A list of files to read logs from. We configured the path to a single `go_app.json` file. A single line of that file could look like

```
{"Level":"info","EventTime":"2020-11-04T15:35:31.112Z","Origin":"instance/beat.go","Message":"Hello World","Version":"1.6.0"}
```

`json`: By setting the `json` parameters, we tell Filebeat that the log entries are stored as JSON objects which Filebeat will try to parse. Filebeat is already structuring logs in an internal JSON format. Thereby several fields with meta-information are appended. An excerpt of the internal JSON structure looks like
```json
{
  "@timestamp": "2021-12-04T19:30:32.391Z",
  "message": "{\"Level\":\"info\",\"EventTime\":,\"Origin\":\"instance/beat.go\",\"Message\":\"Hello World\",\"Version\":\"1.6.0\"}",
  ...
}

```
Several fields with meta-information are added to each log that Filebeat reads from the file. Here, we will focus on `@timestamp` and `message`. Filebeat will assign a `@timestamp` to every log that it reads from the file. This is simply the current time at which the entry was read. Furthermore, it will store the logs, i.e., the lines in the `go_app.json` file, under the `message` field. So now we have a nested JSON structure: The internal Filebeat JSON and the JSON structured log from the file. By setting the `json` configuration, we let Filebeat take care of the merging but will set some configurations to define the merging behavior.

`json.add_error_key`: Whenever Filebeat cannot parse a JSON string, it will add the fields `error.message` and `error.type: json` to its internal JSON format. Former contains further information about the reason why the parsing failed.

`json.keys_under_root`: When the parsing is successful, this parameter tells Filebeat to merge the parsed JSON directly with the internal JSON starting from the root level.

`json.overwrite_keys`: This parameter defines that values of existing fields in the internal Filebeat JSON should be overwritten by the parsed JSON fields.

Applying the parsing and merging on the above example results in the following internal JSON format
```json
{
  "@timestamp": "2021-12-04T19:30:32.391Z",
  "Level": "info",
  "EventTime": "2020-11-04T15:35:31.112Z",
  "Origin": "instance/beat.go",
  "Message": "Hello World",
  "Origin": "instance/beat.go",
  "Version":"1.6.0",
  "message": "{\"Level\":\"info\",\"EventTime\":,\"Origin\":\"instance/beat.go\",\"Message\":\"Hello World\",\"Version\":\"1.6.0\"}",
  ...
}
```
Note that we now have two timestamps: The default `@timestamp` and the parsed `EventTime`, and two message fields: `message` and `Message`. This can be resolved with Filebeat [processors](https://www.elastic.co/guide/en/beats/filebeat/current/defining-processors.html). To save some computation, we will configure the logsight output plugin to resolve these conflicts.

### Log data output to logsight.ai

Filebeat can be configured to read logs from several inputs but support only a single output. We will use the logsight.ai Filebeat output to send the logs to logsight.ai. Append the following `output` block to your `filebeat.yml` file.
```yml
output.logsight:
  url: "http://logsight-backend:8080"
  email: "email.address@domain.com"
  password: "complex_password"
  application.name: "go_app"
  message_key: "Message"
  level_key: "Level"
  timestamp_key: "EventTime
```
We configure Filebeat to use `output.logsight` as its output. Note that this will not work with the native Filebeat binaries. Instead, we provide a custom Filebeat output for logsight.ai, which is available at [https://github.com/aiops/logsight-filebeat](https://github.com/aiops/logsight-filebeat). Later in this tutorial, we will show how to run the docker Filebeat container containing the logsight.ai output.

The first three parameters (`url`, `email`, `password`) are required, while the others control the mapping between Filebeat's internal JSON format and the JSON format of the logs sent to logsight.ai. A documentation of all possible parameters can be found [here](/integration/using_filebeats.md).

`url`: This is the endpoint to which Filebeat will try to send the log data. Here, we assume a local installation of logsight.ai. If you want to send the data to the web service, set the value to `https://logsight.ai:443`. When sending logs to the web service, you need to add the line `tls.enabled: "true"` to the `output.logsight` configuration block.

`email` and `password`: These are the account credentials you use for the logsight.ai login. You need to create a user account to send logs to logsight.ai.

`application.name`: Logsight.ai organizes logs based on their source. A log source is referred to as `application` within logsight.ai. This configuration defines an application name. It will use an existing application with that name or create a new one if no such application has been created yet. The creation of non-existing applications can be controlled with the `application.auto_create` parameter, which is set to `true` by default.

`message_key`: This parameter defines the field that contains the log message content. The default value is `"message"`. However, the original log message was parsed and merged with the internal Filebeat JSON structure. Thereby, the field `"Message"` contains the actual log message content.

`level_key` and `timestamp_key`: Similar to the `message_key` parameter, it is possible to define the fields that contain the log level and timestamp with these two parameters.

> [!NOTE]
> Logsight.ai supports timestamps in ISO 8601 format. They must match the following regex expression: 
> ```re
> ^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(\.\d+)?(([+-]\d{2}:\d{2})|Z)?$
> ```
> You can use Filebeat's [timestamp processor](https://www.elastic.co/guide/en/beats/filebeat/current/processor-timestamp.html) to re-format the timestamp if the timestamp format of your logs does match this regex.

If you want to start importing your log file, you can skip to [Running the logsight.ai filebeat docker container](#running-the-logsight.ai-filebeat-docker-container). The following section will describe the import of a log dataset consisting of multiple files.



## Reading a JSON Log Dataset

### Log Data Input

### Log Data Output to logsight.ai


## Running the logsight.ai Filebeat Docker container


