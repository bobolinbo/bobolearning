# Generated by Django 2.2 on 2019-08-05 16:49

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('account', '0013_auto_20190805_1608'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='personnelprofessionalinfo',
            options={'verbose_name': '个人专业信息', 'verbose_name_plural': '个人专业信息'},
        ),
        migrations.AlterField(
            model_name='personnelprofessionalinfo',
            name='authorization',
            field=models.ManyToManyField(blank=True, to='basicdata.AuthorizationClassify', verbose_name='授权列表'),
        ),
        migrations.AlterField(
            model_name='personnelprofessionalinfo',
            name='course_list',
            field=models.ManyToManyField(blank=True, to='basicdata.Course', verbose_name='课程列表'),
        ),
        migrations.AlterField(
            model_name='user',
            name='department',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='basicdata.Department', verbose_name='部门'),
        ),
    ]