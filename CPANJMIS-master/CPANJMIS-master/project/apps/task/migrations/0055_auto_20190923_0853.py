# Generated by Django 2.2 on 2019-09-23 08:53

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('task', '0054_auto_20190920_1454'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='task',
            options={'permissions': (('activate_tasks', '可以生效 task'), ('close_tasks', '可以关闭 task'), ('disable_invalidTask', '不可见失效任务')), 'verbose_name': '任务', 'verbose_name_plural': '任务'},
        ),
        migrations.AlterField(
            model_name='attendance_management',
            name='department',
            field=models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='basicdata.Department', verbose_name='部门'),
        ),
        migrations.AlterField(
            model_name='task',
            name='exec_site',
            field=models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='basicdata.Site', verbose_name='执行站点'),
        ),
    ]
