# coding:utf-8
from django.shortcuts import render,redirect
from django.http import HttpResponse,JsonResponse
# from django.contrib.auth.models import User
from account.models import User
from django.contrib import auth
from rest_framework.views import APIView
from rest_framework.response import Response
import cpa.cpa_init
import urllib.request
from django.contrib.auth.decorators import login_required
import json

from .models import Snippet,LogData
from .serializers import SnippetSerializer,UserSerializer
from rest_framework import generics,permissions,renderers,viewsets
from .permissions import IsOwnerOrReadOnly
from rest_framework.decorators import api_view,action
from rest_framework.reverse import reverse

# Create your views here.

@login_required
def index(request):
    return HttpResponse(u"欢迎开启CPA2019项目")

def login(request):
    url = "https://open.work.weixin.qq.com/wwopen/sso/qrConnect?appid="+cpa.cpa_init.qy_weixin_CorpID+"&agentid="+str(1000023)+"&redirect_uri="+cpa.cpa_init.http_head+cpa.cpa_init.domain+"/login_process"
    return redirect(url)

#使用管理组的开发者凭据获得access_token
def access_token():
    url = 'https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid='+cpa.cpa_init.qy_weixin_CorpID+'&corpsecret='+cpa.cpa_init.qy_weixin_Secret
    response = urllib.request.urlopen(url)
    text = response.read()
    text = eval(text)                   #str转换为dict
    access_token = text['access_token']
    return access_token

##################################################################################################################################
#req：传入参数，带有CODE和STATE（参考：http://qydev.weixin.qq.com/wiki/index.php?title=%E4%BC%81%E4%B8%9A%E8%8E%B7%E5%8F%96code）
#返回一个UserId，该请求微信号在企业号中的账号
##################################################################################################################################
def OAuth(req):
    CODE = req.GET.get('code')
    # state = req.GET.get('state')
    ACCESS_TOKEN = access_token()
    url = 'https://qyapi.weixin.qq.com/cgi-bin/user/getuserinfo?access_token='+ACCESS_TOKEN+'&code='+CODE
    response = urllib.request.urlopen(url)
    text = response.read()
    text = eval(text)                   #str转换为dict
    return text['UserId']

####################################################################################################################################################
#req：传入参数，带有CODE和STATE（参考：http://qydev.weixin.qq.com/wiki/index.php?title=%E4%BC%81%E4%B8%9A%E8%8E%B7%E5%8F%96code）
#返回参数，正确，说明该传入参数为内部微信用户发出的请求，并且指定返回一个公共权限账号cookie，让微信浏览器保存登录，同时返回True，否则返回False
####################################################################################################################################################
def wechat_logined(req):
    wechat_qy_ID = OAuth(req)
    # reDirect = req.GET.get('redirect')
    data = {
        "code": 0,
        "msg": "",
        "data": {
            "access_token": ""
        }
    }
    try:
        YourAccount = User.objects.get(wechat_qy_account = wechat_qy_ID)
    except User.DoesNotExist:
        data["code"] = -1
        data["msg"] = "不存在此用户"
        return JsonResponse(data)
    else:
        user = YourAccount
        user.backend='django.contrib.auth.backends.ModelBackend'
        auth.login(req, user)
        data["data"]["access_token"] = str(req.session.session_key)[:10]
        # return JsonResponse(data)
        # return redirect('/static/s/layuiAdmin/start/index.html#'+reDirect)
        if req.GET.get('r'):
            return redirect(req.GET.get('r'))
        else:
            return redirect('/admin')


class TestView(APIView):  # CBV模式的视图函数
    def get(self, request, *args, **kwargs):
        # 定义get方法
        # 在django-rest-framework中的request被重新封装了，后续分析源码的时候会有具体体现
        return Response('测试api')  # rest-framework的模板对数据进行渲染
    def post(self, request, *args, **kwargs):
        # 定义get方法
        # 在django-rest-framework中的request被重新封装了，后续分析源码的时候会有具体体现
        return Response('post啦')  # rest-framework的模板对数据进行渲染
    def put(self, request, *args, **kwargs):
        # 定义get方法
        # 在django-rest-framework中的request被重新封装了，后续分析源码的时候会有具体体现
        return Response('put啦')  # rest-framework的模板对数据进行渲染
    def delete(self, request, *args, **kwargs):
        # 定义get方法
        # 在django-rest-framework中的request被重新封装了，后续分析源码的时候会有具体体现
        return Response('挖槽，删库跑路～')  # rest-framework的模板对数据进行渲染

# class SnippetList(generics.ListCreateAPIView):
#     queryset = Snippet.objects.all()
#     serializer_class = SnippetSerializer
#     permission_classes = (permissions.IsAuthenticatedOrReadOnly,) #必需登录后才有create的权限
#     def perform_create(self, serializer):
#         serializer.save(owner=self.request.user)
#
# class SnippetDetail(generics.RetrieveUpdateDestroyAPIView):
#     queryset = Snippet.objects.all()
#     serializer_class = SnippetSerializer
#     permission_classes = (permissions.IsAuthenticatedOrReadOnly,IsOwnerOrReadOnly)

class UserList(generics.ListAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer


class UserDetail(generics.RetrieveAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer

@api_view(['GET'])
def api_root(request, format=None):
    return Response({
        'users': reverse('user-list', request=request, format=format),
        'snippets': reverse('snippet-list', request=request, format=format)
    })

# class SnippetHighlight(generics.GenericAPIView):
#     queryset = Snippet.objects.all()
#     renderer_classes = (renderers.StaticHTMLRenderer,)
#
#     def get(self, request, *args, **kwargs):
#         snippet = self.get_object()
#         return Response(snippet.highlighted)
#
# class UserViewSet(viewsets.ReadOnlyModelViewSet):
#     """
#     此视图自动提供`list`和`detail`操作。
#     """
#     queryset = User.objects.all()
#     serializer_class = UserSerializer

#
# class SnippetViewSet(viewsets.ModelViewSet):
#     """
#     此视图自动提供`list`，`create`，`retrieve`，`update`和`destroy`操作。
#
#     另外我们还提供了一个额外的`highlight`操作。
#     """
#     queryset = Snippet.objects.all()
#     serializer_class = SnippetSerializer
#     permission_classes = (permissions.IsAuthenticatedOrReadOnly,IsOwnerOrReadOnly,)
#
#     # @action 装饰器可用于添加不符合标准create/update/delete样式的任何自定义路径
#     @action(detail=True,renderer_classes=[renderers.StaticHTMLRenderer])
#     def highlight(self, request, *args, **kwargs):
#         snippet = self.get_object()
#         return Response(snippet.highlighted)
#
#     def perform_create(self, serializer):
#         serializer.save(owner=self.request.user)