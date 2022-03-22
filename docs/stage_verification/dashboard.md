# Stage Verifier Dashboard

> The `Stage Verifier` dashboard provides a detailed view of verification results by `logsight.ai`


<br>

![Logs](./verification_marked.png ':size=1200')

<br>


`Time frame` Use the datepicker on the right top corner.

`application name` and `application tags` select the application to analyze, and the log version `tags` to compare. 

The `tag` that we compare against is called baseline.

The `tag` that is being compared is called candidate.

`State` is an abstraction of log message. Often the word `template` is used to refer to state. A `state` or `template` is the logging statement that was used to "print" the actual log message. For example, in printf("This is the %d log message", 5), a `state` would be `This is the * log message`, and the actual realisation of the state in a log message would be `This is the 5 log message`. logsight.ai automatically infers `states` from raw `log messages`.

`Verify` button starts the computation.

The `State` overview shows general statistics about how many states were modified from `baseline` to `compare` version of the application, including fault detection, etc.

The `State` analysis table shows detailed view of the `states`.
