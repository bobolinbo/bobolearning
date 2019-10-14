from .models import User
from django.contrib.auth.models import Group
from rest_framework import serializers

class UserData1_Serializer(serializers.ModelSerializer): # Quickstart 使用ModelViewSet时
    class Meta:
        model = User
        fields = ('username','name', 'work_number','is_staff')

class UserSerializer(serializers.ModelSerializer): # Quickstart 使用ModelViewSet时
    class Meta:
        model = User
        fields = ('username','name', 'work_number','is_staff')
        # fields = '__all__'
        # depth = 10
        # extra_kwargs = {'work_number': {'read_only': True}}

class GroupSerializer(serializers.ModelSerializer): # Quickstart 使用ModelViewSet时
    class Meta:
        model = Group
        fields = ('url', 'name')
