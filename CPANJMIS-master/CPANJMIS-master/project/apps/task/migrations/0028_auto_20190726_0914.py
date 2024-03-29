# Generated by Django 2.2 on 2019-07-26 09:14

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('task', '0027_auto_20190722_0938'),
    ]

    operations = [
        migrations.AlterField(
            model_name='task',
            name='editor',
            field=models.ForeignKey(blank=True, editable=False, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='task_editor', to=settings.AUTH_USER_MODEL, verbose_name='最后编辑人'),
        ),
        migrations.AlterField(
            model_name='task',
            name='exec_site',
            field=models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='basicdata.Site', verbose_name='执行站点'),
        ),
    ]
