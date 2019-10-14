from django.db import models

# Create your models here.

class AircraftType(models.Model):
    name = models.CharField(verbose_name='型号',max_length=20,blank=False,unique=True)    #unique设为True时，在整个数据表内该字段的数据不可重复
    valid = models.BooleanField(verbose_name='是否有效',blank=False,default=False)
    notes = models.TextField(verbose_name='备注',blank=True,null=False)
    # creation_time = models.DateTimeField(verbose_name='创建时间',auto_now_add=True)
    # last_modification_time = models.DateTimeField(verbose_name='最后修改时间',auto_now=True)

    def __str__(self):
        return u'%s' % (self.name)

    class Meta:
        verbose_name = "机型"
        verbose_name_plural = "机型"


class Site(models.Model):
    name = models.CharField(verbose_name='地名',max_length=20,blank=False,unique=True)
    valid = models.BooleanField(verbose_name='是否有效', blank=False, default=False)

    def __str__(self):
        return u'%s' % (self.name)

    class Meta:
        verbose_name = "站点"
        verbose_name_plural = "站点"


class AircraftBasicData(models.Model):
    aircraft_number = models.CharField(verbose_name='飞机注册号',max_length=10,blank=False,unique=True,help_text="请直接填写四位注册号，不需要填写B或者B-")
    type = models.ForeignKey('AircraftType',verbose_name='机型',on_delete=models.CASCADE,blank=False,limit_choices_to={'valid':True})
    valid = models.BooleanField(verbose_name='是否有效', blank=False, default=False)
    notes = models.TextField(verbose_name='备注',blank=True,null=False)

    def __str__(self):
        return u'B-%s' % (self.aircraft_number)

    class Meta:
        verbose_name = "飞机信息"
        verbose_name_plural = "飞机信息"

class ATAChatper(models.Model):
    # aircraft_type = models.ForeignKey('AircraftType',verbose_name='机型',on_delete=models.CASCADE,blank=False,limit_choices_to={'valid':True})
    chapter = models.CharField(verbose_name='章',max_length=3,blank=False,help_text="例如：31-24-03，请填写34")
    section = models.CharField(verbose_name='节',max_length=20,blank=True,null=True,help_text="例如：12-15-01，请填写15")
    subject_cn = models.CharField(verbose_name='主题/中文',max_length=50,blank=False)
    subject_en = models.CharField(verbose_name='主题/英文',max_length=100,blank=True,null=True)
    valid = models.BooleanField(verbose_name='是否有效', blank=False, default=False)
    notes = models.TextField(verbose_name='备注',blank=True,null=True)

    def __str__(self):
        return u'%s-%s(%s)' % (self.chapter,self.section,self.subject_cn)

    class Meta:
        verbose_name = "ATA章节"
        verbose_name_plural = "ATA章节"

class jobcard(models.Model):
    jobcard_number = models.CharField(verbose_name='工卡号',max_length=20,blank=False,help_text="例如：37M3124508-1")
    version = models.IntegerField(verbose_name='版本号',blank=False,help_text="例如：版本为R5，此处填写'5'")
    title_cn = models.CharField(verbose_name='主题/中文',max_length=100,blank=False)
    title_en = models.CharField(verbose_name='主题/英文',max_length=200,blank=False)
    hour = models.DecimalField(verbose_name="系统工时", max_digits=5, decimal_places=2, blank=True, null=True,help_text="e.g. 123.45 小数点后不超过2位，整体不超过5位")
    valid = models.BooleanField(verbose_name='是否有效', blank=False, default=False)
    notes = models.TextField(verbose_name='备注', blank=True)

    def __str__(self):
        return u'[%sR%s]%s' % (self.jobcard_number,self.version,self.title_cn)

    class Meta:
        verbose_name = "工卡"
        verbose_name_plural = "工卡"

class Department(models.Model):
    name = models.CharField(verbose_name="部门名称",max_length=20)
    super_department = models.ForeignKey('self',verbose_name='上级部门',blank=True,null=True,on_delete=models.CASCADE)
    valid = models.BooleanField(verbose_name='是否有效', blank=False, default=True)
    class Meta:
        verbose_name = "部门"
        verbose_name_plural = "部门"
    def __str__(self):
        return u'%s' % (self.name) if self.super_department == None else u'%s/%s' % (self.super_department,self.name)

class AuthorizationClassify(models.Model):
    name = models.CharField(verbose_name="名称",max_length=20)
    aircraft_type = models.ForeignKey('AircraftType',verbose_name='机型',on_delete=models.CASCADE,blank=True,null=True,limit_choices_to={'valid':True},help_text="非机型相关授权可不选择机型")
    notes = models.TextField(verbose_name="备注",blank=True)
    valid = models.BooleanField(verbose_name='是否有效', blank=False, default=True)
    class Meta:
        verbose_name = "授权分类"
        verbose_name_plural = "授权分类"
    def __str__(self):
        return u'%s' % (self.name+'('+self.aircraft_type.name+')')

class Course(models.Model):
    name = models.CharField(verbose_name="名称",max_length=20)
    period_validity = models.DurationField(verbose_name="有效期", blank=True, null=True)
    valid = models.BooleanField(verbose_name='是否有效', blank=False, default=True)
    class Meta:
        verbose_name = "课程"
        verbose_name_plural = "课程"