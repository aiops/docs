# 5 minutes to logsight.ai 

> Slides are also available: [pdf](videos/5_minutes.pdf ':ignore')

[video website](https://www.youtube.com/embed/z1Gg_y_6-C0 ':include :type=iframe width=440px height=300px')


### Projections

Over the next 5 years, the adoption of Cloud Computing and Microservices will continuously increase.
The global Cloud Computing market is expected to grow at 18%,
while the Cloud Microservices Market is expected to register an annual grow of approximately 21.7%.

This rapid growth of the cloud and microservice market, together with the emergence of IoT,
Industry 4.0, Edge Computing, self-driving cars, smart home, and smart cities brings challenges for the availability
and reliability of critical cloud infrastructures


### Failures are inevitable

A recent study exposed that almost 25% of small and medium-sized companies reported that their per-hour downtime cost was more than $40,000. 
With only 27% stating that their cost of downtime per hour was under $10,000.
To guarantee availability and reliability, and avoid downtime, companies must rely on advanced solutions to cope with the scale and complexity of IT systems. 
Logs have been one of the referred ways to troubleshoot and repair systems.


### Applications of logs 

In fact, application and system logs can be effectively exploited to support many tasks ranging 
from debugging, IT performance monitoring, security, regulatory compliance, policy compliance, 
IT operations troubleshooting, applications troubleshooting, to business analytics.


### Approaches to troubleshooting

Nowadays, DevOps have two time-consuming options to troubleshoot IT failures using logs:
+ Log Search and 
+ Log Analysis

Most companies use Log Search:
+ It is cheap, but requires a lot of manual work
+ It does not scale well to complex systems
+ It involved a lot of guesswork

Fewer companies use Log Analysis:
+ It is simple, but expensive (requires many DevOps/SRE) 
+ It has a high potential to overlook errors
+ It often causes human fatigue


### Logsight.ai's solution  

An effective solution is to rely on what we call automated log analytics through AI and pre-trained failure models. 
It works in the following way: 
+ Logsight pre-trains large generic AI failure models
+ Which can be specialized with customers’ systems behavior described by their logs
+ During operation, we receive and process live production logs from customers
+ and we notify customers if their logs indicate that incidents are happening
+ In such situations, we send customers detailed reports of incidents in real-time


### Beyond the Status Quo

Logsight goes beyond the status quo and makes a radical shift from log analysis to log analytics.

Existing solutions for Log analysis generally involve some form of Clustering and Time Series analysis.

In contrast, Logsight relies on:

+ Deep Learning and Failure models 
+ To build an AI-driven solution for log analytics


### Use case 

To demonstrate the benefits of Logsight, we benchmarked the performance of using a traditional log search approach with our AI-driven log analytics solution.
The use case involved troubleshooting an IT system undergoing a latent failure.

The Log search approach required 240 minutes to identify the root-cause of the failure. 
It involved:

+ Experienced DevOps to conduct the troubleshooting 
+ Reading and searching logs for hints and
+ Building search filters using grep and awk to locate messages with keywords such as error and warning 

In contrast, the AI-driven log analytics approach taken by Logsight only took 4 minutes.
This corresponds to less that 2% of the time requires by the log search approach:

+ 59 seconds were spent uploading ~350.000 log lines 
+ 64 seconds for pre-processing and
+ 90 seconds for the AI-driven processing


### Beyond the Status Quo

When we compare the troubleshooting efficiency of log search and log analysis to log analytics, it is clear that the time savings materialize in a significant reduction on the number of DevOps required to operate IT systems. Not only the cost of managing IT decreases, but the Mean Time To Repair (MTTR) systems is also significantly reduced. 

+ Log search is typically slow since it relies on simple tools such grep, awk and query languages such as Kibana Query Language (KQL)
+ Log analysis is faster, but still requires to adjust the parameters of clustering techniques and time series-based algorithms which is complex
+ Log analytics achieves the greater efficiency due to the use of modern Deep Learning algorithms and knowledge captured by pretrained failure models


### Innovation 

Logsight drives its Innovation from tree pillars:

+ Leading edge AI technology 
+ Industry-ready 
+ Long-term research 

Logsight learnes how DevOps write log messages from hundreds of millions of lines of code.
It was deployed, tested, and continuously improved in collaboration with large IT and cloud providers. 
Logsight results from several years of research, and more than 50 scientific publications and 5 PhD thesis

The team behind Logsight has a long-standing experience in the field of Machine Learning, Log Analytics, 
Anomaly Detection, Cloud Computing, AIOps, SRE, IT management and distributed systems