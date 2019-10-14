# Generated by Django 2.2 on 2019-09-11 08:56

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('account', '0014_auto_20190805_1649'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='ID_No',
            field=models.CharField(blank=True, max_length=18, null=True, unique=True, verbose_name='身份证号码'),
        ),
        migrations.AlterField(
            model_name='user',
            name='department',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='basicdata.Department', verbose_name='部门'),
        ),
        migrations.AlterField(
            model_name='user',
            name='mobile',
            field=models.CharField(blank=True, max_length=16, unique=True, verbose_name='手机号码'),
        ),
        migrations.AlterField(
            model_name='user',
            name='wechat_account',
            field=models.CharField(blank=True, max_length=50, unique=True, verbose_name='微信账号'),
        ),
        migrations.AlterField(
            model_name='user',
            name='wechat_qy_account',
            field=models.CharField(blank=True, help_text='请输入您绑定的企业微信账号', max_length=30, unique=True, verbose_name='微信企业号账号'),
        ),
        migrations.AlterField(
            model_name='user',
            name='work_number',
            field=models.CharField(blank=True, help_text='工作证卡号,五位数字组成', max_length=5, unique=True, verbose_name='工作证编号'),
        ),
    ]