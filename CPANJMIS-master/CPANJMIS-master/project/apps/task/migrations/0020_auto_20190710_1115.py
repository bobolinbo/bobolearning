# Generated by Django 2.2 on 2019-07-10 11:15

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('task', '0019_auto_20190709_1055'),
    ]

    operations = [
        migrations.AddField(
            model_name='task',
            name='assignedTo',
            field=models.ManyToManyField(blank=True, to=settings.AUTH_USER_MODEL, verbose_name='分配给'),
        ),
        migrations.AlterField(
            model_name='task',
            name='exec_site',
            field=models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='basicdata.Site', verbose_name='执行站点'),
        ),
    ]
