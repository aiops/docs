# Stage Verifier

![Stage Verifier](./stage_verifier.png)

The steps in the Continuous Delivery (CD) phase include deployment verification, dynamic code analysis and
then deployment to production.
`logsight.ai` supports continuous verification of deployments, comparing tests, detecting test flakiness 
and other log compare tasks. 

## Processing Workflow

1. `Shipping logs`. You set up a log collector to gather logs across your infrastructure and ship the logs to our centralized logging platform.
2. `AI-processing`. We search and analyze your logs to identify uncommon patterns and structures using various AI-models. 
3. `Customer AI model`. We can also use specialised and customized AI-models to model customers' IT systems. 
4. `Incident detection`. Our AI-models are capable of identifying ongoing outages and incidents.
5. `Notification`. We send you a notification when an incident is in progress.

<div align=center>
<img width="1000" src="/monitor_deployments/how_it_works.png"/>
</div>



## Intelligent Verification

### Cognitive analysis
XXX

### Template mining
XXX



> [!NOTE]
> Faster releases leads to increasing failures – Gartner