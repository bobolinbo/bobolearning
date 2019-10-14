"""cpa URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path

from dev import views as dev_views

from django.conf.urls import url, include
# from django.contrib.auth.models import User
from account.models import User
from rest_framework import serializers, viewsets, routers
from rest_framework.authtoken import views as drf_views
from rest_framework.schemas import get_schema_view
from task import views as task_views
from account import views as account_views


# Routers provide a way of automatically determining the URL conf.
# router = routers.DefaultRouter() # Quickstart 使用ModelViewSet时
# router.register(r'users', account_views.UserViewSet) # Quickstart 使用ModelViewSet时
# router.register(r'groups', account_views.GroupViewSet) # Quickstart 使用ModelViewSet时
# router.register(r'snippets', dev_views.SnippetViewSet)
# router.register(r'taskPackage',task_views.TaskPackageViewSet)
# router.register(r'taskPackage',task_views.taskpackageListView)

#
# schema_view = get_schema_view(title='Pastebin API')

# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.

urlpatterns = [
    # url(r'^user/', dev_views.TestView.as_view()),
    url(r'^', include('task.urls')),
    url(r'^', include('account.urls')),
    # url('^schema/$', schema_view),
    # url(r'^', include(router.urls)), # Quickstart 使用ModelViewSet时
    # url(r'^abc', include('task.urls')),
    # url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')), # Quickstart 使用ModelViewSet时

    path('admin/', admin.site.urls),
    path('index/',dev_views.index),
    path('api-token-auth/', drf_views.obtain_auth_token),
    path('login/',dev_views.login),
    path('login_process/',dev_views.wechat_logined),
    path('user_logout/',account_views.UserLogout),
    path('LA_userinfo',account_views.LA_userinfo),
    # path('LA_access_token',account_views.LA_access_token),

    # path('task/packageList/',task_views.taskpackageList),
    # path('task/packageListView',task_views.taskpackageListView)
]
