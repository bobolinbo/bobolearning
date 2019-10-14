from django.db import models
from account.models import User
import cpa.cpa_init as cpa_init
from decimal import Decimal
from django.db.models import Q
from basicdata.models import Department,AircraftBasicData
# Create your models here.

# class other_task(models.Model):
#     type = models.CharField(verbose_name="类型", max_length=10, choices=cpa_init.task_type, blank=False)
#     jobcard = models.ForeignKey("basicdata.jobcard", verbose_name="工卡", on_delete=models.PROTECT, blank=True, null=True)
#     ATAChapter = models.ForeignKey("basicdata.ATAChatper", verbose_name="ATA章节", on_delete=models.PROTECT, blank=True,null=True)

class task(models.Model):
    source = models.CharField(verbose_name="来源",max_length=10,choices=cpa_init.task_source,blank=False)
    type = models.CharField(verbose_name="类型",max_length=10,choices=cpa_init.task_type,blank=False)
    jobcard = models.ForeignKey("basicdata.jobcard",verbose_name="工卡",on_delete=models.PROTECT,blank=True,null=True)
    ATAChapter = models.ForeignKey("basicdata.ATAChatper",verbose_name="ATA章节",on_delete=models.PROTECT,blank=True,null=True)
    title = models.CharField(verbose_name="标题",max_length=100,blank=True)
    description = models.TextField(verbose_name="任务描述",blank=True,null=True)
    belong_to_package = models.ForeignKey("task_package",verbose_name="所属任务包",related_name='task',on_delete=models.SET_NULL,limit_choices_to=Q(status='未生效')|Q(status='生效'),blank=True,null=True,help_text="可选当前状态为'未生效/生效'的任务包")
    link_to_standard_library = models.ForeignKey("task_standard_library",verbose_name="匹配标准库",on_delete=models.SET_NULL,blank=True,null=True)
    aircraft = models.ForeignKey("basicdata.AircraftBasicData",verbose_name="飞机",on_delete=models.PROTECT,blank=False)
    position = models.CharField(verbose_name="机位",blank=True,max_length=10,choices=cpa_init.nanjing_airplane_position)
    hour = models.DecimalField(verbose_name="标准工时",max_digits=5,decimal_places=2,blank=True,null=True,help_text="e.g. 123.45 小数点后不超过2位，整体不超过5位")
    man = models.IntegerField(verbose_name="标准人力",blank=True,null=True)
    exec_date = models.DateField(verbose_name="预计执行日期",blank=False)
    exec_site = models.ForeignKey("basicdata.Site",verbose_name="执行站点",on_delete=models.PROTECT,blank=False)
    status = models.CharField(verbose_name="状态",choices=cpa_init.task_status,blank=False,max_length=10,default="未生效",help_text="反映任务状态：未生效/生效/关闭")
    leader = models.ForeignKey(User,verbose_name="负责人",on_delete=models.PROTECT,blank=True,null=True,related_name="task_leader",limit_choices_to={'attendance_management__department__name':'维修分部','attendance_management__valid':True},help_text="此处被限定为只能选择考勤模块中当前有效的维修分部排班人员")
    assignedTo = models.ManyToManyField(User,verbose_name="分配给",blank=True,limit_choices_to={'attendance_management__department__name':'维修分部','attendance_management__valid':True},help_text="此处被限定为只能选择考勤模块中当前有效的维修分部排班人员")
    finish_status = models.CharField(verbose_name="完成状态",choices=cpa_init.task_finish_status,max_length=10,blank=True,help_text="该项由MCC确认")
    creator = models.ForeignKey(User, verbose_name="创建人", on_delete=models.PROTECT, editable=False,related_name="task_creator")
    creation_time = models.DateTimeField(verbose_name="创建时间", auto_now_add=True)
    editor = models.ForeignKey(User, verbose_name="最后编辑人", on_delete=models.PROTECT, editable=False,blank=True,null=True,related_name="task_editor")
    edit_time = models.DateTimeField(verbose_name="最后编辑时间", auto_now=True)
    verifier = models.ForeignKey(User, verbose_name="审核人", on_delete=models.PROTECT, blank=True,null=True,editable=False,related_name="task_verifier")
    verify_time = models.DateTimeField(verbose_name="审核时间", blank=True, null=True)
    who_close = models.ForeignKey(User, verbose_name="关闭人", on_delete=models.PROTECT, blank=True,null=True,editable=False,related_name="task_who_close")
    status_close_time  = models.DateTimeField(verbose_name="关闭时间", blank=True, null=True)

    def __str__(self):
        return u'%s' % (self.title)

    class Meta:
        verbose_name = "任务"
        verbose_name_plural = "任务"
        permissions = (("activate_tasks","可以生效 task"),("close_tasks","可以关闭 task"),('view not_closed_task',"Can views not closed Task"),)


class task_feedback(models.Model):
    task = models.ForeignKey("task",verbose_name="任务",on_delete=models.CASCADE,help_text="可选当前状态为'生效'的任务")
    user = models.ForeignKey(User,verbose_name="反馈人",on_delete=models.PROTECT,editable=False,related_name="task_feedback_user")
    time = models.DateTimeField(verbose_name="反馈时间",auto_now_add=True)
    status = models.CharField(verbose_name="反馈任务状态",max_length=10,choices=cpa_init.task_feedback_status,blank=False)
    role = models.CharField(verbose_name="角色",max_length=10,choices=cpa_init.task_feedback_role,blank=False)
    force = models.DecimalField(verbose_name="应获取工时系数",default=0,blank=False,max_digits=4,decimal_places=2,help_text="全程参与，请选择1.0；半程参与请选择0.5")
    notes = models.TextField(verbose_name="反馈信息",blank=True,help_text="非正常情况，请填写需反馈信息")
    self_score = models.IntegerField(verbose_name="本人评分",default=0,blank=False,help_text="请在1-10分之间打分")
    # needverify = models.BooleanField(verbose_name="是否需要审核",blank=False,help_text="该值由系统自动判断，不应由人填写")

    verifier = models.ForeignKey(User, verbose_name="审核人", blank=True, null=True, on_delete=models.PROTECT,related_name="task_feedback_verifier")
    verify_result = models.NullBooleanField(verbose_name="审核结果",choices=((True,"通过"),(False,"拒绝")),blank=True,null=True)
    verify_time = models.DateTimeField(verbose_name="审核时间", blank=True, null=True)
    lock = models.BooleanField(verbose_name="是否锁定",blank=False,default=False,help_text="状态为True后，不再可修改，一般来讲，审核后，状态置为True")

    def __str__(self):
        return u'[%s][%s][%s]' % (self.task,self.user,self.status)

    class Meta:
        verbose_name = "任务反馈"
        verbose_name_plural = "任务反馈"


class task_package(models.Model):
    name = models.CharField(verbose_name="名称",max_length=50,blank=False,help_text="")
    status = models.CharField(verbose_name="状态", choices=cpa_init.task_package_status, max_length=10,blank=False, default="未生效",help_text="只有状态为'生效'的任务包，才能被工作者看到")
    # include_task = models.ManyToManyField("task",verbose_name="包含任务",blank=True,limit_choices_to=models.Q(status = '未生效') | models.Q(status = '生效' ),help_text="状态为'关闭'的任务，无法加入工作包。")
    creator = models.ForeignKey(User,verbose_name="创建人",on_delete=models.PROTECT,editable=False,related_name="task_package_creator")
    creation_time = models.DateTimeField(verbose_name="创建时间",auto_now_add=True)
    editor = models.ForeignKey(User,verbose_name="编辑人",on_delete=models.PROTECT,editable=False,related_name="task_package_editor")
    edit_time = models.DateTimeField(verbose_name="最后编辑时间",auto_now=True)
    verifier = models.ForeignKey(User,verbose_name="审核人", blank=True,null=True,editable=False,on_delete=models.PROTECT,related_name="task_package_verifier")
    verify_time = models.DateTimeField(verbose_name="审核时间",blank=True,editable=False,null=True)

    def __str__(self):
        return u'%s' % (self.name)

    class Meta:
        verbose_name = "任务包"
        verbose_name_plural = "任务包"

class task_standard_library(models.Model):
    task_type = models.CharField(verbose_name="类型", max_length=10, choices=cpa_init.task_standard_type, blank=False)
    aircraft_type = models.ManyToManyField('basicdata.AircraftType', verbose_name='机型', blank=False,limit_choices_to={'valid': True},help_text="可选有效性为true的飞机")
    jobcard = models.ForeignKey("basicdata.jobcard", verbose_name="关联工卡", on_delete=models.PROTECT, blank=True, null=True)
    ATAChapter = models.ForeignKey("basicdata.ATAChatper", verbose_name="关联ATA章节", on_delete=models.PROTECT, blank=True,null=True)
    title = models.CharField(verbose_name="标题", max_length=50, blank=True)
    description = models.TextField(verbose_name="任务描述", blank=True,help_text="请把所需工具（必需/按需），所需耗材（必需/按需），风险点，备注内容填写于此")
    hour = models.DecimalField(verbose_name="标准工时", max_digits=5, decimal_places=2, blank=True,help_text="e.g. 123.45 小数点后不超过2位，整体不超过5位")
    man = models.IntegerField(verbose_name="标准人力", blank=True)
    status = models.CharField(verbose_name="状态", choices=cpa_init.task_standard_library_status, blank=False, max_length=10,default="未生效", help_text="反映可用状态：未生效/生效/失效")
    matching_keywords = models.CharField(verbose_name="匹配关键词",blank=True,max_length=100,null=True,help_text="可填写多个关键词，以空格隔离，模糊匹配时，任务会优先匹配至匹配度高的标准任务")
    creator = models.ForeignKey(User, verbose_name="创建人", on_delete=models.PROTECT, related_name="task_standard_creator")
    creation_time = models.DateTimeField(verbose_name="创建时间", auto_now_add=True)
    editor = models.ForeignKey(User, verbose_name="最后编辑人", on_delete=models.PROTECT, related_name="task_standard_editor",blank=True,null=True)
    edit_time = models.DateTimeField(verbose_name="最后编辑时间", auto_now=True)
    verifier = models.ForeignKey(User, verbose_name="审核人", on_delete=models.PROTECT, blank=True, null=True,related_name="task_standard_verifier")
    verify_time = models.DateTimeField(verbose_name="审核时间", blank=True, null=True)

    def __str__(self):
        return u'[%s]%s' % (self.task_type,self.title)
    class Meta:
        verbose_name = "任务标准库"
        verbose_name_plural = "任务标准库"

class attendance_management(models.Model): #考勤管理
    date = models.DateField(verbose_name="日期")
    department = models.ForeignKey(Department,verbose_name="部门",on_delete=models.PROTECT)
    # members = models.ManyToManyField(User,verbose_name="人员",related_name="attendanceManagement",related_query_name="attendance_management")
    members = models.ManyToManyField(User,verbose_name="人员",related_name="attendanceManagement",related_query_name="attendance_management",through="attendance_members")
    valid = models.BooleanField(verbose_name='是否有效', blank=False, default=False,help_text="维修分部不能超过1条为True的排班")

    def __str__(self):
        return u'%s[%s]排班' % (self.department.name,self.date)
    class Meta:
        verbose_name = "考勤管理"
        verbose_name_plural = "考勤管理"
class attendance_members(models.Model): # attendance_management的members字段ManyToMany表
    attendance_management = models.ForeignKey(attendance_management,on_delete=models.CASCADE)
    user = models.ForeignKey(User,on_delete=models.CASCADE)
    status = models.BooleanField('状态',default=False,blank=False,help_text="用于人员确认，班前会点名等")
    confirm_time = models.DateTimeField('确认时间',auto_now=True,blank=True)

# 排班model
class shift(models.Model):
    leader = models.ForeignKey(User,verbose_name="带班人员",blank=False,on_delete=models.CASCADE)
    date = models.DateField("日期",blank=False)
    link_to_attendance = models.ManyToManyField(attendance_management,blank=True)
    link_to_task_package = models.ManyToManyField(task_package,blank=True)
    airplaneList = models.ManyToManyField(AircraftBasicData)

class shift_log(models.Model):
    creater = models.ForeignKey(User,verbose_name="创建人",blank=False,on_delete=models.CASCADE,related_name='creater')
    title = models.CharField("标题",blank=False,max_length=100)
    link_to_airplane = models.ForeignKey(AircraftBasicData,blank=True,on_delete=models.CASCADE)
    link_to_shift = models.ForeignKey(shift,blank=False,on_delete=models.CASCADE)
    description = models.TextField("描述",blank=True)
    feedback_Man = models.ForeignKey(User,verbose_name="反馈人" ,blank=True,on_delete=models.CASCADE,related_name='feedback_man')
    feedback_msg = models.CharField("反馈信息",max_length=100)

