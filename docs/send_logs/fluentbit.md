# Logstash

logsight.ai enables integration with Logstash.

## Prerequisites
1. [Install and configure `Logstash`](../send_logs/logstash.md)


## Install and Configure FluentBit
[Install Fluentbit](https://docs.fluentbit.io/manual/installation/getting-started-with-fluent-bit) using the official documentation.

### Configure FluentBit

1. FluentBit config file
```
[OUTPUT]
    Name http
    # your logstash host
    Host 127.0.0.1 
    # your logstash port
    Port 12345
    Format json_lines
    json_date_format iso8601
```
