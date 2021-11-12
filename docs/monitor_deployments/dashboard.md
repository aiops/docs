# Stage Verifier Dashboard

> The stage verifier dashboard provides a bird's-eye view of applications' deployments managed by `logsight.ai`

`Time frame` Use the datepicker on the right top corner.

![Log compare select timeframe](../assets/images/log_compare_select_timeframe.png)


`Application name`, `application version` and `LogCompare` Select the application to analyze, and the deployment versions to compare. 
The oldest version is called the baseline version.
The newest version is called the candidate version.
Click on the LogCompare button to start the computation.

![Log compare select version](../assets/images/log_compare_select_version.png)


<br>

![Logs](./dashboard.png ':size=1200')

<br>


`Compare overview` is a heatmap that shows the overall difference between the baseline version and the candidate version overtime.

![log compare cognitive anomaly](../assets/images/log_compare_overview.png ':size=900')


`Cognitive anomaly count` shows the cognitive anomaly count for the baseline and candidate versions.

![log compare cognitive anomaly](../assets/images/log_compare_cognitive_anomaly.png)


`Ratio anomalies` shows correlated logs that "go together".
For example, `Opening connection.` and `Closing connection`.
Broken ratios (i.e., with a anomaly score is high) may suggest an anomaly (deviation between the comparing logs).

![Log compare ratio](../assets/images/log_compare_ratio.png)



`Log groups` is

![Log compare log group](../assets/images/log_compare_log_group.png)



`Log type count` shows the count difference between the log types of the baseline and candidate versions.

![Log compare log type](../assets/images/log_compare_log_type.png)


`New log types` shows the new log types, along with the cognitive anomaly prediction. 
Having new log types that are labeled as anomaly may be an indicator of a problem.

![Log compare new log types](../assets/images/log_compare_new_log_types.png)

