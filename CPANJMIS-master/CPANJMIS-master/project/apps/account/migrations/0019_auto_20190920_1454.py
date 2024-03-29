# Generated by Django 2.2 on 2019-09-20 14:54

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('account', '0018_auto_20190911_0923'),
    ]

    operations = [
        migrations.AlterField(
            model_name='personnelprofessionalinfo',
            name='authorization',
            field=models.ManyToManyField(blank=True, limit_choices_to={'valid': True}, to='basicdata.AuthorizationClassify', verbose_name='授权列表'),
        ),
        migrations.AlterField(
            model_name='user',
            name='department',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='basicdata.Department', verbose_name='部门'),
        ),
        migrations.AlterField(
            model_name='user',
            name='password',
            field=models.CharField(blank=True, max_length=128, verbose_name='password'),
        ),
    ]
