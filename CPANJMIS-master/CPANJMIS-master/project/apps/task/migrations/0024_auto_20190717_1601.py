# Generated by Django 2.2 on 2019-07-17 16:01

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('task', '0023_auto_20190715_1604'),
    ]

    operations = [
        migrations.AlterField(
            model_name='task',
            name='exec_site',
            field=models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='basicdata.Site', verbose_name='执行站点'),
        ),
    ]
