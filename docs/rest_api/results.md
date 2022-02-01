#Results API
logsight.ai allows you to get results via REST API.
## [Verification](https://docs.logsight.ai/#/monitor_deployments/stage_verifier)

### Initiate verification process

####Request:
```
POST /api/v1/verification/init
```
```json
{
  "applicationId": "92gD81f90-daWzad-128x",
  "aselineTag": "v1.0.0",
  "candidateTag": "v1.0.1"
}
```

####Response:
```
Status 200 OK
```
```json
{
  "verificationId": "2jKdf-2Sziwoz"
  "applicationId": "92gD81f90-daWzad-128x"
  "baselineTag": "v1.0.0",
  "candidateTag": "v1.0.1"
}
```

###Get verification results

####Request:
```
GET /api/v1/verification/{verificationId}
Example: GET /api/v1/verification/2jKdf-2Sziwoz
```

####Response:
```
Status 200 OK
```
```json
{
  "verificationId": "2jKdf-2Sziwoz",
  "applicationId": "",
  "baselineTag": "v1.0.0",
  "compareTag": "v1.0.1",
  "results": {
	"deploymentRisk": "90",
	…
}
```




