# User Interface

Stage verification display information using 3 tabs:

+ Overview
+ Insights
+ Analytics


## Overview 

### Create Verification 

To trigger a new verification, add the `Baseline tags` and the `Candidate tags` for the application you want to analyze.
Click on the `Create` button to start the verification. 

![Logs](./create_verification.png ':size=1200')

A verification ID will be created and displayed in the `Overview` tab.


### Overview

The overview table shows all the verifications already made. Each record, displays:
+ Verification date and ID
+ Baseline and candidate tags
+ Risk and Severity 
+ Status

![Logs](./overview.png ':size=1200')

A verification can have the status: `Raised`, `Assigned` or `Resolved`. 
When a verification completes, its status is raised. 
If the verification yielded a high risk and severity, it can be assigned to a developer to investigate the root cause.
When it is fixed, the status is set to resolved.

To obtained more information on a verification, the option `View Insights` redirects you to the insights tab.


## Insights

Verification insight display information about:

+ Versions
+ Deployment risk and logs analyzed  
+ State overview
+ State analysis


### Versions, etc.

![Logs](./insights.png ':size=1200')

`ID` Identifier of a specific verification request. 

The `tags` that we compare against are called baseline.

The `tags` that are being compared are called candidate.

### Deployment risk and logs analyzed  

...

### State overview

The `State` overview shows general statistics about how many states were modified from `baseline` to `candidate` version of the application, including fault detection, etc.


### State analysis
The `State` analysis table shows detailed view of the `states`.


## Analytics

Verification analytics display information about:

+ KPI
+ Risk history
+ Status statistics

![Logs](./analytics.png ':size=1200')


### KPI


### Risk history


### Status statistics 




# Others
`State` is an abstraction of log message. Often the word `template` is used to refer to state. A `state` or `template` is the logging statement that was used to "print" the actual log message. For example, in printf("This is the %d log message", 5), a `state` would be `This is the * log message`, and the actual realisation of the state in a log message would be `This is the 5 log message`. logsight.ai automatically infers `states` from raw `log messages`.
