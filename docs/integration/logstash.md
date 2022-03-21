# Logstash

logsight.ai enables integration with [Logstash](https://www.elastic.co/de/logstash/).

## Prerequisites
1. [Install `Logstash`](https://www.elastic.co/guide/en/logstash/current/installing-logstash.html)

Depending on your deployment (i.e., web service, or on-premise), you need to replace the placeholder ```$URL``` 
with the correct value.

+ web service: ```$URL = https://logsight.ai```  
+ on-premise service: ```$URL = http://localhost:8080```

## Start sending logs

First we need to use a ruby code segment to share the event structure flowing through the logstash.
If you need to have a dynamic `application` and `tag`, this is the place to make sure they are set.
In this example we assume the json structure of the message has the `application` and `tag` fields. Those fields can be generated by the logstash filters as well.
If you need them to be remain static you may to replace the `event.get` with a plain string.

### Filter configuration

```
filter {
    # special case if input is http
	if [@metadata][input-http] {
        date {
          match => [ "date", "UNIX" ]
          remove_field => [ "date" ]
        }
        mutate {
          remove_field => ["headers","host"]
        }
    }
   # structuring the output event
   ruby {  
        code => '
                # create an application in logsight http://localhost:4200/pages/profile or via the API and use the ID here
		event.set("applicationId", event.get('applicationId'))
		# tag can be set dynamically, e.g., container_image_id
		event.set("tag", event.get('tag')) 
                # this needs to contain the message of the log 
		event.set("message", event.get('[log][msg]'))
		' 
        }
   # cleaning the message
   mutate {
        gsub => [
        "message", "\"", "", "message", "[\\?#-+]", ""
   	    ]
        }
}
```

Once the Event is ready we need to configure the output itself to send the logs.

### Output configuration

```
output {
   http {
        url => "$URL/api/v1/logs"
        content_type => "application/json"
        http_method => "post"
        format => message
        message => '{"applicationId":"%{applicationId}", "logs":[{"timestamp":"%{@timestamp}", "message":"%{message}"}], "tag":"%{tag}"}'
        headers => {
            "Authorization" => "Basic HEADER_TOKEN"
                    }
        }
}
```
To generate the Basic authorization `HEADER_TOKEN` you can use https://www.debugbear.com/basic-auth-header-generator, Postman, or in Linux base systems (`echo -n user:password | base64`) .