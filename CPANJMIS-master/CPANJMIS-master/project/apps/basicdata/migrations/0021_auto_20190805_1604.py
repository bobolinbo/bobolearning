# Generated by Django 2.2 on 2019-08-05 16:04

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('basicdata', '0020_auto_20190805_1430'),
    ]

    operations = [
        migrations.CreateModel(
            name='Course',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=20, verbose_name='名称')),
                ('period_validity', models.DurationField(blank=True, null=True, verbose_name='有效期')),
                ('valid', models.BooleanField(default=True, verbose_name='是否有效')),
            ],
        ),
        migrations.AlterField(
            model_name='authorizationclassify',
            name='aircraft_type',
            field=models.ForeignKey(blank=True, help_text='非机型相关授权可不选择机型', limit_choices_to={'valid': True}, null=True, on_delete=django.db.models.deletion.CASCADE, to='basicdata.AircraftType', verbose_name='机型'),
        ),
        migrations.AlterField(
            model_name='department',
            name='super_department',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='basicdata.Department', verbose_name='上级部门'),
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
