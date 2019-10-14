from django.contrib import admin
from .models import *
from django.contrib.auth.models import Permission
from import_export import resources
from import_export.admin import ImportExportModelAdmin
# Register your models here.
admin.site.site_header = '维修生产管理系统'
admin.site.site_title = '生产管理'
@admin.register(Course)
class CourseAdmin(admin.ModelAdmin):
    list_display = ('name','period_validity','valid')

@admin.register(AuthorizationClassify)
class AuthorizationClassifyAdmin(admin.ModelAdmin):
    list_display = ('name','aircraft_type','notes','valid')

class DepartmentAdmin(admin.ModelAdmin):
    list_display = ('id','name','super_department','valid')
admin.site.register(Department,DepartmentAdmin)

class AircraftTypeAdmin(admin.ModelAdmin):
    fields = (('name','valid'),'notes')
    list_display = ('name','valid','notes')
admin.site.register(AircraftType,AircraftTypeAdmin)

class SiteAdmin(admin.ModelAdmin):
    list_display = ('name', 'valid')
admin.site.register(Site,SiteAdmin)

class AircraftBasicDataAdmin(admin.ModelAdmin):
    list_display = ('aircraft_number','type','valid','notes')
admin.site.register(AircraftBasicData,AircraftBasicDataAdmin)

class ATAChatperResource(resources.ModelResource):
    class Meta:
        model = ATAChatper
class ATAChatperAdmin(ImportExportModelAdmin):
    list_display = ('chapter','section','subject_cn')
    search_fields = ('chapter','section','subject_cn')
admin.site.register(ATAChatper,ATAChatperAdmin)

class jobcardResource(resources.ModelResource):
    class Meta:
        model = jobcard
class jobcardAdmin(ImportExportModelAdmin):
    list_display = ('jobcard_number','version','title_cn','title_en','hour','notes')
    search_fields = ('jobcard_number','title_cn','title_en','notes')
admin.site.register(jobcard,jobcardAdmin)

admin.site.register(Permission)