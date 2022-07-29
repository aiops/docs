# First steps

You can either use the logsight.ai web service at [https://logsight.ai](https://logsight.ai) or your [local installation](/get_started/installation.md) of logsight.ai.

First, an account is needed. Click on **Sign-up** to create one. Provide an email address and a password in the sign-up form.

<img style="display: block; margin-left: auto; margin-right: auto;" width="500" src="/get_started/imgs/sign_up.png"/>

You will be redirected to the login form. Use the credentials from the sign-up process to **login**.

<img style="display: block; margin-left: auto; margin-right: auto;" width="500" src="/get_started/imgs/login.png"/>

Next, you will see a list of integration options. Click on the button **Demo data** to load a log data set that allows you to explore logsight.ai. After the loading process is complete, you will see a dashboard that provides an overview of the verification screen. If this is your first time using logsight.ai, a step-by-step tutorial will be activated guiding you through the main dashboard elements of logsight.ai.

The verification screen supports the continuous verification of deployments, comparing tests, detecting test flakiness 
and other log verification tasks via the task of AI-powered `log compare`. 

To create a verification and compare the two versions in order to detect incidents, select `service` -> resource_manager with `version` -> v1.0.0 as baseline tags, and  `service` -> resource_manager with `version` -> v1.1.0. 
Then, click `Create` and after few seconds an entry will be shown in the table. 

<img style="display: block; margin-left: auto; margin-right: auto;" width="1000" src="/get_started/imgs/create_verification.png"/>

You can click on `Insights` to show the exact log messages that help you debug the problem.

<img style="display: block; margin-left: auto; margin-right: auto;" width="1000" src="/get_started/imgs/insights_verification.png"/>

