
# Glossary

[//]: # (### Anomaly types)

To complete ... and define.

#### _Incident Detector group_
An incident group is a group of cognitive anomalies, flow anomalies and critical anomalies.

#### _Flow anomaly_
A flow anomaly is a sequence of log messages which exhibit a different ratio among its log types.

#### _Cognitive anomaly_
A cognitive anomaly is a log message for which the textual description has a semantic meaning associated with a failure.
For example, *unable to acquire token*.

#### _Critical anomaly_
A critical anomaly is a cognitive anomaly associated with a new log type or with a flow anomaly.

[//]: # (#### Anomaly score)

[//]: # (To complete ...)

#### _Severity score_
A severity score quantifies the severity of an incident. The higher the value, the higher the severity of an incident.

#### _Ratio anomaly_
A ratio anomaly is a structure that correlates logs that "go together". 
For example, Opening connection and Closing connection.

#### _Log type_
A log type (or log template) is a structured description of an unstructured log message. 
It typically includes variables (e.g., IP address, service name) and a textual description.
Groups of log messages are clustered into a log template representing a state of a system.

[//]: # (#### Baseline version)

[//]: # (To complete ...)

[//]: # ()
[//]: # (#### Candidate version)

[//]: # (To complete ...)

[//]: # ()
[//]: # (#### Log group)

[//]: # (To complete ...)

#### _Stage Verifier_
Continuous verification addresses reliability requirements of production systems. 
It places automated health and quality gates in the release stages of DevOps pipelines.
The gates validate the functionality, security or performance of applications.


[//]: # (#### Deployment abnormality)

[//]: # ()
[//]: # (The main challenge facing of deployments is validating the health of newly deployed service instances. )

[//]: # ()
[//]: # (To complete ...)

#### _Tag_
Tags make a point as a specific point in Git history.
[Tagging](https://git-scm.com/book/en/v2/Git-Basics-Tagging) is generally used to capture a point in history that is used for a marked version release (i.e. v1. 0.1).

#### _Log Level_

Each log message has an associated log level. 
A log level is a way of classifying log messages in terms of importance and urgency. 

| level | Description |
| ----- | ----------- |
| TRACE	| Most detailed level of tracing program flow |
| DEBUG	| Recording of the completion of a secondary operation of a class or utility, or for recording other details |
| INFO	| Recording of the completion of the principle operation of a class or utility |
| WARN 	| Unexpected state that is not an error, or is recoverable, and that a developer or operator should examine |
| ERROR	| Error message logged just prior to raising an error |
| FATAL	| Message recorded, when possible, as the process is terminating due to an error |

#### _Application_


#### _User_


#### _Log message_


#### _Log Compare_

#### State is an abstraction of log message. Often the word `template` is used to refer to state. A `state` or `template` is the logging statement that was used to "print" the actual log message. For example, in printf("This is the %d log message", 5), a `state` would be `This is the * log message`, and the actual realisation of the state in a log message would be `This is the 5 log message`. logsight.ai automatically infers `states` from raw `log messages`.


#### _candidate_

#### _baseline_