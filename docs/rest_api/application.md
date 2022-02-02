# Application API

logsight.ai allows you to perform application management via REST API.

An application in logsight.ai is an independent source of log data. An example of an application may be a payment
service, database, or authentication service (a single app). By writing Application name and creating the app in the
background, several services are enabled that are ready to provide insights and analysis for the shipped logs.

## Create application

#### Request:

```
POST /api/v1/application
```

```json
{
  "applicatonName": "myService"
}
```

#### Response:

```
Status 200 OK
```

```json
{
  "description": "Application created successfully!",
  "applicationName": "myService",
  "applicationId": "92gD81f90-daWzad-128x"
}
```

The response contains an "applicationId" which is an UUID data type. It is important for subsequent requests related to
that specific application.

## Delete application

#### Request:

```
DELETE /api/v1/application
```

```json
{
  "applicationId": "92gD81f90-daWzad-128x"
}
```

#### Response:

```
Status 200 OK
```

```json
{
  "description": "Application deleted successfully!",
  "applicationName": "myService",
  "applicationId": "92gD81f90-daWzad-128x"
}
```




