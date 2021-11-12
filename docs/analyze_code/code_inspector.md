# Code Inspector

![Code Inspector](./code_inspector.png)


Semantic and linguistic analysis of code and log data and provides recommendations to improve the quality of the logs.

The steps in the Continuous Delivery (CD) phase include deployment verification, dynamic code analysis and
then deployment to production.
`logsight.ai` supports continuous verification of deployments, comparing tests, detecting test flakiness 
and other log compare tasks. 

The quality of a analysis result heavily depends on the input. Therefore, event
logs should be treated as first-class citizens in the information systems supporting the processes to be analyzed. Unfortunately, event logs are often merely
a “by-product” used for debugging or profiling.
There are several criteria to judge the quality of event data. Events should be
trustworthy, i.e., it should be safe to assume that the recorded events actually
happened and that the attributes of events are correct. Event logs should be
complete, i.e., given a particular scope, no events may be missing. Any recorded
event should have well-defined semantics.


## Processing Workflow

1. `Shipping logs`. You set up a log collector to gather logs across your infrastructure and ship the logs to our centralized logging platform.
2. `AI-processing`. We search and analyze your logs to identify uncommon patterns and structures using various AI-models. 
3. `Customer AI model`. We can also use specialised and customized AI-models to model customers' IT systems. 
4. `Incident detection`. Our AI-models are capable of identifying ongoing outages and incidents.
5. `Notification`. We send you a notification when an incident is in progress.

<div align=center>
<img width="1000" src="/analyze_code/how_it_works.png"/>
</div>



## Intelligent NLP

### Level analysis
XXX

### Linguistic analysis
XXX

### Intelligent recommendation
XXX


> [!NOTE]
> Faster releases leads to increasing failures – Gartner