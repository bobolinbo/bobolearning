# Generated by Django 2.2 on 2019-09-26 14:24

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('task', '0058_auto_20190923_1136'),
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
            field=models.CharField(blank=True, choices=[('601', '601'), ('602', '602'), ('603', '603'), ('604', '604'), ('605', '605'), ('606', '606'), ('607', '607'), ('608', '608'), ('609', '609'), ('610', '610'), ('611', '611'), ('612', '612'), ('613', '613'), ('614', '614'), ('621', '621'), ('622', '622'), ('623', '623'), ('624', '624'), ('625', '625'), ('626', '626')], max_length=10, verbose_name='机位'),
        ),
        migrations.CreateModel(
            name='attendance_members',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('status', models.BooleanField(default=False, help_text='用于人员确认，班前会点名等', verbose_name='状态')),
                ('confirm_time', models.DateTimeField(auto_now=True, verbose_name='确认时间')),
                ('attendance_management', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='task.attendance_management')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
