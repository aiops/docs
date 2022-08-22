# Filebeat

Logs are essential for troubleshooting and increasingly become part of regulatory requirements.
But log data can offer far more than that.
They provide critical insights into the behavior of your system during testing, staging, or deployment. 
Therefore, many organizations embrace the idea of logging, resulting in a growing prevalence of structured log management. A popular format to structure logs is `JSON`. This tutorial's focus will lie on JSON-structured logs. 
However, it can be applied to other log formats such as Syslog or NCSA with few adjustments.
Logsight is a log analytics platform that supports system troubleshooting by detecting incidents, enables the continuous verification of deployments, analyses test executions, and performs other log verification tasks. However, there might be situations where you want to analyze historical log data. For example, given security threats like the [Log4Shell](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-45046) exploit, you want to know if your system was compromised in the past.
Historic logs can also reveal frequently failing services that impact the performance of your system.
Analyzing log data from several versions of your services allows tracking changes that help identify root causes of bugs.
Finding such problems can help organizations set the right focus while improving the system's fault tolerance.

In this tutorial, we show how JSON log files can be imported into logsight. One option is to use the web service available at [https://logsight.ai](https://logsight.ai). Another option is to install a local instance of logsight. The installation process is described [here](/get_started/installation.md). In this tutorial, we primarly focus on the webservice. However, there are comments guiding the configuration adjustment to enable sending log data to an on-premise installation of logsight.

First, we show how single files can be imported to logsight. After that, we describe how an import of a log dataset consisting of multiple files potentially organized in specific directory structures can be done.


## Filebeat

We will use [Filebeat](https://www.elastic.co/beats/filebeat) with an logsight [plugin](https://github.com/aiops/logsight-filebeat) to import log files to logsight. Filebeat is a lightweight service that can be configured to read logs from different [sources](https://www.elastic.co/guide/en/beats/filebeat/current/configuration-filebeat-options.html), [process](https://www.elastic.co/guide/en/beats/filebeat/current/defining-processors.html) them, and send them to a configured [output destination](https://www.elastic.co/guide/en/beats/filebeat/current/configuring-output.html). 


The logsight [output plugin](https://github.com/aiops/logsight-filebeat) is used to configure logsight as the Filebeat's output destination. It handles the API access and transmits logs in a structured format. We provide a compiled Filebeat binary which includes the logsight output and ship it as a Docker [container](https://hub.docker.com/repository/docker/logsight/filebeat). However, you can compile your own Filebeat binary or build a custom container based on a specific Filebeat version. More information can be found [here](https://github.com/aiops/logsight-filebeat).

### Filebeat configuration

Filebeat expects a configuration file that contains the definition of an input (log data source), all processing steps, and the output (log data destination). Create a text file and name it `filebeat.yml`. This file will contain the Filebeat configurations to import JSON log files to logsight.

## Importing a single JSON log file

First, we will show a configuration that lets Filebeat import a single log file to logsight.

### Configuring Filebeat's data input

Filebeat expects a configuration block that specifies the log data source. Throughout this tutorial, we will use Filebeat's [log file input](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-input-log.html). Add the following configuration lines to your `filebeat.yml` file.

```yml
filebeat.inputs:
- type: log
  paths:
    - /data/go_app.json
  json.add_error_key: true
  json.keys_under_root: true
  json.overwrite_keys: true
```

The `filebeat.inputs` block contains a list of log data sources. We will use the `log` source type. Take a look at the [docs](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-input-log.html) for a complete list of configuration parameters. Here, we will focus on a specific parametrization that allows reading a single JSON log file.

`paths`: A list of files to read logs from. We configure the path to a single `go_app.json` file. A single line of that file could look like this.

```
{"Level":"info","EventTime":"2020-11-04T15:35:31.112Z","Origin":"instance/beat.go","EventMessage":"Hello World","Version":"1.6.0"}
```

Filebeat is using a JSON structure for each log message. After reading the above line, an excerpt of the Filebeat's JSON structure looks like this.

```json
{
  "@timestamp": "2021-12-04T19:30:32.391Z",
  "message": "{\"Level\":\"info\",\"EventTime\":,\"Origin\":\"instance/beat.go\",\"EventMessage\":\"Hello World\",\"Version\":\"1.6.0\"}",
  ...
}

```

Several fields with meta-information are added to each log line. We will focus on `@timestamp` and `message` fields here. Filebeat will assign a `@timestamp` to every log that it reads from the file. This is the current time at which the entry was read. Furthermore, it will put the logs, i.e., the lines in the `go_app.json` file, under the `message` field. Now, we have a nested JSON structure: Filebeat's JSON and the JSON structured log from the file. By setting the `json` configuration, we let Filebeat take care of the merging of both JSONs but will set some configurations to define the merging behavior.

`json.add_error_key`: Whenever Filebeat cannot parse a JSON message string, it will add the fields `error.message` and `error.type: json`. Former contains further information about the reason why the parsing failed.

`json.keys_under_root`: When the parsing is successful, this parameter tells Filebeat to merge the parsed JSON directly into it's own JSON starting from the root level.

`json.overwrite_keys`: This parameter defines that values of Filebeat's existing JSON fields should be overwritten by the parsed JSON field values.

Applying the parsing and merging on the above example results in the following Filebeat JSON structure.

```json
{
  "@timestamp": "2021-12-04T19:30:32.391Z",
  "Level": "info",
  "EventTime": "2020-11-04T15:35:31.112Z",
  "Origin": "instance/beat.go",
  "EventMessage": "Hello World",
  "Origin": "instance/beat.go",
  "Version":"1.6.0",
  "message": "{\"Level\":\"info\",\"EventTime\":,\"Origin\":\"instance/beat.go\",\"Message\":\"Hello World\",\"Version\":\"1.6.0\"}",
  ...
}
```

Note that we now have two timestamps: The default `@timestamp` and the parsed `EventTime`, and two message fields: `message` and `EventMessage`. This can be resolved with Filebeat [processors](https://www.elastic.co/guide/en/beats/filebeat/current/defining-processors.html). However, to save some computation, we will configure the logsight output plugin to resolve these conflicts.

### Configuring Filebeat's data output

Filebeat can be configured to read logs from several inputs but supports only a single output. We will use the logsight output plugin to send the logs to logsight. Append the following `output` block to your `filebeat.yml` file.

```yml
output.logsight:
  url: "https://logsight.ai:443"
  tls.enabled: "true"
  email: "email.address@domain.com"
  password: "complex_password"
  application.name: "go_app"
  message_key: "EventMessage"
  level_key: "Level"
  timestamp_key: "EventTime"
```

We configure Filebeat to use `output.logsight` as its output. Note that this will not work with the native Filebeat binaries. Instead, we provide a custom Filebeat output plugin for logsight, available at [https://github.com/aiops/logsight-filebeat](https://github.com/aiops/logsight-filebeat). Later in this tutorial, we will show how to run a Docker container containing the logsight output plugin.

The first three parameters (`url`, `email`, `password`) are required. The other configurations control the mapping between Filebeat's JSON format and the structure of the logs sent to logsight. The `output.logsight` documentation providing all possible parameters can be found [here](/integration/using_filebeats.md).

`url`: This is the endpoint to which Filebeat will try to send the log data. Here, we assume to use the web service. If you want to send the data to you on-premise installation of logisght, set the value to `http://logsight-backend:8080`.

`email` and `password` are the account credentials you use to login to logsight. You need to create a user account to send logs to logsight.

`application.name`: Logsight organizes logs based on their source. A log source is referred to as `application` within logsight. This configuration defines an application name. Either an existing application with that name will be used, or a new one will be created if no such application has been created yet. The creation of non-existing applications can be controlled with the `application.auto_create` parameter, which is set to `true` by default.

`message_key`: This parameter defines the log content field. The default value is `"message"`. However, the original log message was parsed and merged with Filebeat's JSON structure. Therefore, the field `"EventMessage"` contains the actual log message that we want to send to logsight.

`level_key` and `timestamp_key`: Similar to the `message_key` parameter, it is possible to define the fields that contain the log level and timestamp with these two parameters.

> [!NOTE]
> Logsight supports timestamps in ISO 8601 format. They must match the following regex expression
> ```regex
> ^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(\.\d+)?(([+-]\d{2}:\d{2})|Z)?$
> ```
> You can use Filebeat's [timestamp processor](https://www.elastic.co/guide/en/beats/filebeat/current/processor-timestamp.html) to re-format the timestamp if the timestamp format of your logs does match this regex.

If you want to start importing your single log file, you can skip to [Running the logsight filebeat docker container](#running-the-logsightai-filebeat-docker-container). The following section will describe the import of a log dataset consisting of multiple files.


## Importing a JSON log dataset

Working with various customers, we often observe historic log datasets stored in separate files and organized in specific directory structures. The following directory structure is a typical example.

```
- log_dataset/
  - java_app/
    - log1.json
    - log2.json
  - go_app/
    - log1.json
    - log2.json
    - log3.json
  - python_app/
    - log.json
```

The `log_data` directory is the root containing multiple directories that represent different log sources. These could be different devices, server nodes, Docker containers, or services. In the above example, we see three services named `java_app`, `go_app`, and `python_app`. Each of these service directories contains a set of JSON log files. 

The objective of this part of the tutorial is to configure Filebeat so that it imports all log files to logsight. The logs from each service should be assigned to a respective logsight application.


### Configuring Filebeat's data input

Add the following configuration lines to your `filebeat.yml` file. If your `filebeat.yml` file contains the input block to read a single JSON log file, you need to replace it.

```yml
filebeat.inputs:
- type: log
  paths:
    - /data/log_dataset/*/*.json
  json.add_error_key: true
  json.keys_under_root: true
  json.overwrite_keys: true
  harvester_limit: 2
  close_eof: true
```

`paths`: The path configuration supports wild cards to read all files that match the wild-card pattern. In this example, all files with a `.json` extension located in every sub-directory of `/data/log_dataset/` will be read. Using Filebeat's terminology, the files that match the wild-card are _harvested_.

The `json` parameters remain as described in [Importing a single JSON log file](#importing-a-single-json-log-file).

`harvester_limit`: The harvester limit controls the number of files Filebeat will harvest in parallel. Importing large datasets consisting of many files will result in a high system load during the import. Furthermore, Filebeat will have to deal with backpressure if the destination cannot keep up with the log data transmission. Therefore, it is reasonable to limit the parallelism of Filebeat's file harvesting to prevent overload situations.

`close_eof`: This parameter tells Filebeat to close the file harvester whenever an EOF is reached. This is usually not desired if Filebeat should check log files for new entries when, e.g., a running system is monitored. However, this parameter allows the sequential reading of files while maintaining the defined parallelism based on the `harvester_limit` to import a historic log dataset. Whenever Filebeat finishes reading a file, another harvester on the next file is started.

### Configuring Filebeat's data output

Append the following `output` block to your `filebeat.yml` file. If your `filebeat.yml` file contains the output block to read a single JSON log file, you need to replace it.

```yml
output.logsight:
  url: "http://logsight-backend:8080"
  email: "email.address@domain.com"
  password: "complex_password"
  application.name_key: "log.file.path"
  application.name_regex_matcher: '^\/data\/log_dataset\/(.*)\/.*$'
  message_key: "EventMessage"
  level_key: "Level"
  timestamp_key: "EventTime"
```

We assume the same JSON structure as previously described in [Importing a single JSON log file](#importing-a-single-json-log-file).

```json
{
  "@timestamp": "2021-12-04T19:30:32.391Z",
  "Level": "info",
  "EventTime": "2020-11-04T15:35:31.112Z",
  "Origin": "instance/beat.go",
  "Message": "Hello World",
  "Origin": "instance/beat.go",
  "Version":"1.6.0",
  "message": "{\"Level\":\"info\",\"EventTime\":,\"Origin\":\"instance/beat.go\",\"EventMessage\":\"Hello World\",\"Version\":\"1.6.0\"}",
  ...
  "log": {
    "file": {
      "path": "/data/log_dataset/go_app/log1.json"
    },
    "offset": 1174848
  },
  ...
}
```

The mapping of the log content (message), level, and severity are again done by configuring the `message_key`, `level_key`, and `timestamp_key` parameters.

When we read a single log file, we defined a fixed logsight application name `go_app`, telling logsight to associate all logs from that file with an application called `go_app`. However, we are reading six log files that originate from three different services this time. Therefore, we would like to tell logsight to create the three apps `java_app`, `go_app`, and `python_app` and maintain the correct association between logs and applications.

The logsight output can be configured to take care of this. The service name is encoded as a directory and, therefore, part of the file path. Note that the Filebeat's `log` input module adds a meta-information block under the `log` key containing the origin of the log and its offset within the file.

The task is now to point the output plugin to this field. This can be done by setting the `application.name_key` parameter. To access the nested `path` key within the `log` block, it is possible to use the dot-notation `log.file.path`. The Filebeat output will tell logsight to use the whole `/data/log_dataset/go_app/log1.json` string as the application name. Although this would work, it is not exactly what we want. A better solution would be to use only the service directory name (e.g., `go_app`) as the application name.

Therefore, the output configuration provides a parameter to define a regex expression that selects a substring from the `/data/log_dataset/go_app/log1.json` string. Thereby the regex group capturing is used. We want to extract the sub-directories below `log_dataset` in our example. This is achieved with the regex expression `'^\/data\/log_dataset\/(.*)\/.*$'`. The group capturing `(.*)` matches the service name sub-directories and the logsight output plugin uses them as the application name.

Note that using regex expressions can be error-prone and a source of unexpected behavior. To ensure that a regex expression matches the desired substring, it should be verified with example values via, e.g., an [online regex checker](https://regex101.com/).

## Running the Filebeat Docker container

We will use the logsight Filebeat Docker [container](https://hub.docker.com/repository/docker/logsight/filebeat). Start it with

```bash
docker run -d --name="filebeat" \
  -v "/home/<user>/filebeat.yml":"/filebeat.yml" \
  -v "/home/<user>/data":"/data" \
  logsight/filebeat:latest
```

The `-d` parameter configures the container to run in detached mode, and `--name="filebeat"` sets the name of the running container. 

We need to mount our previously created `filebeat.yml` configuration file and the data we want to import into the Filebeat container. The `filebeat.yml` file needs to be mounted to the container's root directory: `-v "/home/<user>/filebeat.yml":"/filebeat.yml"`. The `filebeat.yml` is assumed to be located in your local `/home/<user>/` directory. Adjust this to match the actual location of your `filebeat.yml` configuration file.

The data can be mounted to an arbitrary location inside the container. We mount it into `/data` to be compliant with the above configuration examples: `-v "/home/<user>/data":"/data"`. Here, we assume that either the single JSON file `go_app.json` or the directory `log_dataset` containing the log dataset is located inside your local `"/home/<user>/data/"` directory. You need to adjust this to match the actual location of your log data files.


> [!NOTE]
> Here, we assume to send the log data to the logsight webservice.
> If you want to send them to your on-premise installation, you need to put the container into the same Docker network as all other logsight containers.
> Execute the following command.
> 
> ```bash
> docker run -d --name="filebeat" \
>   --net="docker-compose_logsight"
>   -v "/home/<user>/filebeat.yml":"/filebeat.yml" \
>   -v "/home/<user>/data":"/data" \
>   logsight/filebeat:latest
> ```
> 
> The `--net="docker-compose_logsight"` parameter puts the filebeat container into the `docker-compose_logsight` Docker network, which is set up when installing logsight via docker compose as described [here](/get_started/installation.md).

## Troubleshooting

To get debug logs from the logsight output plugin, you can add the following lines to your `filebeat.yml` configuration file
```yml
logging.level: debug
logging.selectors: logsight
```
To see the logs of the Filebeat container run
```bash
docker logs filebeat
```

When using the `application.name_key` configuration parameter, Filebeat will drop logs if the configured key value is not found in the Filebeat's JSON structure. If the regex expression of `application.name_regex_matcher` does not match or matches an empty string, Filebeat drops the logs. This behavior is logged by the logsight output plugin.

Setting the key parameters (e.g., `message_key`, `level_key`) or `application.name_key` and `application.name_regex_matcher` requires knowledge about the Filebeat's JSON log structure of Filebeat. Therefore, you can replace the `output.logsight` configuration block by 

```yml
output.console:
  pretty: true
```

Filebeat will print each log harvested by the input to stdout, which can be viewed by running.

```bash
docker logs filebeat
```
