# basicdata/adminx.py

import xadmin
from .models import *

#xadmin中这里是继承object，不再是继承admin
class AircraftTypeAdmin(object):
    list_display = ['name','valid','notes']
xadmin.site.register(AircraftType,AircraftTypeAdmin)

class SiteAdmin(object):
    list_display = ['name', 'valid']
xadmin.site.register(Site,SiteAdmin)

class AircraftBasicDataAdmin(object):
    list_display = ('aircraft_number','type','notes')
xadmin.site.register(AircraftBasicData,AircraftBasicDataAdmin)

class ATAChatperAdmin(object):
    list_display = ('aircraft_type','chapter','section','subject_cn')
xadmin.site.register(ATAChatper,ATAChatperAdmin)

class jobcardAdmin(object):
    list_display = ('jobcard_number','version','title_cn','title_en','notes')
xadmin.site.register(jobcard,jobcardAdmin)