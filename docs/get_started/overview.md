# Overview

`Logsight.ai` is the next generation of proactive troubleshooting [AIOps](https://en.wikipedia.org/wiki/Artificial_Intelligence_for_IT_Operations) platforms which rely on Deep Learning and AI-powered Log Analytics to discovery log data insights. Our platform delivers an 
observability and troubleshooting platform for modern enterprise engineering teams, helping them to proactively discover emerging failure, solve issues more quickly. 

## Operating workflow

1. `Shipping logs`. You set up a log collector to gather logs across your infrastructure and ship the logs to our centralized logging platform.
2. `AI-processing`. We search and analyze your logs to identify uncommon patterns and structures using various AI-models. 
3. `Incident detection`. Our AI-models are capable of identifying ongoing outages and incidents.
4. `Notification`. We send you a notification when an incident is in progress.

 
![Logs](./get_started/how_it_works.png ':size=900 :no-zoom')


Our log analytics platform also provides important features to support troubleshooting:
+ `Log comparison`. You can compare logs to identify key differences that led to incidents. 
+ `Log quality`. You can evaluate the quality of your logs to determine the cost of operations.  
+ `Log variables`. You can visualize and analyze how the variables of your applications affect its health.    


## Deployment scenarios

The two most common options to deploy `Logsight.ai` are: 

1. Enterprise self-built Log Analytics Platform
  + We provide the ELK stack to customers as well as AI-powered Log Analytics 
2. Interconnection with third-party Log Analysis solutions
  + You use your preferred log monitoring solution and use our AI-powered Log Analytics as an extension 


![Logs](/get_started/logsight_architecture.png ':size=900 :no-zoom')

Our log analytics platform also provides important features to support troubleshooting:
+ `Log collection`. Log shippers act as Lightweight agents installed on servers of your infrastructure for collecting logs.
+ `Log aggreagtion`. Logstash has many plugins for collecting, enriching, and transforming data from a variety of sources.
+ `AI-driven analytics`. Discover incidents, failure patterns and evaluate quality of log data.
+ `Troubleshooting`. Use proactive and contextual information to quickly determine the root-cause of problems.

## Shipping logs

There are 3 options to ship logs `Logsight.ai`:

+ [Beats](https://www.elastic.co/beats/) or [Logstash](https://www.elastic.co/logstash/) 
+ [SDK for Python](https://logsight-sdk-py.readthedocs.io/en/latest/)
+ [curl](https://curl.se/) or [wget](https://www.gnu.org/software/wget/) 


The SDK for Python provider the greater customization for you to integrate your platform with `Logsight.ai`. 
Beats and Logstash provide out-of-the-box connector for dozens of systems (e.g., MySQL, Apache, Github, Kafka)  


![Logs](./get_started/shipping_logs.png ':size=900 :no-zoom')

