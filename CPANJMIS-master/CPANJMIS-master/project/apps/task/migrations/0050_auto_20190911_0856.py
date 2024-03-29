# Generated by Django 2.2 on 2019-09-11 08:56

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('task', '0049_auto_20190911_0844'),
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
    ]
