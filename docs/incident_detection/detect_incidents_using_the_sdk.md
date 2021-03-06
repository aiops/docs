# Detect incidents using the SDK

> [!TIP]
> Documentation of the Python SDK be found at [logsight-sdk-py.readthedocs.io](https://logsight-sdk-py.readthedocs.io/en/latest/)


Prerequisites
=============

-   [logsightaai](https://logsight.ai/) subscription (create one for
    free to get your private key)
-   Once you have your subscription, create an
    [application](https://demo.logsight.ai/pages/integration) named
    quick\_start\_app in the integration tab
-   You will need the [private
    key](https://demo.logsight.ai/pages/integration) to connect your
    application to the Incident Detector API
-   You'll paste your private key into the code below later

Setting up
==========

Create a directory
------------------

Create a directory to store your quick start exercise:

```bash
$ mkdir logsight_quick_start
$ cd logsight_quick_start
```

Create a virtual env
--------------------

Create apython virtual environment to decouple and isolate the packages
we will install from you environment.

```bash
$ python3 -m venv venv
$ source venv/bin/activate
```

Prepare code file
-----------------

You can start with an emptypython file:

```bash
$ touch quick_start.py
```

Alternatively, you can download thepython file directly from git:

```bash
$ curl https://raw.githubusercontent.com/aiops/logsight-sdk-py/main/docs/source/quick_start/quick_start.py --output quick_start.py
```

Download a log data file
------------------------

As a example, we will use a sample log data file from Apache Hadoop
platform:

```bash
$ curl https://raw.githubusercontent.com/aiops/logsight-sdk-py/main/docs/source/quick_start/Hadoop_2k.log --output Hadoop_2k.log
```

Install the client library
--------------------------

Install the Incident Detector client library forpython with pip:

```bash
$ pip install logsight-sdk-py
```

or directly from the sources:

```bash
$ git clone https://github.com/aiops/logsight-sdk-py.git
$ cd logsight-sdk-py
$ python setup.py install
```

Create environment variables
----------------------------

Using the private key from your subscription, create one environment
variables for authentication:

-   LOGSIGHT\_PRIVATE\_KEY - The private key for authenticating your
    requests
-   LOGSIGHT\_EMAIL - The email associated with your subscription

Copy the following text to your bash file:

```bash
$ export LOGSIGHT_PRIVATE_KEY=<replace-with-your-anomaly-detector-key>
$ export LOGSIGHT_EMAIL=<replace-with-your-email>
```

After you add the environment variable, run source \~/.bashrc from your
console window to make the changes effective.

For the impatient
-----------------

```bash
mkdir logsight_quick_start
cd logsight_quick_start
python3 -m venv venv
source venv/bin/activate
curl https://raw.githubusercontent.com/aiops/logsight-sdk-py/main/docs/source/quick_start/quick_start.py --output quick_start.py
curl https://raw.githubusercontent.com/aiops/logsight-sdk-py/main/docs/source/quick_start/Hadoop_2k.log --output Hadoop_2k.log
pip install logsight-sdk-py
unset LOGSIGHT_PRIVATE_KEY LOGSIGHT_EMAIL
export LOGSIGHT_PRIVATE_KEY='mgewxky59zm1euavowtjon9igc'
export LOGSIGHT_EMAIL='jorge.cardoso.pt@gmail.com'
python quick_start.py
```

Code example
============

The following code snippets show what can be achieved with the Logsight
SDK client library forpython:

-   Authenticate the client
-   Attach the logger
-   Send log data loaded from a file
-   Detect incident in the entire log data set
-   Show the details of the incident

Load packages
-------------

Load the various packages used in this quick start guide.

```python
import sys
import time
import logging

from logsight.logger.logger import LogsightLogger
from logsight.result.result import LogsightResult
from logsight.utils import now
```

Authenticate the client
-----------------------

To enable client authentication, set your PRIVATE\_KEY and e-mail.

```python
PRIVATE_KEY = os.getenv('LOGSIGHT_PRIVATE_KEY') or 'mgewxky59zm1euavowtjon9igc'
EMAIL = os.getenv('LOGSIGHT_EMAIL') or 'jorge.cardoso.pt@gmail.com'
```

Indicate the name of the application to which you will send log data.
For example, apache\_server, kafka, website or backend. This quick guide
sends log data to the application quick\_start\_app.

```python
APP_NAME = 'quick_start_app'
```

Attach the logger
-----------------

Add logsight.ai logging handler to your logging system:

```python 
handler = LogsightLogger(PRIVATE_KEY, EMAIL, APP_NAME)
handler.setLevel(logging.DEBUG)

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)
logger.addHandler(handler)
```

Load log data from a file
-------------------------

-   Open a file with your log data (logs file samples from several
    systems are available at [loghub](https://github.com/logpai/loghub))
-   Read all the log records from the file
-   Split log messages and remove the timestamp
-   Store log\_records with tuples of the form: (log level, log message)

```python
log_records = []
try:
    f = open('Hadoop_2k.log', 'r')

    for i, line in enumerate(f.readlines()):
        tokens = line.split()
        level_idx, msg_idx = 2, 3
        log_records.append((tokens[level_idx], ' '.join(tokens[msg_idx:])))

except OSError:
    sys.exit('Could not open/read file')
```

Send log records
----------------

-   Store a timestamp indicating when log records started to be sent
-   Iterate over the log records, extract the log level and log message
-   Send the log level and message using the logger and the appropriate
    log function
-   Once all records have been sent, flush the log handler to force
    buffered records to be sent
-   Store a timestamp indicating when the last log record was sent

```python
dt_start = now()
print('Starting log records sending', dt_start)

mapping = {'INFO': logger.info, 'WARNING': logger.warning, 'WARN': logger.warning,
           'ERROR': logger.error, 'DEBUG': logger.debug, 'CRITICAL': logger.critical,
           'FATAL': logger.critical}

for i, m in enumerate(log_records):
    level, message = m[0].upper(), m[1]
    print(i, level, message)

    if level in mapping:
        mapping[level](message)
    else:
        sys.exit('Unknown log level. Log record number %d: %s %s' % (i, level, message))

handler.flush()

dt_end = now()
print('Ended log records sending', dt_end)
```

Detect the anomaly status of the latest data point
--------------------------------------------------

-   Wait 60 seconds after sending the last log record to allow
    logsight.ai AI-driven processing to finish
-   Query logsight.ai for possible incidents

```python
sleep_time = 60
print(f'Sleeping {sleep_time} seconds')
time.sleep(sleep_time)

incidents = LogsightResult(PRIVATE_KEY, EMAIL, APP_NAME)\
    .get_results(dt_start, dt_end, 'incidents')
```

Show incidents
--------------

Iterate over the list of incidents received and print the incidents'
properties

```python
for j, i in enumerate(incidents):
    print('Incident:', j + 1, 'Score:', i.total_score, '(', i.timestamp_start, i.timestamp_end, ')')
```

Run the application
===================

Run thepython code from your quick\_start directory.

```bash
$ python quick_start.py
```

Clean up resources
==================

Delete the [application](https://demo.logsight.ai/pages/integration)
quick\_start\_app from your subscription.
