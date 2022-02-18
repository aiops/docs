# Incidents

`Time frame` Use the time panel to select the time frame in which logging analytics should run. Alternatively, you can select one of the predefined ranges. 

`Top incidents` ranks the *k* incidents by the highest severity score.


<br>

![Logs](./incidents.png ':size=1200')

<br>

`Incident details` shows the most important log messages which are part of an incident. 
The button *View details* provides further information about the incident.

`Cognitive anomalies` refer to log messages which are correlated with software failures.
In contrast to log level anomalies, cognitive anomalies are identified by inferring the semantics meaning of messages.

`Log level anomalies` refer to log messages which are correlated with software failures identified by their log level.

`Flow anomalies (in development)` are changes observed in sequences of log messages. 

`New log types (in development)` identifies one or more log type which were not observed during the normal operation of an application. They only occurred during the anomaly time frame.