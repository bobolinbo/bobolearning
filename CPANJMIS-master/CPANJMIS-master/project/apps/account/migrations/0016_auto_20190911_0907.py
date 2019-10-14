# Generated by Django 2.2 on 2019-09-11 09:07

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('account', '0015_auto_20190911_0856'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='department',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='basicdata.Department', verbose_name='部门'),
        ),
        migrations.AlterField(
            model_name='user',
            name='wechat_qy_account',
            field=models.CharField(blank=True, help_text='请输入您绑定的企业微信账号', max_length=30, null=True, unique=True, verbose_name='微信企业号账号'),
        ),
    ]
