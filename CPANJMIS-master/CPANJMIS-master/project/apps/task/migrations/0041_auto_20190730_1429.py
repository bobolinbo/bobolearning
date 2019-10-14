# Generated by Django 2.2 on 2019-07-30 14:29

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('task', '0040_auto_20190729_1629'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='attendance_management',
            options={'verbose_name': '考勤管理', 'verbose_name_plural': '考勤管理'},
        ),
        migrations.AlterField(
            model_name='attendance_management',
            name='members',
            field=models.ManyToManyField(related_name='attendanceManagement', related_query_name='attendance_management', to=settings.AUTH_USER_MODEL, verbose_name='人员'),
        ),
        migrations.AlterField(
            model_name='task',
            name='exec_site',
            field=models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='basicdata.Site', verbose_name='执行站点'),
        ),
        migrations.AlterField(
            model_name='task',
            name='leader',
            field=models.ForeignKey(blank=True, limit_choices_to={'attendance_management__department__name': '维修分部'}, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='task_leader', to=settings.AUTH_USER_MODEL, verbose_name='负责人'),
        ),
    ]