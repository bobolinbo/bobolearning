from django.db import models
from account.models import User
from cpa import cpa_init
# Create your models here.
class RatingSystem(models.Model):
    rater = models.ForeignKey(User,verbose_name="评分人",on_delete=models.PROTECT,blank=False,related_name="RatingSys_rater")
    ratee = models.ForeignKey(User,verbose_name="受评人",on_delete=models.PROTECT,blank=False,related_name="RatingSys_ratee")
    type = models.CharField("类型",max_length=20,blank=False,choices=cpa_init.RatingSystemType)
    score = models.IntegerField("分数",blank=False,null=False)
    content = models.TextField("内容",blank=True,help_text="此处为Json格式，请勿手动填写")
    createTime = models.DateTimeField(verbose_name="创建时间", auto_now_add=True)
    lockTag = models.BooleanField(verbose_name="锁定标志",default=False,help_text="True为锁定生效，False为未锁定还可修改")

    class Meta:
        verbose_name = "评分"
        verbose_name_plural = "评分"