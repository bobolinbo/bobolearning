from django.contrib import admin
from .models import *
# Register your models here.

@admin.register(RatingSystem)
class RatingSystemAdmin(admin.ModelAdmin):
    list_display = ('rater','ratee','type','score','content','createTime','lockTag')