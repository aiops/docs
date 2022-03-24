# Logging Code Inspection

<div align=center>
<img width="100" src="./code_inspector.png"/>
</div>


`logsight.ai` supports the semantic and linguistic analysis of code and log data,
and provides recommendations to improve the quality of the logs.

> [!NOTE]
> The code inspector UI and API are in development.

## Processing Workflow

1. `Shipping code/logs`. You set up a log collector or GitHub action to gather logs across your applications. This allows logsight.ai to process the logs.
3. `AI-processing`. We analyze your code/logs to identify low quality log statements using various AI-models. 
4. `Customer AI model`. We can also use specialised and customized AI-models to model customers' IT systems. 
5. `Quality metrics`. Our AI-models quantify your code/log quality.
6. `Notification`. We send you a notification when the quality is low according to best practices.

<div align=center>
<img width="1000" src="/analyze_code/how_it_works.png"/>
</div>


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

> [!NOTE]
> Quantitative code quality metrics provide a guide for better and faster CI/CD