# Stage Verification

`logsight.ai` supports the continuous verification of deployments, test results comparison, testing in production, QA, and other testing strategies.

<div align=center>
    <img width="400"  src="/stage_verification/imgs/concept.png"/>
</div>


## Introduction

### Log Analysis

The development of reliable software typically involves the use of interactive debugging tools and the analysis of log files. 
While debugging tools became very sophisticated over the years, the same cannot be said about the solutions available for log analysis.  

The benefit of a debugger is that it lets developers see all the "states" of a program during its execution.
By state, we refer to a line of code executed and the data stored in variables.
Developers manually use debuggers during code development.

When testing software via, e.g., unit, integration testing, or monitoring, it is common to rely on another method: log file analysis.
With this method, the states executed by a program are recorded in a log file which is later analyzed by developers.
Since a program can generate a large quantity of states, developers carefully select the states considered important or useful for program monitoring and/or locating faults.


### Manual vs. Automated Verification

During testing, and once the program completes its execution, developers manually scan log files to check if error states were recorded.
The task consists in comparing the log records from version B of a program with the logs from version A.
It is a form of software A/B testing.

One current limitation of log file analysis is that it is still a manual task. 
This limitation is worse when log files are large and with a complex structure.

At logsight.ai, we automate log file analysis. 
Our solution builds on the important notion of state.


## States

### State Mining 

In simple terms, a state is a logging statement used to record valuable runtime information about applications.
A state includes a level or severity (e.g., warning), and a textual description which is often parametrized with
the current values of variables and context information (e.g., thread id, request id), e.g.:
   
    logging.warning('Unable to connect to: %s:%s', ip, port)

At runtime, if reached, the state above generates a log record similar to:

    2017-05-16 11:32:09 WARN Unable to connect to: 192.168.0.1:9090

To find the states generated/reached by an application using log records, we rely on `state mining`. 
This technique converts log file records into a feature vector of variables/values. 
For example, the following log record,

| Timestamp | Level | Log message                          | 
|:---------:|-------|--------------------------------------|
|    8h31   | INFO  | Cannot connect to: 192.168.0.1:9090  |

is abstracted using state mining to:

| Timestamp | State                    | Variables               | Level | 
|:---------:|--------------------------|-------------------------|:-----:|
|    8h31   | Cannot connect to: $1:$2 | $1=192.168.0.1, $2=9090 |  INFO |


### State Semantics

Continuous verification also uses semantic analysis and natural language understanding (NLU) to compare logs. 
Its AI-model was trained to understand the hidden and underlying latent semantics of words in logs messages.
This allows to annotate states with semantic information describing their inherent nature: report or fault.

As an example, the state shown previously is annotated to include semantic information. 
While the level is INFO, the state semantic is associated with a FAULT.  

| Timestamp | State                      | Variables               |  Level  | Semantics |
|:---------:|----------------------------|-------------------------|:-------:|:---------:|
|    8h31   | Cannot connect to: $1:$2   | $1=192.168.0.1, $2=9090 |  INFO   |   FAULT   |


## Verification

Our approach to verification compares two runs (versions) of the same application to identify critical differences among the states generated.
This spotting-the-differences approach identifies the states reached by version A and version B.
Based on the changes of state level, semantics, occurrence, recurrence, frequency, etc., a `risk score` is calculated for each state.
Afterwards, a `deployment risk` is calculated based on all the individual risk scores. 
The deployment risk is used to determine if a new version of an application can move to production or if it should be blocked and reworked.  

### State Overview

The `State overview` table provides a bird's-eye view of the changes of states in version A and version B.
It contains four important metrics: 
+ Number of added states
+ Number of deleted states
+ Number of recurring states
+ Number of states with a high change of frequency of occurrence

The following table shows the results of a verification: 3 states were added, 1 was deleted, and 24 are recurring in version B when compared to version A.

|      Added states       | Deleted states |      Recurring states      | Frequency change |
|:-----------------------:|:--------------:|:--------------------------:|:----------------:|
| 3<br>2x REPORT/1x FAULT | 1<br>1x FAULT  | 24<br>23x REPORT/1x FAULT  |        0         |

Table 1. State overview table 

The table also shows a subdivision of the count per REPORT and FAULT states. This information is important for troubleshooting regressions. For example, if a version B introduces new states classified as FAULT, this will be associated with a higher deployment risk score. On the other hand, if FAULT states are missing (deleted) in version B, this indicates that bugs have been removed in the new version.    

When additional troubleshooting is needed, the following `State analysis` table is used to inspect  individual states. 


### State Analysis

The `State analysis` table presents an individual analysis of each state present in version A or B.
The following table shows how the risk score is calculated (the table was simplified when compared to the table of the UI).

+ The state in row 1 was generated by both versions A and B. Since state frequency change from A to B was low (+8%), the risk score is 0. 
+ Row 2 is similar to row 1. Since there is a significant -94% drop of the number of INFO states recorded in version B, the risk is set as 10. 
+ Row 3 is similar to row 2. But in this case, its level is warning (WARN) and its frequency increased +162% in version B. Thus, the risk is 50.
+ The state of row 4 was added in version B. Since it is new and it has the level WARN, the risk score is set to 50.
+ The state of row 5 was removed in version B. Since an ERROR state was remove from the application, the risk is 0.


|     | Time | Level | Semantics | Log message                              | State                        |  A  |  B  |         | Change | Risk Score |
| :-: | :-------: | ----- | :-------: | ----------------------------------- | ---------------------------- | :-: | :-: | :-----: | :----: | :--------: |
|  1  |    8h21   | INFO  |   REPORT  | Customer id=111-222 data stored     | Customer id=$1 data stored   | Yes | Yes |  RECUR  |   +8%  |      0     |
|  2  |    8h22   | INFO  |   REPORT  | Processing request req=A12-345      | Processing request req=$1    | Yes | Yes |  RECUR  |  -94%  |     10     |
|  3  |    8h24   | ERROR |   REPORT  | Retrying (#15) request req=A22-222  | Retrying ($1) request req=$2 | Yes | Yes |  RECUR  |  +162% |     25     |
|  4  |    8h31   | WARN  |   FAULT   | Cannot connect to: 192.168.0.1:9090 | Cannot connect to: $1:$2     |  No | Yes |  ADDED  |  +100% |     60     |
|  5  |    8h35   | ERROR |   FAULT   | Insufficient memory (64GB)          | Insufficient memory ($1)     | Yes |  No | DELETED |  -100% |      0     |

Table 2. Example of risk score calculation    

> [!NOTE]
> With logsight.ai UI, version A of an application is called `Baseline` and version B is called `Candidate`

The risk score is set using the following logical table. 
For example, if a version has a new (added) state labelled with Level = ERROR, but with Semantics != FAULT, the state receives a risk score of 70 points. 

| State     | Level = ERROR* | Semantics = FAULT | Change = HIGH | Risk Score |
|-----------|:--------------:|:-----------------:|:-------------:|:----------:|
| Added     |      Yes       |        Yes        |               |     80     |
|           |      Yes       |        No         |               |     70     |
|           |       No       |        Yes        |               |     60     |
|           |       No       |        No         |               |     0      |
| Deleted   |                |                   |               |     0      |
| Recurring |      Yes       |        No         |      No       |     25     |
|           |       No       |        Yes        |      No       |     25     |
|           |      Yes       |        Yes        |      No       |     25     |
|           |       No       |        No         |      No       |     0      |
|           |      Yes       |        No         |     Yes+      |     50     |
|           |       No       |        Yes        |     Yes+      |     50     |
|           |      Yes       |        Yes        |     Yes+      |     50     |
|           |       No       |        No         |     Yes+      |     10     |

Table 3. States and their risk score (* ERROR, CRITICAL or FATAL, + coming soon)


### Deployment Risk

The deployment risk is calculated by considering each individual risk score. 
The following formula is used: 

+ Deployment Risk = max(risk score of all states) + min(average risk score, 100 - max risk score)

For example, the deployment risk of the states from Table 2 is:

+ max([0, 10, 25, 60, 0]) + min(average([0, 10, 25, 60, 0]), 100 - max([0, 10, 25, 60, 0])) = 60 + min(19, 100 - 60) 
+ = 79

If the deployment failure risk is greater than a predefined threshold (e.g., 80), the verification gate gate blocks the deployment from going to production.
Typically, the logic to block a deployment using a threshold is implemented on the CI/CD pipeline of the client (e.g., Jenkins, Github Actions).


### Troubleshooting

To troubleshoot verifications a typical process is:

- Identify verifications with a high deployment risk score
- Identify states which were added to the `State analysis` table
- Identify states characterized by Level = ERROR and/or Semantics = FAULT in the new version
- Identify recurring states with Level = ERROR and/or Semantics = FAULT, with HIGH frequency of changes
- Use the state description, locate the source file and the line number which generated the state 
- Fix the errors and faults in the codebase and restart a deployment