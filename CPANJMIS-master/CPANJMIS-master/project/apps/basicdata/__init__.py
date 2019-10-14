from django.apps import AppConfig
import os

default_app_config = 'basicdata.basicdataConfig'

VERBOSE_APP_NAME = u"2-基础数据"


def get_current_app_name(_file):
    return os.path.split(os.path.dirname(_file))[-1]


class basicdataConfig(AppConfig):
    name = get_current_app_name(__file__)
    verbose_name = VERBOSE_APP_NAME