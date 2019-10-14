# Generated by Django 2.2 on 2019-09-11 08:44

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('task', '0048_auto_20190805_1649'),
    ]

    operations = [
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
        migrations.AlterField(
            model_name='task',
            name='position',
            field=models.CharField(blank=True, choices=[('601', '601'), ('602', '602'), ('603', '603')], max_length=10, verbose_name='机位'),
        ),
        migrations.AlterField(
            model_name='task_package',
            name='status',
            field=models.CharField(choices=[('未生效', '未生效'), ('生效', '生效'), ('关闭', '关闭')], default='未生效', help_text="只有状态为'生效'的任务包，才能被工作者看到", max_length=10, verbose_name='状态'),
        ),
    ]