# Send logs using the SDK

> [!TIP]
> Documentation of the Python SDK be found at [logsight-sdk-py.readthedocs.io](https://logsight-sdk-py.readthedocs.io/en/latest/)

Collect logs directly from any Python code, including Flask, Django, Dash. 

Installation
-------

Install the logsight-sdk-py client library from PyPI:

```bash
pip install logsight-sdk-py
```

Example
-------

Our SDK contains a class LogsightLogger to be used with the default Python logger.
It's very easy to start sending logs from your Python app to `logsight.ai`.

Once the logger is registered, you can start logging by using the debug, info, warning,
error or critical methods.

All of these methods expect a string message and they allow adding additional dictionary 
passed as an extra:


```python
import sys
import time
import logging

from logsight.logger import LogsightLogger
from logsight.

handler = LogsightLogger('xteitdidb0xd32thtt35ccruy', 
                         'devops@acme.com', 
                         'HTTP Server')

logger = logging.getLogger(__name__)
logger.addHandler(handler)

logger.info('Hello Info!')
logger.warning('Hello Warning', extra={'item': {'price': 100.00}})
```

The snippet above will send the following JSON rows to `logsight.ai`:

```json
{
  "timestamp": "2021-03-29T11:24:21.788451Z",
  "level": "info",
  "message": "Hello Info!"
}
```
