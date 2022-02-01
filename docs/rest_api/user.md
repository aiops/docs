#User API
logsight.ai allows you to perform user login via REST API.
## User login

####Request:
```
POST /api/v1/auth/login
```
```json
{
  "email": "user@company.com",
  "password": "userPassword"
}
```

####Response:
```
Status 200 OK
```
```json
{
  "token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9…"
}
```

All subsequent requests (e.g., using Application API) require an authorization header with the received authorization token:
```
--header 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9…’

Example:

curl -X POST 'localhost:8080/api/v1/application'
     -H 'Content-Type: application/json'
     -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9...'
     -d '{"applicatonName": "myService"}'
```