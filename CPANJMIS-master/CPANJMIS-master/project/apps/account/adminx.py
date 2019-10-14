# users/adminx.py

import xadmin
from django.contrib.auth.admin import UserAdmin
from .models import User,GroupDetail
from django.utils.translation import gettext, gettext_lazy as _

#xadmin中这里是继承object，不再是继承admin
class MyUserAdmin(UserAdmin):
    fieldsets = (
        (None, {'fields': ('username', 'password','wechat_qy_account')}),
        (_('Permissions'), {'fields': ('is_active', 'is_staff', 'is_superuser','groups', 'user_permissions')}),
        (_('Personal info'), {'fields': ('name','gender', 'work_number','picture','email','mobile','wechat_account','birthday',)}),
        ('详细信息',{'classes': ('collapse',),'fields':('nationality','nativePlace','politicsStatus','ID_No','careerStartTime','joinCPATime','graduateSchool','education','major','address')}),
        (_('Important dates'), {'classes': ('collapse',),'fields': ('last_login', 'date_joined')}),
    )
    list_display = ('username','name','work_number','wechat_qy_account','is_superuser','is_staff','is_active')
# xadmin.site.register(User, MyUserAdmin)
#
# class GroupDetailAdmin(object):
#     list_display = ('link_to_group','category','notes')
# xadmin.site.register(GroupDetail,GroupDetailAdmin)