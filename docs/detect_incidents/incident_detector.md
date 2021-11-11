# Incident Detector

![Incident Detector](./incident_detector.png)

`logsight.ai` provides an easy to use incident detection and root cause investigation solution which does not require to setup manual rules and thresholds 

## Processing Workflow

1. `Shipping logs`. You set up a log collector to gather logs across your infrastructure and ship the logs to our centralized logging platform.
2. `AI-processing`. We search and analyze your logs to identify uncommon patterns and structures using various AI-models. 
3. `Customer AI model`. We can also use specialised and customized AI-models to model customers' IT systems. 
4. `Incident detection`. Our AI-models are capable of identifying ongoing outages and incidents.
5. `Notification`. We send you a notification when an incident is in progress.

<div align=center>
<img width="1000" src="/detect_incidents/how_it_works.png"/>
</div>


## Intelligent Detection

### Level analysis

Existing solutions to detect incidents typically let users set a static alert for an application if the number of messages with an ERROR or WARNING log level exceeds a specified threshold in a certain timeframe.
The problem with this approach is that it assumes log levels accurately correlate with failures.
In practice, this is not true. Failures are also associated with log messages of level INFO. As a result, multiple false positive alerts are generated while missing real incidents.
Manually defining rules to automatically classify records as anomalous by matching keywords such as “loss”, “lost”, etc. suffers from the same problem. 

<div align=center>
<img width="500" src="/detect_incidents/log_level_analysis.png"/>
</div>

### Semantic analysis

Logsight Incident Detection takes a different approach. It extracts the semantic meaning of log messages, capture the contextual information from log sequences, and evaluates the risk that they are associated with an imminent failure. It does not rely on log level information or keywords. Logsight introduces an AI model that has learned from millions lines of software code the semantics of system failures. The model is applied to the logs across all different applications so you can get a precise insight on any incident across your stack.

<div align=center>
<img width="500" src="/detect_incidents/cognitive_analysis.png"/>
</div>


> [!NOTE]
> Central log management is still very relevant today and can be a key, but undervalued, tool for an organization's threat detection and response capabilities
> (source Gartner)