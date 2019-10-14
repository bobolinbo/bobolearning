from django.contrib.auth.models import User, Group
from .models import task_package,task,task_feedback
from rest_framework import serializers


class TaskPackageSerializer(serializers.HyperlinkedModelSerializer):
    include_task = serializers.StringRelatedField(many=True)
    class Meta:
        model = task_package
        fields = ('id','name', 'status','include_task')
        depth = 10

class TaskListSerializer(serializers.ModelSerializer):
    aircraft_number = serializers.CharField(source='aircraft.aircraft_number')
    class Meta:
        model = task
        # aircraft_number = serializers.CharField()
        fields = ('id','type','jobcard','ATAChapter','title','description','link_to_standard_library','aircraft_number')
        # depth = 1

class TaskSerializer(serializers.ModelSerializer):
    aircraft_number = serializers.CharField(source='aircraft.aircraft_number')
    class Meta:
        model = task
        # aircraft_number = serializers.CharField()
        fields = ('id','type','jobcard','ATAChapter','title','description','link_to_standard_library','aircraft_number')
        depth = 1

class TaskFeedbackSerializer(serializers.ModelSerializer):
    class Meta:
        model = task_feedback
        fields = ('task','user','time','status','force','notes','needverify','verifier','verify_result','verify_time')

    # type = serializers.CharField(required=True, allow_blank=False,max_length=10)
    # title =  serializers.CharField(required=True,allow_blank=False,max_length=50)
    # description = serializers.CharField(required=True,allow_blank=True,max_length=500)
    #
    # def create(self, validated_data):
    #     """
    #     根据提供的验证过的数据创建并返回一个新的`task`实例。
    #     """
    #     return task.objects.create(**validated_data)
    #
    # def update(self, instance, validated_data):
    #     """
    #     根据提供的验证过的数据更新和返回一个已经存在的`Snippet`实例。
    #     """
    #     instance.type = validated_data.get('type', instance.type)
    #     instance.title = validated_data.get('title', instance.title)
    #     instance.description = validated_data.get('description', instance.description)
    #
    #     instance.save()
    #     return instance