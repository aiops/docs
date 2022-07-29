## Interpreting the verification report

Logsight verification response returns a report containing overview of the particular verification. 
In the JSON, the most important key for debugging purposes is the link of the detailed verification report, which is always composed of http(s)://URL/pages/compare/insights?compareId=YOUR_COMPARE_ID
When the detailed report is open, the user will see the following screen, which contains all necessary information about the troubleshooting process

![Logs](./verification-example.png ':size=1200')

### How to troubleshoot?
First, the most important is to analyze the `State overview` information. 
It contains four important KPIs about the verification: Number of added states, number of deleted states, number of recurring states, number of states where the frequency of occurrence changed.
Depending on the particular use-case, often the most important parts here are the number of added states and number of deleted states.
After checking these overview statistics, as in the example above, we see 1 added state, 1 deleted state, and 8 recurring states.

We observe 1 added state, which has medium risk.

![Logs](./verification-example-1.png ':size=1200')

The most important columns for troubleshooting in the table are Risk, Description (added states), Level, and Semantics.
If there are many states to analyze, we suggest the following process for debugging:
- Search for “added” states in the Description.
- Sort by Level → to check if there are any errors introduced in the new deployment.
- Sort by Semantics → to check if there are any errors introduced which are only recognized by logsight
- Fix the ERRORS and FAULTS.

### I see the errors, but I still want my deployment to pass the gate. What should I do?
In your CI/CD pipeline (e.g., Jenkins, Github Actions) there is a defined threshold for blocking deployments → The solution is to increase the threshold. 

### How can I modify how the risk is computed? What if I want to set the risk of Recurring states (independent of Level and Semantics) to 0 ?

The computation of the risk score can be controlled by setting the following environment variables that represent risks for each case:

```yml
RISK_SCORE_ADDED_STATE_LEVEL_INFO_SEMANTICS_REPORT = 0
RISK_SCORE_ADDED_STATE_LEVEL_ERROR_SEMANTICS_REPORT = 70
RISK_SCORE_ADDED_STATE_LEVEL_INFO_SEMANTICS_FAULT = 60
RISK_SCORE_ADDED_STATE_LEVEL_ERROR_SEMANTICS_FAULT = 80

RISK_SCORE_DELETED_STATE_LEVEL_INFO_SEMANTICS_REPORT =  0
RISK_SCORE_DELETED_STATE_LEVEL_ERROR_SEMANTICS_REPORT = 0
RISK_SCORE_DELETED_STATE_LEVEL_INFO_SEMANTICS_FAULT =  0
RISK_SCORE_DELETED_STATE_LEVEL_ERROR_SEMANTICS_FAULT = 0

RISK_SCORE_RECURRING_STATE_LEVEL_INFO_SEMANTICS_REPORT = 0
RISK_SCORE_RECURRING_STATE_LEVEL_ERROR_SEMANTICS_REPORT =  25
RISK_SCORE_RECURRING_STATE_LEVEL_INFO_SEMANTICS_FAULT = 25
RISK_SCORE_RECURRING_STATE_LEVEL_ERROR_SEMANTICS_FAULT = 25
```

For example, `RISK_SCORE_ADDED_STATE_LEVEL_INFO_SEMANTICS_FAULT` sets the risk for the added states, which have level INFO, and semantics FAULT. In this case the risk should be high, because the state was added and logsight recognized it as a fault. 
