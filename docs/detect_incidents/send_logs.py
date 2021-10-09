import sys
import time
import logging

from logsight.logger import LogsightLogger


handler = LogsightLogger('xteitdidb0xd32thtt35ccruy', 'jorge.cardoso.pt@gmail.com', 'test_app')

logger = logging.getLogger(__name__)
logger.addHandler(handler)

logger.info('Hello Info!')
logger.warning('Hello Warning', extra={'item': { 'price': 100.00 }})
