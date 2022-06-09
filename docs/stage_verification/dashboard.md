# Stage Verifier Dashboard

> The `Stage Verifier` dashboard provides a detailed view of verification results by `logsight.ai`
<br>

Selecting `Baseline tags` and `Candidate tags` and clicking on the `Create` button, will start a verification process between the logs that belong to those tags. It results in a new entry in the `Overview` table, showing the Risk and Severity of the case. Clicking on `View Insights` redirects you to the Insights page of the specific verification shown bellow.

### Overview 

![Logs](./create_verification.png ':size=1200')

Each verification can have different statuses, e.g., when its created status is `Raised`, however, when it is assigned or resolved the user can set the status to `Assigned` or `Resolved`.

### Insights

![Logs](./verification_marked.png ':size=1200')

`ID` Identifier of a specific verification request. 

The `tags` that we compare against are called baseline.

The `tags` that are being compared are called candidate.

`State` is an abstraction of log message. Often the word `template` is used to refer to state. A `state` or `template` is the logging statement that was used to "print" the actual log message. For example, in printf("This is the %d log message", 5), a `state` would be `This is the * log message`, and the actual realisation of the state in a log message would be `This is the 5 log message`. logsight.ai automatically infers `states` from raw `log messages`.

The `State` overview shows general statistics about how many states were modified from `baseline` to `candidate` version of the application, including fault detection, etc.

The `State` analysis table shows detailed view of the `states`.

### Analytics
Lastly, `Analytics` shows summary statistics for selected tags.

![Logs](./analytics.png ':size=1200')
