# Generated by Django 2.1.7 on 2019-03-01 11:01

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('account', '0005_auto_20190226_1700'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='user',
            options={'verbose_name': '用户', 'verbose_name_plural': '用户'},
        ),
        migrations.RenameField(
            model_name='user',
            old_name='idCardNo',
            new_name='ID_No',
        ),
    ]