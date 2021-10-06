## Upload file


![image](https://user-images.githubusercontent.com/22328259/136199581-ddae8a6d-310f-4f24-aa5e-6e3ec6f3dd86.png)

Logsight supports file upload to simplify ingest of batches of logs.

To upload files into logsight, first the user needs to create an application in Integration.

In the process of uploading a log file, the user needs to select the application inside logsight and choose the type of file to upload.

Currently, we support three log file formats for file upload:

1. Syslog 
2. Native JSON files with the following structure
```json 
{
    "logMessages": [
      {
        "private-key": "mvotr2fqri48dp1o7i0rdjliau",
        "app": "string",
        "timestamp": "string",
        "level": "string",
        "message": "string"
      }
    ]
    }
```
3. Logstash based files. We support all files that are output from logstash.
