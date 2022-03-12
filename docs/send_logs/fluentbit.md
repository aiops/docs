# Logstash

logsight.ai enables integration with Logstash.

## Prerequisites
1. [Install and configure `Logstash`](../send_logs/logstash.md)

## Configure Logstash HTTP input
```
input {
  http {
    port      => 12345
    add_field => { "[@metadata][input-http]" => "" }
  }
}
```

## Install and Configure FluentBit
[Install Fluentbit](https://docs.fluentbit.io/manual/installation/getting-started-with-fluent-bit) using the official documentation.

### Configure FluentBit

1. If using the docker version of FluentBit
```
docker run --network="host" -it fluent/fluent-bit:1.8 /fluent-bit/bin/fluent-bit -i cpu -o http://127.0.0.1:12345 -p format=json_lines -p json_date_format=iso8601
```
2. If you configure FluentBit via config file
```
[OUTPUT]
    # your logstash host
    Host 127.0.0.1 
    # your logstash port
    Port 12345
    Format json_lines
    json_date_format iso8601
```
