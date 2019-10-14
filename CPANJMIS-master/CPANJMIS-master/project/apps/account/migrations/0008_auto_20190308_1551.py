# Generated by Django 2.1.7 on 2019-03-08 15:51

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('account', '0007_groupdetail'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='groupdetail',
            options={'verbose_name': '权限组', 'verbose_name_plural': '权限组'},
        ),
        migrations.AlterField(
            model_name='user',
            name='groups',
            field=models.ManyToManyField(blank=True, help_text='The groups this user belongs to. A user will get all permissions granted to each of their groups.', related_name='user_set', related_query_name='user', to='auth.Group', verbose_name='权限组'),
        ),
    ]