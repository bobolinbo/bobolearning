from django.db import models
from django.contrib.auth.models import AbstractUser
import cpa.cpa_init
from django.contrib.auth.models import Group
from django.utils.translation import gettext_lazy as _
from basicdata.models import Department
from django.contrib.auth.models import User
# Create your models here.

class User(AbstractUser):
    first_name = None
    last_name = None
    password = models.CharField(_('password'), max_length=128,blank=True) # 特意从父类中拉出来，加上blank=True
    name = models.CharField(verbose_name='姓名',max_length=14,blank=False)
    work_number = models.CharField('工作证编号', max_length=5, blank=True, null=True, help_text="工作证卡号,五位数字组成",unique=True)
    picture = models.ImageField("照片", upload_to='static/apps/account/User/picture', blank=True, null=True)
    department = models.ForeignKey(Department,verbose_name="部门",blank=True,null=True,on_delete=models.SET_NULL)
    mobile = models.CharField('手机号码', max_length=16, blank=True, null=True, unique=True)
    wechat_account = models.CharField('微信账号', max_length=50, blank=True, null=True, unique=True)
    wechat_qy_account = models.CharField('微信企业号账号', max_length=30, blank=True,null=True,help_text="请输入您绑定的企业微信账号",unique=True)
    birthday = models.DateField('出生日期', blank=True, null=True)
    gender = models.CharField('性别', max_length=1, choices=(('M', '男'),('F', '女'),), default='M', blank=True)
    nationality = models.CharField('民族', max_length=5, choices=cpa.cpa_init.nationality,blank=True, null=True)
    nativePlace = models.CharField('籍贯', max_length=10, choices=cpa.cpa_init.nativePlace,blank=True, null=True)
    politicsStatus = models.CharField('政治面貌', max_length=10, choices=cpa.cpa_init.politicsStatus,blank=True, null=True)
    ID_No = models.CharField('身份证号码', max_length=18, blank=True, null=True, unique=True)
    careerStartTime = models.DateField('参加工作时间', blank=True, null=True)
    joinCPATime = models.DateField('加入邮航时间', blank=True, null=True)
    graduateSchool = models.CharField('毕业院校', max_length=30, blank=True, null=True)
    education = models.CharField('最高学历', max_length=10, choices=cpa.cpa_init.education,blank=True, null=True)
    major = models.CharField('学习专业', max_length=40, blank=True, null=True)
    address = models.CharField('家庭住址', max_length=100, blank=True, null=True)
    groups = models.ManyToManyField(
        Group,
        verbose_name='权限组',
        blank=True,
        help_text=_(
            'The groups this user belongs to. A user will get all permissions '
            'granted to each of their groups.'
        ),
        related_name="user_set",
        related_query_name="user",
    )

    # familyMemberName = models.CharField('家属姓名', max_length=20, blank=True)
    # familyMemberTelephone = models.CharField('家属联系方式', max_length=20, blank=True)

    def get_full_name(self):
        """
        Return the first_name plus the last_name, with a space in between.
        """
        return self.name

    def get_short_name(self):
        """Return the short name for the user."""
        return self.name

    def __str__(self):
        return u'%s' % (self.name)

    class Meta(AbstractUser.Meta):
        verbose_name = "用户"
        verbose_name_plural = "用户"
        swappable = 'AUTH_USER_MODEL'


class GroupDetail(models.Model):
    link_to_group = models.OneToOneField(Group,verbose_name='链接至权限组',on_delete=models.CASCADE)
    category = models.CharField(verbose_name='自定义类别',blank=True,max_length=20)
    notes = models.TextField(verbose_name="说明",blank=True)

    class Meta:
        verbose_name = "权限组"
        verbose_name_plural = "权限组"

class PersonnelProfessionalInfo(models.Model):
    user = models.OneToOneField("account.User",on_delete=models.CASCADE)
    authorization = models.ManyToManyField("basicdata.AuthorizationClassify",verbose_name="授权列表",blank=True,limit_choices_to={'valid':True})
    course_list = models.ManyToManyField("basicdata.Course",verbose_name="课程列表",blank=True)

    class Meta:
        verbose_name = "个人专业信息"
        verbose_name_plural = "个人专业信息"

    def isAuthorized(self,authorization):
        if authorization in self.authorization.all():
            return True
        return False
