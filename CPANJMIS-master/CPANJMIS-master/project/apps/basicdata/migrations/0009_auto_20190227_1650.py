# Generated by Django 2.1.7 on 2019-02-27 16:50

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('basicdata', '0008_auto_20190227_1649'),
    ]

    operations = [
        migrations.AlterField(
            model_name='jobcard',
            name='version',
            field=models.IntegerField(help_text="例如：版本为R5，此处填写'5'", verbose_name='版本号'),
        ),
    ]
