# Verify stages using GitHub Actions

<!-- TODO: replace the links by the official marketplace links -->
The following GitHub Actions are used to integrate logsight with [GitHub Workflows](https://docs.github.com/en/actions/using-workflows):
1. [logsight-setup-action](https://github.com/aiops/logsight-setup-action)
2. [logsight-verification-action](https://github.com/aiops/logsight-verification-action)

## Prerequisites

Create a logsight account at [https://logsight.ai](https://logsight.ai).

## GitHub Workflow configuration

Add the following steps to enable the logsight.ai Stage Verification as a Quality Gate into your workflow:
We recommend setting up `LOGSIGHT_USERNAME` and `LOGSIGHT_PASSWORD` as secrets to your repository. Go to `project settings -> secrets -> actions -> new repository secret`. Alternatively, the username and password can be set as parameters in the GitHub Action definition. We do not recommend to do this for safety reasons.

Add the `logsight-setup-action` and the `logsight-verification-action` into you GitHub Workflow definiton. 

```
- name: Logsight Setup
  uses: aiops/logsight-setup-action@main
  id: setup
  with:
    username: ${ { secrets.LOGSIGHT_USERNAME } }
    password: ${ { secrets.LOGSIGHT_PASSWORD } }
    application_name: ${{ github.ref }}

- name: 🚀 STEPS FROM THE EXISTING WORKFLOW FROM YOUR APPLICATION
- name: 🚀 CONDUCT TESTS FROM YOUR OWN APPLICATION

- name: Verify logs
  uses: aiops/logsight-verification-action@main
  id: verify-logs
  with:
    github_token: ${ { secrets.GITHUB_TOKEN } }
    username: ${ { secrets.LOGSIGHT_USERNAME } }
    password: ${ { secrets.LOGSIGHT_PASSWORD } }
    application_id: ${ { steps.setup.outputs.application_id } }
    baseline_tag: { { github.sha } }
    candidate_tag: { { github.event.before } } 
    risk_threshold: 0
```

The `logsight-setup-action` needs to be defined before the main steps of your workflow (e.g. prios building and testing). It will initialize the collection of log data during the execution of the workflow. [FluentBit](https://docs.fluentbit.io/manual/) is used to collect log data from configurable sources. The [readme](https://github.com/aiops/logsight-setup-action) of the `logsight-setup-action` provides additional information on how to configure the action. **With the default configuration the action collects logs from running docker containers.**

The `logsight-verification-action` should be defined after all main workflow steps. It will request the analysis results of the log data that were collected during the workflow execution from logsight.ai. These results contain the deployment risk score summarizing the probability of failures when deploying the current version of the code. If this score exceeds a defined threshold, a GitHub Issue is created. 

> You need at least **two executions of the GitHub Workflow** in your repository to execute the Stage Verification.

As a workaround, you can set the configuraiton of the the `candidate_tag` to **`candidate_tag`: { { github.sha } }**. Thereby, the evauaton will be done without comparison.

## Parameters

TODO: Structured list of parameters, their meaning and the default values.

<!-- This should contain a structured list of all parameters and their documentation
## Guide 

1. `application_name` is a string that usually refers to the name of the service. Currently with ${ { github.ref } } is set to the branch name. However, you can change it to any desired string.
2. Read more at the inputs descriptions of the https://github.com/aiops/logsight-setup-action to correctly configure the FluentBit log collection depending on your input (e.g., docker containers, files, standard output, etc.)
3. If you already have predefined config for FluentBit you can add the following config where $variables are replaced with concrete values. This opens up the connection to logsight.ai [Read more.](../send_logs/fluentbit.md)
4. `baseline_tag` refers to the version of your repository that is already working (e.g., in production).
5. `candidate_tag` refers to the current release. 
6. Both `tags` are strings, and you can use any to tag. Often we relate tags to the commit id (${ { github.sha } }) 
```yaml
[FILTER]
    Name modify
    Match *
    Add applicationId $applicationId
    Add tag $tag
    Rename $message message
    Add basicAuthToken $basicAuthToken
[OUTPUT]
    Name http
    Host $host
    Port $port
    Format json_lines
    json_date_format iso8601"
```
4. If you wish to use log collector different than FluentBit (e.g., Filebeat). Please replace the `logsight-setup-action` with https://github.com/aiops/logsight-init-action. The difference is that the `init` action does not setup FluentBit.
5. If you use different log collector than FluentBit, then the step of log collection to logsight.ai should go after the `logsight-init-action` step. In this way you ensure your logs are sent to logsight.ai. We currently support range of log collectors. [Read more.](https://docs.logsight.ai/#/./send_logs/logstash)

-->

