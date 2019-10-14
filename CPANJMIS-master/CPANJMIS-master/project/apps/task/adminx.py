# basicdata/adminx.py

import xadmin
from .models import *
from guardian.admin import GuardedModelAdminMixin
from guardian.shortcuts import get_objects_for_user, assign_perm, remove_perm, get_users_with_perms, get_groups_with_perms,get_perms

#xadmin中这里是继承object，不再是继承admin
def has_jobcard(obj):
    if obj.jobcard:
        return True
    return False
has_jobcard.short_description = '关联工卡'

class GuardedModelAdmin(GuardedModelAdminMixin, object):
    """
    Extends ``django.contrib.admin.ModelAdmin`` class. Provides some extra
    views for object permissions management at admin panel. It also changes
    default ``change_form_template`` option to
    ``'admin/guardian/model/change_form.html'`` which is required for proper
    url (object permissions related) being shown at the model pages.

    **Extra options**

    ``GuardedModelAdmin.obj_perms_manage_template``

        *Default*: ``admin/guardian/model/obj_perms_manage.html``

    ``GuardedModelAdmin.obj_perms_manage_user_template``

        *Default*: ``admin/guardian/model/obj_perms_manage_user.html``

    ``GuardedModelAdmin.obj_perms_manage_group_template``

        *Default*: ``admin/guardian/model/obj_perms_manage_group.html``

    ``GuardedModelAdmin.user_can_access_owned_objects_only``

        *Default*: ``False``

        If this would be set to ``True``, ``request.user`` would be used to
        filter out objects he or she doesn't own (checking ``user`` field
        of used model - field name may be overridden by
        ``user_owned_objects_field`` option).

        .. note::
           Please remember that this will **NOT** affect superusers!
           Admins would still see all items.

    ``GuardedModelAdmin.user_can_access_owned_by_group_objects_only``

        *Default*: ``False``

        If this would be set to ``True``, ``request.user`` would be used to
        filter out objects her or his group doesn't own (checking if any group
        user belongs to is set as ``group`` field of the object; name of the
        field can be changed by overriding ``group_owned_objects_field``).

        .. note::
           Please remember that this will **NOT** affect superusers!
           Admins would still see all items.

    ``GuardedModelAdmin.group_owned_objects_field``

        *Default*: ``group``

    ``GuardedModelAdmin.include_object_permissions_urls``

        *Default*: ``True``

        .. versionadded:: 1.2

        Might be set to ``False`` in order **NOT** to include guardian-specific
        urls.

    **Usage example**

    Just use :admin:`GuardedModelAdmin` instead of
    ``django.contrib.admin.ModelAdmin``.

    .. code-block:: python

        from django.contrib import admin
        from guardian.admin import GuardedModelAdmin
        from myapp.models import Author

        class AuthorAdmin(GuardedModelAdmin):
            pass

        admin.site.register(Author, AuthorAdmin)

    """

class taskAdmin(GuardedModelAdmin):
    list_display = ('type',has_jobcard,'ATAChapter','title','aircraft','link_to_standard_library','hour','man','exec_date','exec_site','status','creator','creation_time','editor','edit_time')
    date_hierarchy = 'creation_time'
    raw_id_fields = ("jobcard","ATAChapter","link_to_standard_library")
    list_editable = ('link_to_standard_library','hour','man')
    actions = ['action_active_task']

    def action_active_task(self, request, queryset):
        # queryset.update(status='生效')
        # obj.status = '生效' for obj in queryset if obj.status == '未生效'
        active = 0
        unactive = 0
        for obj in queryset:
            if obj.status == '未生效':
                obj.status = '生效'
                obj.save()
                active += 1
            else:
                unactive += 1
        if unactive > 0:
            msg = str(unactive)+"条任务状态不处于'未生效'，请检查。"+str(active)+"条任务生效成功"
        else:
            msg = str(active)+"条任务生效成功"
        self.message_user(request,msg)
    action_active_task.short_description = "生效所选的 任务"


    # app是否在主页面中显示的话由该函数决定(如果有系统级module查看权限，则返回true；否则查询是否有objs级model权限，有则返回true)
    def has_module_permission(self, request):
        if super().has_module_permission(request):
            return True
        return self.get_model_objs(request).exists()

    # 在显示数据列表额时候，哪些数据显示，哪些不显示，由该函数控制
    def get_queryset(self, request):
        if request.user.is_superuser:
            return super().get_queryset(request)
        data = self.get_model_objs(request)
        return data

    # 内部用来获取某个用户有权限访问的数据行
    def get_model_objs(self, request, action=None, klass=None):
        opts = self.opts
        actions = [action] if action else ['view', 'change', 'delete']
        klass = klass if klass else opts.model
        model_name = klass._meta.model_name
        return get_objects_for_user(user=request.user, perms=[f'{perm}_{model_name}' for perm in actions],klass=klass, any_perm=True)

    # 用来判断某个用户是否有某个数据行的权限
    def has_perm(self, request, obj, action):
        opts = self.opts
        codename = f'{action}_{opts.model_name}'
        if obj:
            return request.user.has_perm(f'{opts.app_label}.{codename}', obj)
        else:
            return self.get_model_objs(request, action).exists()

    # 是否有查看某个数据行的权限
    def has_view_permission(self, request, obj=None):
        return self.has_perm(request, obj, 'view')

    # 是否有修改某个数据行的权限
    def has_change_permission(self, request, obj=None):
        return self.has_perm(request, obj, 'change')

    # 是否有删除某个数据行的权限
    def has_delete_permission(self, request, obj=None):
        return self.has_perm(request, obj, 'delete')

    # 用户应该拥有他新增的数据行的所有权限
    def save_model(self, request, obj, form, change):
        if change:
            obj.editor = request.user
        else:
            obj.creator = request.user
            obj.editor = request.user
            #此处增加一个django-guardian权限管理
            # assign_perm()
        result = super().save_model(request, obj, form, change)
        if not request.user.is_superuser and not change:
            opts = self.opts
            actions = ['view', 'add', 'change', 'delete']
            [assign_perm(f'{opts.app_label}.{action}_{opts.model_name}', request.user, obj) for action in actions]
        return result

    def delete_model(self, request, obj):# 重写后，增加权限表删除权限数据
        userlist = get_users_with_perms(obj)
        grouplist = get_groups_with_perms(obj)
        opts = self.opts
        actions = ['view', 'add', 'change', 'delete']
        for user in userlist:
            [remove_perm(f'{opts.app_label}.{action}_{opts.model_name}', user, obj) for action in actions]
        for group in grouplist:
            [remove_perm(f'{opts.app_label}.{action}_{opts.model_name}', group, obj) for action in actions]
        obj.delete()

    def delete_queryset(self, request, queryset):# 重写后，增加批量权限表删除权限数据
        for obj in queryset:
            userlist = get_users_with_perms(obj)
            grouplist = get_groups_with_perms(obj)
            opts = self.opts
            actions = ['view', 'add', 'change', 'delete']
            for user in userlist:
                [remove_perm(f'{opts.app_label}.{action}_{opts.model_name}', user, obj) for action in actions]
            for group in grouplist:
                [remove_perm(f'{opts.app_label}.{action}_{opts.model_name}', group, obj) for action in actions]
        queryset.delete()

xadmin.site.register(task,taskAdmin)

class task_packageAdmin(object):
    list_display = ('name','status','creator','creation_time','editor','edit_time')
    filter_horizontal = ('include_task',) #竖款样式为filter_vertical

    def save_model(self, request, obj, form, change):
        if change:
            obj.editor = request.user
        else:
            obj.creator = request.user
            obj.editor = request.user
        obj.save()

xadmin.site.register(task_package,task_packageAdmin)

class task_feedbackAdmin(object):
    list_display = ('task','user','time','status','needverify','verify_result')
xadmin.site.register(task_feedback,task_feedbackAdmin)

class task_standard_libraryAdmin(object):
    list_display = ('task_type','title','jobcard','ATAChapter','hour','man','status',)
    list_display_links = ('title',)
xadmin.site.register(task_standard_library,task_standard_libraryAdmin)
