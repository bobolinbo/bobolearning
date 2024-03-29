from django.apps import AppConfig
import os

default_app_config = 'modules.modulesConfig'

VERBOSE_APP_NAME = u"3-独立模块"


def get_current_app_name(_file):
    return os.path.split(os.path.dirname(_file))[-1]


class modulesConfig(AppConfig):
    name = get_current_app_name(__file__)
    verbose_name = VERBOSE_APP_NAME