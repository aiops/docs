# Verify stages using GitHub Actions


## [Hello logsight.ai from Github Actions](https://github.com/aiops/hello-logsight)

#### Steps
2. **Fork** the repository https://github.com/aiops/hello-logsight
3. Go to **Pull Requests** and click on **New pull request**
4. Set `compare` to `candidate` and **Create pull request**.
<div align=center><img src="/monitor_deployments/pullrq.png" alt="drawing" style="width:80%;"/> </div>

5. The **quality check will run**.
<div align=center><img src="/monitor_deployments/check.png" alt="drawing" style="width:80%;"/> </div>

6. If the check is failing, it will create an issue report that specifies the **deployment risk**. You can check the report in the [**Issues**](https://github.com/aiops/hello-logsight/issues).

To open the detailed online report in the issue, you need to have [logsight.ai](https://logsight.ai) user account. Login and then click on the detailed report.

## About logsight.ai GitHub Actions

The workflow uses the following GitHub Actions:
1. https://github.com/aiops/logsight-setup-action
2. https://github.com/aiops/logsight-verification-action

### Prerequisites

1. `Create and activate logsight user at https://logsight.ai`
2. Select your favourite GitHub project and add the steps from Workflow configuration into your workflow

### Workflow configuration
logsight.ai enables seamless integration with `Github Actions`.

To enable the logsight Stage Verifier as a Quality Gate into your workflow, add the following steps:
1. If you wish, we recommend setting up `LOGSIGHT_USERNAME` and `LOGSIGHT_PASSWORD` as secrets to your repository:
   1. go to `project settings -> secrets -> actions -> new repository secret`
   2. or, proceed with writing the username and passwords as strings (we don't recommend this for safety reasons)

```
- name: Logsight Setup
  uses: aiops/logsight-setup-action@main
  id: setup
  with:
    username: ${ { secrets.LOGSIGHT_USERNAME } }
    password: ${ { secrets.LOGSIGHT_PASSWORD } }
    application_name: ${ { github.ref } }
    fluentbit_filelocation: /host$GITHUB_WORKSPACE/*.log
    fluentbit_message: 'log'

- name: 🚀 STEPS FROM THE EXISTING WORKFLOW FROM YOUR APPLICATION
- name: 🚀 CONDUCT TESTS FROM YOUR OWN APPLICATION

- name: Verify Logs
  uses: aiops/logsight-verification-action@main
  id: verify-logs
  with:
    github_token: ${ { secrets.GITHUB_TOKEN } }
    username: ${ { secrets.LOGSIGHT_USERNAME } }
    password: ${ { secrets.LOGSIGHT_PASSWORD } }
    application_id: ${ { steps.setup.outputs.application_id } }
    baseline_tag: ${ { github.event.before } }
    candidate_tag: ${ { github.sha } }
    risk_threshold: 10
```

#### Important
> Important is that `logsight-setup-action` is executed **as a step prior your application generates logs** (e.g., prior testing). 
> 
> The Stage Verifier is called afterwards with the execution of the `logsight-verification-action`.
> 
> `logsight-setup-action`  accepts inputs that configure the log collection via FluentBit. Please check https://github.com/aiops/logsight-setup-action for configuration. **By default is configured to collect logs from docker container execution**.
> 
> You need execution of **at least two workflows** (logs from two different commits needs to be collected) in order to perform the Stage Verifier.
>
> You can also set the **`candidate_tag`: { { github.sha } }** --> in this way you will evaluate the deployment without comparison.

### Guide 

1. `application_name` is a string that usually refers to the name of the service. Currently with ${ { github.ref } } is set to the branch name. However, you can change it to any desired string.
2. Read more at the inputs descriptions of the https://github.com/aiops/logsight-setup-action to correctly configure the FluentBit log collection depending on your input (e.g., docker containers, files, standard output, etc.)
3. If you already have predefined config for FluentBit you can add the following config where $variables are replaced with concrete values. This opens up the connection to logsight.ai [Read more.](../send_logs/fluentbit.md)
4. `baseline_tag` refers to the version of your repository that is already working (e.g., in production).
5. `candidate_tag` refers to the current release. 
6. Both `tags` are strings, and you can use any to tag. Often we relate tags to the commit id (${ { github.sha } }) 
```yaml
[INPUT]
    Name $inputName
    Path $fileLocation
    multiline.parser  docker, cri
    DB /tail_docker.db
    Refresh_Interval 1
[SERVICE]
    Flush 1
    Daemon Off
[FILTER]
    Name modify
    Match $matchPattern
    Add applicationId $applicationId
    Add tag $tag
    Rename $message message
[OUTPUT]
    Name http
    Host $host
    Port $port
    http_User $logsightUsername
    http_Passwd $logsightPassword
    tls On
    uri /api/v1/logs/singles
    Format json
    json_date_format iso8601
    json_date_key timestamp
```
4. If you wish to use log collector different than FluentBit (e.g., Filebeat). Please replace the `logsight-setup-action` with https://github.com/aiops/logsight-init-action. The difference is that the `init` action does not setup FluentBit.
5. If you use different log collector than FluentBit, then the step of log collection to logsight.ai should go after the `logsight-init-action` step. In this way you ensure your logs are sent to logsight.ai. We currently support range of log collectors. [Read more.](https://docs.logsight.ai/#/./send_logs/logstash)

