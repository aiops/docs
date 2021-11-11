# Incident Dashboard

> The incident dashboard provides a bird's-eye view of the health of all your applications managed by `logsight.ai`


`Time frame` Use the time panel to select the time frame in which logging analytics should run. Alternatively, you can select one of the predefined ranges. 

`Log levels` A log level indicates how important a given log message is. The most common logging levels are DEBUG, INFO, WARN, ERROR and FATAL ([see pag. 11 of syslog specification](https://www.rfc-editor.org/rfc/rfc5424)).

`Cognitive anomalies` refer to log messages which are correlated with software failures.
In contrast to log level anomalies, cognitive anomalies are identified by inferring the semantics meaning of messages.

`Applications' incidents` The heat map shows for each registered application its health status. 
Red cells indicate the presence of incidents, while green cells represent healthy applications. 
The severity score can be seen by hovering over cells. 

<br>

![Logs](./dashboard.png ':size=1200')

<br>

`Top incidents` ranks the *k* incidents by the highest severity score.

`Incident details` shows the most important log messages which are part of an incident. 
The button *View details* provides further information about the incident.

`Flow anomalies` are changes observed in sequences of log messages.

`New log types` identifies one or more log type which were not observed during the normal operation of an application. They only occurred during the anomaly time frame.