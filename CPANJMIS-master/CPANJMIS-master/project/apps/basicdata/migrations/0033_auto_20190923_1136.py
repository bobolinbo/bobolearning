# Generated by Django 2.2 on 2019-09-23 11:36

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('basicdata', '0032_auto_20190923_0906'),
    ]

    operations = [
        migrations.AlterField(
            model_name='department',
            name='super_department',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='basicdata.Department', verbose_name='上级部门'),
        ),
    ]
