# Log Writer


`logsight.ai` supports the semantic and linguistic analysis of code and log data,
and provides recommendations to improve the quality of the logs. 


> [!NOTE]
> The feature is under development. The community version will be on [Github](https://github.com/aiops/log-writer). You can star the project to get regular updates on the progress.
We wrote a [medium](https://medium.com/@snedelkoski/software-engineering-needs-auto-logging-681185e9a4e1) post explaining the ideas behind the log writer.

## In a nutshell

<video autoplay loop muted>
  <source src="./autologging.mp4" type="video/mp4">
</video>

## Intelligent NLU

### Level analysis and log recommendation
Log levels classify log messages (i.e., system states) according to predefined keywords such as ERROR, WARNING and INFO. Developers need to correctly assigned log levels to log statements. Otherwise, incorrect levels will mislead SRE and operators while troubleshooting system failures.

However, correctly assigning log levels is difficult since typically there are no practical specifications, guidelines or automated tool. 

`logsight.ai` provides a solution to this problem.
It uses natural language understanding (NLU), AI models to automatically infer the semantics of log messages and verify that it matches log levels.
The AI models were trained by extracting insights from ~10.000 well-known open source projects.

`logsight.ai` is able, not only to identify level mismatches, but also gives recommendations on the more suitable 
log level to assign to a given message.  


### Linguistic analysis
Writing meaningful log messages is one of the most important best practices while writing software. Short or cryptic log message are of little help during the troubleshooting of systems. A log file may be the only source of information left to understand the root cause of a failure.

Unfortunately, many log messages are unclear and lack contextual information. They are too short or too long. They mingle English and other languages. They do not contain subjects or verbs. 

`logsight.ai` overcomes this problem by automatically characterizing and evaluating the quality of log messages.
NLU and large AI models trained capture de facto best practices.
This knowledge is distilled into neural models which qualify log quality in real time.

