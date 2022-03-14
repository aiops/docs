# Logstash

logsight.ai enables integration with Logstash.

## Prerequisites
1. [Install and configure `Logstash`](../send_logs/logstash.md)


## Install and Configure FluentBit
[Install Fluentbit](https://docs.fluentbit.io/manual/installation/getting-started-with-fluent-bit) using the official documentation.

### Configure FluentBit

Logstash HTTP output is needed to send the logs from FluentBit. 
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

In case you want to specify `applicationId` and `tag` in FluentBit you can do that by using FILTER.

```
[FILTER]
    Name modify
    Match *
    Add applicationId 70e975af-1761-4a1d-b135-0cbdfc2db080
    # your tag, e.g., ("container_image_id")
    Add "tag" "your_tag"
```

If you don't specify them in the FluentBit filter, you need to specify them in the Logstash config.