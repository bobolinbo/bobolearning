# Generated by Django 2.2 on 2019-09-11 09:09

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('basicdata', '0026_auto_20190911_0907'),
    ]

    operations = [
        migrations.AlterField(
            model_name='department',
            name='super_department',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='basicdata.Department', verbose_name='上级部门'),
        ),
    ]
