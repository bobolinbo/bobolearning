# Generated by Django 2.2 on 2019-07-09 10:50

from decimal import Decimal
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('task', '0017_auto_20190703_1518'),
    ]

    operations = [
        migrations.AlterField(
            model_name='task',
            name='exec_site',
            field=models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='basicdata.Site', verbose_name='执行站点'),
        ),
        migrations.AlterField(
            model_name='task',
            name='type',
            field=models.CharField(choices=[('工卡', '工卡'), ('排故', '排故'), ('勤务', '勤务'), ('其他', '其他')], max_length=10, verbose_name='类型'),
        ),
        migrations.AlterField(
            model_name='task_feedback',
            name='force',
            field=models.DecimalField(choices=[(Decimal('0.0'), 0.0), (Decimal('0.1'), 0.1), (Decimal('0.2'), 0.2), (Decimal('0.3'), 0.3), (Decimal('0.4'), 0.4), (Decimal('0.5'), 0.5), (Decimal('0.6'), 0.6), (Decimal('0.7'), 0.7), (Decimal('0.8'), 0.8), (Decimal('0.9'), 0.9), (Decimal('1.0'), 1.0)], decimal_places=1, default=0.0, help_text='全程参与，请选择1.0；半程参与请选择0.5', max_digits=4, verbose_name='应获取工时系数'),
        ),
        migrations.AlterField(
            model_name='task_standard_library',
            name='task_type',
            field=models.CharField(choices=[('工卡', '工卡'), ('AMM', 'AMM'), ('勤务', '勤务'), ('其他', '其他')], max_length=10, verbose_name='类型'),
        ),
    ]
