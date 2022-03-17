# Upload files

Logsight supports file upload to simplify ingest of batches of logs.

- To upload files into logsight, first the user needs to create and select an `application`.

![image](./upload_files.png)


Currently, we support two log file formats for file upload that are automatically parsed:

1. `Syslog` 
2. `JSON` files with the following structure where `timestamp`, and `message` fields are required.
```json 
{"timestamp": "TIMESTAMP", "message": "This is a sample message"}
```

After uploading of the file, the user will be redirected to the dashboard where the results will be displayed within few seconds.
