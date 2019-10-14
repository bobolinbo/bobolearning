from django.contrib import admin
from .models import Snippet,LogData
# Register your models here.
admin.site.register(Snippet)
# admin.site.register(LogData)

class LogDataAdmin(admin.ModelAdmin):
    list_display = ('id','operater','model','action','content','termInfo','time')
admin.site.register(LogData,LogDataAdmin)