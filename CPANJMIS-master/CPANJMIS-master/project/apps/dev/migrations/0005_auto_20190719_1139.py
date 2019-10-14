# Generated by Django 2.2 on 2019-07-19 11:39

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('dev', '0004_logdata_action'),
    ]

    operations = [
        migrations.AlterField(
            model_name='logdata',
            name='action',
            field=models.CharField(choices=[('创建', 'create'), ('删除', 'delete'), ('修改', 'modify'), ('其他', 'others')], max_length=10, verbose_name='操作'),
        ),
    ]