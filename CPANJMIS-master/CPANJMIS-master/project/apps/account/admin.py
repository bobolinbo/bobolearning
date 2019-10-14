from django.contrib import admin
from .models import *
from django.contrib.auth.admin import UserAdmin,GroupAdmin
from django.utils.translation import gettext, gettext_lazy as _
from import_export import resources,fields
from import_export.admin import ImportExportModelAdmin
from import_export.widgets import ForeignKeyWidget,ManyToManyWidget
from basicdata.models import Department
from django.contrib.auth.models import Group

# Register your models here.

# class MyUserAdmin(UserAdmin):
#     fieldsets = (
#         (None, {'fields': ('username', 'password','wechat_qy_account')}),
#         (_('Permissions'), {'fields': ('is_active', 'is_staff', 'is_superuser','groups', 'user_permissions')}),
#         (_('Personal info'), {'fields': ('name','gender', 'work_number','picture','department','email','mobile','wechat_account','birthday',)}),
#         ('详细信息',{'classes': ('collapse',),'fields':('nationality','nativePlace','politicsStatus','ID_No','careerStartTime','joinCPATime','graduateSchool','education','major','address')}),
#         (_('Important dates'), {'classes': ('collapse',),'fields': ('last_login', 'date_joined')}),
#     )
#     list_display = ('username','name','work_number','wechat_qy_account','is_superuser','is_staff','is_active')
# admin.site.register(User, MyUserAdmin)

@admin.register(GroupDetail)
class GroupDetailAdmin(admin.ModelAdmin):
    list_display = ('link_to_group','category','notes')
@admin.register(PersonnelProfessionalInfo)
class PersonnelProfessionalInfoAdmin(admin.ModelAdmin):
    list_display = ('user','authorizationList')
    filter_horizontal = ('authorization',)
    raw_id_fields = ("user",)
    search_fields = ['user__name']

    def authorizationList(self, obj):
        return " ".join([i.name for i in obj.authorization.all()])
    authorizationList.short_description = "授权列表 "  # 对salt_minion_id这个做个简短的title。


class UserResource(resources.ModelResource):
    department = fields.Field(
        column_name='department',
        attribute='department',
        widget=ForeignKeyWidget(Department, 'name')
    )

    class Meta:
        model = User
        fields = ('id','username','name','work_number','picture','department','mobile','wechat_account','wechat_qy_account','gender','nationality',
                  'nativePlace','politicsStatus','ID_No','graduateSchool','education','major','address')

class UserAdmin(ImportExportModelAdmin,UserAdmin):
    list_display_links = ('name',)
    fieldsets = (
        (None, {'fields': ('username', 'password','wechat_qy_account')}),
        (_('Permissions'), {'fields': ('is_active', 'is_staff', 'is_superuser','groups', 'user_permissions')}),
        (_('Personal info'), {'fields': ('name','gender', 'work_number','picture','department','email','mobile','wechat_account','birthday',)}),
        ('详细信息',{'classes': ('collapse',),'fields':('nationality','nativePlace','politicsStatus','ID_No','careerStartTime','joinCPATime','graduateSchool','education','major','address')}),
        (_('Important dates'), {'classes': ('collapse',),'fields': ('last_login', 'date_joined')}),
    )
    list_display = ('id','username','name','work_number','wechat_qy_account','is_superuser','is_staff','is_active')
    search_fields = ['username','name','work_number','mobile','wechat_account']
    resource_class = UserResource

admin.site.register(User,UserAdmin)