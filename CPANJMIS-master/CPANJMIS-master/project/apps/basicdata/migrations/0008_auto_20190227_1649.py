# Generated by Django 2.1.7 on 2019-02-27 16:49

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('basicdata', '0007_auto_20190227_1511'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='aircraftbasicdata',
            options={'verbose_name': '飞机信息', 'verbose_name_plural': '飞机信息'},
        ),
        migrations.AlterField(
            model_name='atachatper',
            name='section',
            field=models.CharField(help_text='例如：12-15-01-603-001，请填写15-01-603-001', max_length=20, verbose_name='节'),
        ),
    ]
