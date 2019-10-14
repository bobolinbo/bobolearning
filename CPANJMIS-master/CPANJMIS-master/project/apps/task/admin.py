from django.contrib import admin,messages
from .models import *
from basicdata.models import Site,AircraftBasicData,AircraftType,jobcard
from account.models import User
from guardian.admin import GuardedModelAdmin
from guardian.shortcuts import get_objects_for_user, assign_perm, remove_perm, get_users_with_perms, get_groups_with_perms,get_perms
import datetime
from import_export import resources,fields
from import_export.admin import ImportExportModelAdmin
from import_export.widgets import ForeignKeyWidget,ManyToManyWidget
from django.forms.models import model_to_dict
from .func import matchingTask
from cpa import cpa_init
# Register your models here.


class taskResource(resources.ModelResource):
    exec_site = fields.Field(
        column_name='exec_site',    # excel里的行title
        attribute='exec_site',      # model里的字段名称
        widget=ForeignKeyWidget(Site, 'name'))
    aircraft = fields.Field(
        column_name='aircraft',
        attribute='aircraft',
        widget=ForeignKeyWidget(AircraftBasicData, 'aircraft_number'))
    creator = fields.Field(
        column_name='creator',
        attribute='creator',
        widget=ForeignKeyWidget(User, 'name'))
    package = fields.Field(
        column_name='package',
        attribute='belong_to_package',
        widget=ForeignKeyWidget(task_package,'name')
    )

    class Meta:
        model = task
        report_skipped = False
        fields = ('id','source','type','title','description','package','link_to_standard_library__jobcard__jobcard_number','aircraft__aircraft_number','exec_date','exec_site__name','aircraft','hour','man','exec_site','creator','position')

@admin.register(task)
class taskAdmin(ImportExportModelAdmin):
    list_display = ('position','source','type','has_jobcard','ATAChapter','title','aircraft','link_to_standard_library','hour','exec_date','exec_site','status','completedStatus','belong_to_package')
    date_hierarchy = 'creation_time'
    raw_id_fields = ("jobcard", "ATAChapter", "link_to_standard_library")
    list_editable = ('position','link_to_standard_library', 'belong_to_package','hour')
    list_display_links = ('title',)
    search_fields = ('title','leader__name','ATAChapter__chapter','ATAChapter__subject_cn')
    filter_horizontal = ('assignedTo',)  # 竖款样式为filter_vertical
    ordering = ('position',)
    fieldsets = (
        (None, {
            'fields': ('source', 'type', 'title','description','belong_to_package','link_to_standard_library','aircraft','exec_date','exec_site','status','leader','assignedTo','finish_status')
        }),
        ('非标准任务', {
            'classes': ('collapse',),
            'fields': ('ATAChapter','jobcard', 'hour','man'),
        }),
    )
    actions = ['matchingTask_Action','closeTask_Action','activeTask_Action']
    resource_class = taskResource
    def completedStatus(self,obj):
        fb = task_feedback.objects.filter(task=obj).filter(user=obj.leader)
        if fb.count()==0:
            return "-"
        elif fb.count()==1 and fb[0].status=='已完成':
            return "<font color='#FF0000'>已完成</font>"
        elif fb.count()==1 and fb[0].status=='未完成':
            return "未完成"
        else:
            return "错误"
    completedStatus.short_description = '反馈状态'

    def has_jobcard(self,obj):
        if obj.jobcard:
            return True
        return False
    has_jobcard.short_description = '关联工卡'

    def matchingTask_Action(modeladmin, request, queryset):
        for obj in queryset:
            similarity, id = matchingTask(obj)
            obj.link_to_standard_library = task_standard_library.objects.get(id=id) if similarity>cpa_init.matching_degree else None
            obj.save()
    matchingTask_Action.short_description = "匹配任务"

    def closeTask_Action(self, request, queryset):
        queryset.update(status='关闭')
        for obj in queryset:
            task_feedback.objects.filter(task=obj).update(lock=True)

    closeTask_Action.short_description = "关闭任务"

    def activeTask_Action(self, request, queryset):
        queryset.update(status='生效')
    activeTask_Action.short_description = "生效任务"

    def save_model(self, request, obj, form, change):
        obj.creator = request.user
        obj.editor = request.user
        obj.save()

    # app是否在主页面中显示的话由该函数决定
    def has_module_permission(self, request):
        if super().has_module_permission(request):
            return True
        return self.get_model_objs(request).exists()

    # 在显示数据列表页时候，哪些数据显示，哪些不显示，由get_queryset函数控制
    def get_queryset(self, request):
        data = self.get_model_objs(request)
        if request.user.is_superuser:
            return super().get_queryset(request)
        elif self.has_perm(request,None,'view not_closed'):
            return data.exclude(status='关闭')
        elif self.has_perm(request, None, 'view') or self.has_perm(request, None, 'delete') or self.has_perm(request, None, 'change'):
            return data  # 普通用户不显示已关闭任务;超级管理员不影响。
        else:
            return data.none()

    # 内部用来获取某个用户有权限访问的数据行
    def get_model_objs(self, request, action=None, klass=None):
        opts = self.opts
        actions = [action] if action else ['view', 'change', 'delete']
        klass = klass if klass else opts.model
        model_name = klass._meta.model_name
        return get_objects_for_user(user=request.user, perms=[f'{perm}_{model_name}' for perm in actions],klass = klass, any_perm = True)

    # 用来判断某个用户是否有某个数据行的权限
    def has_perm(self, request, obj, action):
        opts = self.opts
        codename = f'{action}_{opts.model_name}'
        if obj:
            return request.user.has_perm(f'{opts.app_label}.{codename}', obj)
        else:
            return self.get_model_objs(request, action).exists()

    # # 是否有查看某个数据行的权限
    # def has_view_permission(self, request, obj=None):
    #     return self.has_perm(request, obj, 'view')

    # 是否有修改某个数据行的权限
    # def has_change_permission(self, request, obj=None):
    #     return self.has_perm(request, obj, 'change')
    def has_change_permission(self, request, obj=None):
        if self.opts.auto_created:
            # Same comment as has_add_permission().
            return self._has_any_perms_for_target_model(request, ['change'])
        return super().has_change_permission(request)

    # # 是否有删除某个数据行的权限
    # def has_delete_permission(self, request, obj=None):
    #     return self.has_perm(request, obj, 'delete')

# # 用户应该拥有他新增的数据行的所有权限
#     def save_model(self, request, obj, form, change):
#         obj.creator = request.user
#         obj.editor = request.user
#         obj.save()
#         result = super().save_model(request, obj, form, change)
#
#         if not request.user.is_superuser and not change:
#             opts = self.opts
#             actions = ['view', 'add', 'change', 'delete']
#             [assign_perm(f'{opts.app_label}.{action}_{opts.model_name}', request.user, obj) for action in actions]
#         return result


# class taskAdmin(GuardedModelAdmin):
#     list_display = ('source','type',has_jobcard,'ATAChapter','title','aircraft','link_to_standard_library','hour','man','exec_date','exec_site','status','belong_to_package','leader')
#     date_hierarchy = 'creation_time'
#     raw_id_fields = ("jobcard","ATAChapter","link_to_standard_library")
#     list_editable = ('link_to_standard_library','hour','man','belong_to_package')
#     list_display_links = ('title',)
#     actions = ['action_active_task']
#
#     def action_active_task(self, request, queryset):
#         # queryset.update(status='生效')
#         # obj.status = '生效' for obj in queryset if obj.status == '未生效'
#         active = 0
#         unactive = 0
#         for obj in queryset:
#             if obj.status == '未生效':
#                 obj.status = '生效'
#                 obj.save()
#                 active += 1
#             else:
#                 unactive += 1
#         if unactive > 0:
#             msg = str(unactive)+"条任务状态不处于'未生效'，请检查。"+str(active)+"条任务生效成功"
#         else:
#             msg = str(active)+"条任务生效成功"
#         self.message_user(request,msg)
#     action_active_task.short_description = "生效所选的 任务"
#
#
#     # app是否在主页面中显示的话由该函数决定(如果有系统级module查看权限，则返回true；否则查询是否有objs级model权限，有则返回true)
#     def has_module_permission(self, request):
#         if super().has_module_permission(request):
#             return True
#         return self.get_model_objs(request).exists()
#
#     # 在显示数据列表额时候，哪些数据显示，哪些不显示，由该函数控制
#     def get_queryset(self, request):
#         if request.user.is_superuser:
#             return super().get_queryset(request)
#         data = self.get_model_objs(request)
#         return data
#
#     # 内部用来获取某个用户有权限访问的数据行
#     def get_model_objs(self, request, action=None, klass=None):
#         opts = self.opts
#         actions = [action] if action else ['view', 'change', 'delete']
#         klass = klass if klass else opts.model
#         model_name = klass._meta.model_name
#         return get_objects_for_user(user=request.user, perms=[f'{perm}_{model_name}' for perm in actions],klass=klass, any_perm=True)
#
#     # 用来判断某个用户是否有某个数据行的权限
#     def has_perm(self, request, obj, action):
#         opts = self.opts
#         codename = f'{action}_{opts.model_name}'
#         if obj:
#             return request.user.has_perm(f'{opts.app_label}.{codename}', obj)
#         else:
#             return self.get_model_objs(request, action).exists()
#
#     # 是否有查看某个数据行的权限
#     def has_view_permission(self, request, obj=None):
#         return self.has_perm(request, obj, 'view')
#
#     # 是否有修改某个数据行的权限
#     def has_change_permission(self, request, obj=None):
#         return self.has_perm(request, obj, 'change')
#
#     # 是否有删除某个数据行的权限
#     def has_delete_permission(self, request, obj=None):
#         return self.has_perm(request, obj, 'delete')
#
#     # 用户应该拥有他新增的数据行的所有权限
#     def save_model(self, request, obj, form, change):
#         if change:
#             obj.editor = request.user
#         else:
#             obj.creator = request.user
#             obj.editor = request.user
#             #此处增加一个django-guardian权限管理
#             # assign_perm()
#         result = super().save_model(request, obj, form, change)
#         if not request.user.is_superuser and not change:
#             opts = self.opts
#             actions = ['view', 'add', 'change', 'delete']
#             [assign_perm(f'{opts.app_label}.{action}_{opts.model_name}', request.user, obj) for action in actions]
#         return result
#
#     def delete_model(self, request, obj):# 重写后，增加权限表删除权限数据
#         userlist = get_users_with_perms(obj)
#         grouplist = get_groups_with_perms(obj)
#         opts = self.opts
#         actions = ['view', 'add', 'change', 'delete']
#         for user in userlist:
#             [remove_perm(f'{opts.app_label}.{action}_{opts.model_name}', user, obj) for action in actions]
#         for group in grouplist:
#             [remove_perm(f'{opts.app_label}.{action}_{opts.model_name}', group, obj) for action in actions]
#         obj.delete()
#
#     def delete_queryset(self, request, queryset):# 重写后，增加批量权限表删除权限数据
#         for obj in queryset:
#             userlist = get_users_with_perms(obj)
#             grouplist = get_groups_with_perms(obj)
#             opts = self.opts
#             actions = ['view', 'add', 'change', 'delete']
#             for user in userlist:
#                 [remove_perm(f'{opts.app_label}.{action}_{opts.model_name}', user, obj) for action in actions]
#             for group in grouplist:
#                 [remove_perm(f'{opts.app_label}.{action}_{opts.model_name}', group, obj) for action in actions]
#         queryset.delete()
# admin.site.register(task,taskAdmin)

class task_packageAdmin(admin.ModelAdmin):
    list_display = ('name','status','creator','creation_time','editor','edit_time')
    # filter_horizontal = ('include_task',) #竖款样式为filter_vertical

    def save_model(self, request, obj, form, change):
        if change:
            obj.editor = request.user
        else:
            obj.creator = request.user
            obj.editor = request.user
        obj.save()

admin.site.register(task_package,task_packageAdmin)

class task_feedbackAdmin(admin.ModelAdmin):
    list_display = ('task','user','time','status','force','notes','verify_result','lock')
    actions = ['action_task_feedback_verify_pass','action_task_feedback_verify_notpass']

    def action_task_feedback_verify_pass(modeladmin, request, queryset):
        queryset.update(verify_result=True,verifier=request.user,verify_time=datetime.datetime.now(),lock=True)
    action_task_feedback_verify_pass.short_description = "审核通过"

    def action_task_feedback_verify_notpass(modeladmin, request, queryset):
        queryset.update(verify_result=False,verifier=request.user,verify_time=datetime.datetime.now())
    action_task_feedback_verify_notpass.short_description = "审核未通过"

    def save_model(self, request, obj, form, change):
        obj.user = request.user
        obj.save()
admin.site.register(task_feedback,task_feedbackAdmin)

class task_standard_libraryResource(resources.ModelResource):
    creator = fields.Field(
        column_name='creator',
        attribute='creator',
        widget=ForeignKeyWidget(User, 'name')
    )
    aircraft_type = fields.Field(
        column_name='aircraft_type',
        attribute='aircraft_type',
        widget=ManyToManyWidget(AircraftType,' ','name')
    )
    jobcard = fields.Field(
        column_name='jobcard',
        attribute='jobcard',
        widget=ForeignKeyWidget(jobcard,'jobcard_number')
    )
    class Meta:
        model = task_standard_library
        fields = ('id','task_type','aircraft_type','jobcard','title','hour','man','matching_keywords','creator','status')
class task_standard_libraryAdmin(ImportExportModelAdmin):
    list_display = ('task_type','aircraftTypeList','title','jobcard','ATAChapter','hour','man','status',)
    list_display_links = ('title',)
    search_fields = ('title','jobcard__jobcard_number')
    resource_class = task_standard_libraryResource

    def aircraftTypeList(self,obj):
        typeList = []
        for typeObj in obj.aircraft_type.all():
            typeList.append(typeObj.name)
        return ",".join(typeList)
    aircraftTypeList.short_description = '适用机型'
admin.site.register(task_standard_library,task_standard_libraryAdmin)


@admin.register(attendance_management)
class attendance_managementAdmin(admin.ModelAdmin):
    list_display = ('date','department','members_numbers','valid')
    # filter_horizontal = ('members',)  # 竖款样式为filter_vertical
    def members_numbers(self,obj):
        return obj.members.count()
    members_numbers.short_description = '人员数量'

    def save_model(self, request, obj, form, change):
        if change: # 更改
            obj_original = self.model.objects.get(pk=obj.pk)
            if obj_original.valid == False and obj.valid == True and attendance_management.objects.filter(department=obj.department,valid=True).count() > 0:
                obj.valid = False
                self.message_user(request, "%s 已存在一个有效排班，请取消其有效状态后再设置本条有效状态为True（每个部门只能拥有不超过1条有效性为True的排班）." % obj.department.name,level=messages.ERROR)
        else: # 新增
            if obj.valid == True and attendance_management.objects.filter(department=obj.department,valid=True).count()>0:
                obj.valid = False
                self.message_user(request,"%s 已存在一个有效排班，请取消其有效状态后再设置本条有效状态为True（每个部门只能拥有不超过1条有效性为True的排班）." % obj.department.name,level=messages.ERROR)
        obj.save()

@admin.register(attendance_members)
class attendance_membersAdmin(admin.ModelAdmin):
    list_display = ('attendance_management','user','status','confirm_time')

@admin.register(shift)
class shiftAdmin(admin.ModelAdmin):
    list_display = ('leader','date')

@admin.register(shift_log)
class shiftAdmin(admin.ModelAdmin):
    list_display = ('creater','title','link_to_airplane','link_to_shift','feedback_Man','feedback_msg')