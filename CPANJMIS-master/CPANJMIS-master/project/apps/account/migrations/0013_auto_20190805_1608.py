# Generated by Django 2.2 on 2019-08-05 16:08

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('basicdata', '0022_auto_20190805_1608'),
        ('account', '0012_auto_20190805_1604'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='department',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='basicdata.Department', verbose_name='部门'),
        ),
        migrations.CreateModel(
            name='PersonnelProfessionalInfo',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('authorization', models.ManyToManyField(blank=True, null=True, to='basicdata.AuthorizationClassify', verbose_name='授权列表')),
                ('course_list', models.ManyToManyField(blank=True, null=True, to='basicdata.Course', verbose_name='课程列表')),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
