# Generated by Django 2.1.7 on 2019-02-26 16:13

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('account', '0003_auto_20190226_1401'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='picture',
            field=models.ImageField(blank=True, upload_to='static/apps/account/User/picture', verbose_name='照片'),
        ),
        migrations.AlterField(
            model_name='user',
            name='wechat_qy_account',
            field=models.CharField(blank=True, help_text='请输入您绑定的企业微信账号', max_length=30, verbose_name='微信企业号账号'),
        ),
    ]