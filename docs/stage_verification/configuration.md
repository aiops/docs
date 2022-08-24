# Configuration

> [!NOTE]
> Currently, configuration is only available for the on-prem version. For SaaS, it is in our work pipeline

To modify the way the `risk score` and `deployment failure risk` are computed, the following environment variables that represent risks for each case can be modified:

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

For example, `RISK_SCORE_ADDED_STATE_LEVEL_INFO_SEMANTICS_FAULT` sets the risk for the added states, which have level = INFO, and semantics = FAULT. The default value is 60 since the new state is possibly associated with a failure. 



