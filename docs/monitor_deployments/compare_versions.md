# Compare Versions

> [!TIP]
> An overview of the log compare page can be found at [Log Compare](./logsight_ui/log_compare.md)

`LogCompare` is a core logsight.ai function that is useful for comparing logs from 
different versions of deployments, comparing tests, detecting test flakiness, and other log compare tasks. 

There are several steps that you need to follow for the usage of `LogCompare`.

## Prerequisites

1. `Create application`. Use the [manage application](/administration/manage_applications)
2. `Send logs`. Use your preferred method from [shipping_logs](/send_logs/shipping_logs) to send your logs
3. `Set tags`. Use the functionality described in [set tags](/monitor_deployments/set_tags.md) to tag your logs


## Log Compare

### Set time interval and version

Use the datepicker on the right top corner.

![Log compare select timeframe](../assets/images/log_compare_select_timeframe.png)


Select the versions to compare

![Log compare select version](../assets/images/log_compare_select_version.png)

Click on the LogCompare button. This initiates the computation.


### Compare overview

`Compare overview`. Is a heatmap that shows the overall difference between the baseline tag (pass) and the compare tag (fail).

![log compare cognitive anomaly](../assets/images/log_compare_overview.png)


### Cognitive anomalies

`Cognitive anomaly count`. Shows the cognitive anomaly count for the two tags (top and bottom).

![log compare cognitive anomaly](../assets/images/log_compare_cognitive_anomaly.png)


### Ratio Anomalies

`Ratio anomalies`. Shows correlated logs that "go together". For example, `Opening connection.` and `Closing connection`.  Broken ratios (high `Anomaly score`) may suggest an anomaly (deviation between the comparing logs).

![Log compare ratio](../assets/images/log_compare_ratio.png)


### Log Groups

![Log compare log group](../assets/images/log_compare_log_group.png)


### Log Types

`Log type count`. Shows the count difference between the log types.

![Log compare log type](../assets/images/log_compare_log_type.png)


### New Log Types

![Log compare new log types](../assets/images/log_compare_new_log_types.png)

`New log types`. Shows the new log types, along with the cognitive anomaly prediction. Having new log types that are labeled as Anomaly may be an indicator of a problem.