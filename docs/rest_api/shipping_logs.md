# Logs API
logsight.ai exposes an API that allows you to send your logs from anywhere.

## Send logs

#### Request:
```
POST /api/v1/logs
```
```json
{
  "applicationId": "92gD81f90-daWzad-128x",
  "tag": "v1.0.1",
  "logFormat": "unknown", 
  "logs": [
        "Feb  1 18:20:29 kernel: [33160.926181] audit: type=1400 audit(1643736029.672:10417): apparmor="DENIED" operation="open" profile="snap.whatsapp-for-linux.whatsapp-for-linux" name="/proc/zoneinfo" pid=58597 comm="PressureMonitor" requested_mask="r" denied_mask="r" fsuid=1000 ouid=0",
        "Feb  1 18:20:30 kernel: [33161.927066] audit: type=1400 audit(1643736030.676:10418): apparmor="DENIED" operation="open" profile="snap.whatsapp-for-linux.whatsapp-for-linux" name="/proc/zoneinfo" pid=58597 comm="PressureMonitor" requested_mask="r" denied_mask="r" fsuid=1000 ouid=0"
        …
          ]
}
```
<i>We recommend sending logs in larger batches to minimize network calls.</i>

<strong>"tag"</strong> is a variable that represents the version of the logs, which later is utilized in subsequent tasks, e.g., in Verification. There, the verification is performing an operation of intelligent comparsion between the logs from that belong to two different tags. For example, a tag could be a version tag (v1.0.0, v1.0.1) or a test run number (run_1, run_2), or any kind of flag that later can be utlized to get log data that belongs to it.

<strong>"logFormat"</strong> The format of the logs can be <i>unknown</i>, then the logs are automatically parsed with logsight.ai, or <i>JSON</i> where the log data is already structured and has JSON format.

#### Response:
```
Status 200 OK
```
```json
{
  "description": "Log batch received successfully",
  "applicationId": "92gD81f90-daWzad-128x",
  "tag": "v1.0.1"
}
```







