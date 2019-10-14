from django.db import models
from pygments.lexers import get_all_lexers
from pygments.styles import get_all_styles
from account.models import User
import cpa.cpa_init as cpa_init
LEXERS = [item for item in get_all_lexers() if item[1]]
LANGUAGE_CHOICES = sorted([(item[1][0], item[0]) for item in LEXERS])
STYLE_CHOICES = sorted((item, item) for item in get_all_styles())

from pygments.lexers import get_lexer_by_name
from pygments.formatters.html import HtmlFormatter
from pygments import highlight

class LogData(models.Model):
    operater = models.ForeignKey(User,verbose_name='操作者',on_delete=models.CASCADE)
    model = models.CharField(verbose_name="涉及Model",blank=False,max_length=30,help_text="以实际数据表名称为准")
    action = models.CharField(verbose_name="操作",blank=False,max_length=10,choices=cpa_init.LogAction)
    content = models.TextField(verbose_name="内容")
    time = models.DateTimeField(verbose_name="时间",auto_now_add=True)
    termInfo = models.TextField(verbose_name="终端信息")

    class Meta:
        verbose_name = "操作日志"
        verbose_name_plural = "操作日志"


# Create your models here.
class Snippet(models.Model):
    created = models.DateTimeField(auto_now_add=True)
    title = models.CharField(max_length=100, blank=True, default='')
    code = models.TextField()
    linenos = models.BooleanField(default=False)
    language = models.CharField(choices=LANGUAGE_CHOICES, default='python', max_length=100)
    style = models.CharField(choices=STYLE_CHOICES, default='friendly', max_length=100)
    owner = models.ForeignKey(User, related_name='snippets', on_delete=models.CASCADE)
    highlighted = models.TextField()

    def save(self, *args, **kwargs):
        """
        使用`pygments`库创建一个高亮显示的HTML表示代码段。
        """
        lexer = get_lexer_by_name(self.language)
        linenos = self.linenos and 'table' or False
        options = self.title and {'title': self.title} or {}
        formatter = HtmlFormatter(style=self.style, linenos=linenos,
                                  full=True, **options)
        self.highlighted = highlight(self.code, lexer, formatter)
        super(Snippet, self).save(*args, **kwargs)

    class Meta:
        ordering = ('created',)
