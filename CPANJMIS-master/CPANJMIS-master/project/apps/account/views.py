from django.shortcuts import render
from .models import User,PersonnelProfessionalInfo
from django.contrib.auth.models import Group
from .serializers import *
from rest_framework import serializers
from rest_framework import viewsets
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status
from rest_framework import mixins
from rest_framework import generics
from django.http import Http404
from django.contrib import auth
from django.http import HttpResponse,JsonResponse,HttpResponseRedirect
from account.vxwork.vxworkAPI import wechat_logined
from django.views.decorators.csrf import csrf_exempt
from basicdata.func import belongToDepartment
from basicdata.models import AuthorizationClassify
import time
from .vxwork.vxworkAPI import wechat_logined,wechat_URL_verify,wechat_sendmessage_text
from cpa import cpa_init
# Create your views here.
def genVERCODE(request):
    if request.user.is_authenticated:
        code = str(
            (int(str(time.time())[3:5]) + 6179823) * (int(str(time.time())[4:8]) * (int(str(time.time())[5:8]) + 29)))[
               -7:-1]
        html = '''
            <html lang="Zh-CN">
            <head>
            <meta name="viewport" content="width=width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0,minimum-scale=1.0">
            </head>
            <body><br>授权码：
            '''
        html += code
        html += "<br><br>(授权码约每1分30秒变化一次，请及时输入)</body></html>"
        return HttpResponse(html)
    elif request.GET.get('code'):
        if wechat_logined(request,request.GET.get('code')):
            return HttpResponseRedirect('/api/account/genVERCODE/')
        else:
            msg = '您的微信企业号账号尚未与系统关联,请联系南京工程技术培训分部'
            return HttpResponse(msg)
            # return render_to_response('unauthorized_warning_page.html', {'message': msg})
    else:
        return HttpResponseRedirect('https://open.weixin.qq.com/connect/oauth2/authorize?appid='+cpa_init.qy_weixin_CorpID+'&redirect_uri='+cpa_init.http_head+cpa_init.domain+'/api/account/genVERCODE/&response_type=code&scope=SCOPE&state=STATE#wechat_redirect')

@csrf_exempt
def LA_login_auth(request):
    data = {
        "code": 0,
        "msg": "未处理",
        "data": {
            # "access_token": str(request.session.session_key)[:10]
        }
    }
    # 判断是否为登录用户
    if request.user.is_authenticated:
    # if True:
        # 判断为已登录用户，那么ok，返回通过信息
        data['code']=0
        data['msg']='您已登录，正在为您进行跳转...'
        data['data']['access_token'] = str(request.session.session_key)[:10]

    # 未登录，判断是否带有vxwork参数，有的话，就进行登录
    elif request.GET.get('code'):
        # 符合登录条件，开始进行登录
        # return JsonResponse({'code':request.GET.get('code')})
        if wechat_logined(request,request.GET.get('code')):
            data['code']=0
            data['msg'] = '登录成功'
            data['data']['access_token'] = str(request.session.session_key)[:10]
            # return HttpResponseRedirect('layuiMyToolsPage')
            # return HttpResponseRedirect('http://wangboyuan.cn/static/s/layuiAdmin/start/index.html#' + request.GET.get('state'))
        else:
            data['code']=-1
            data['msg']="未绑定企业微信用户，请联系管理员"


    # 对于未带有vxwork参数的，rediUrl到vxwork链接去取参数
    else:
        u = request.GET.get('path')
        return HttpResponseRedirect('https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxe736c12ef5dc6c05&redirect_uri=/api/account/LA_login_auth/&response_type=code&scope=SCOPE&state='+u+'#wechat_redirect')
    return JsonResponse(data)

# 使用用户名和密码进行登陆
@csrf_exempt
def LA_login(request):
    data = {
        "code": 0,
        "msg": "登入成功",
        "data": {
            "access_token": str(request.session.session_key)[:10]
        }
    }
    username = request.POST.get('username')
    password = request.POST.get('password')
    vercode = request.POST.get('vercode')
    if vercode != str((int(str(time.time())[3:5])+6179823)*(int(str(time.time())[4:8])*(int(str(time.time())[5:8])+29)))[-7:-1]:
        data['code'] = -1
        data['msg'] = '验证码错误'
        data['data'] = ''
    elif not auth.authenticate(username=username,password=password):
        data['code'] = -1
        data['msg'] = '用户名或密码错误'
        data['data'] = ''
    elif auth.authenticate(username=username,password=password):
        user = User.objects.get(username=username)
        user.backend = 'django.contrib.auth.backends.ModelBackend'
        auth.login(request, user)
    return JsonResponse(data)

def LA_userinfo(request):
    data = {
        "code": 0,
        "msg": ""
    }
    if request.user.is_authenticated:
        data['msg']='用户已登录'
        data['data'] = {
            "username": request.user.name,
            "sex": request.user.gender,
            "role": 1,
            "code":0 # LayuiAdmin框架依靠这个code来判断是否登录成功，可以使用admin.exit()操作
        }
    else:
        data['msg'] = '用户未登录/登录状态已失效'
        data['data'] = {
            "code":-1 # LayuiAdmin框架依靠这个code来判断是否登录成功，可以使用admin.exit()操作
        }
    return JsonResponse(data)

def UserLogout(request):
    auth.logout(request)
    data = {  "code": 0,"msg": "退出成功","data": None}
    return JsonResponse(data)

class UserData1(APIView):
    def get(self, request, format=None):
        u = {request.user}
        serializer = UserData1_Serializer(u, many=True)
        data = {'code': 0, 'msg':'', 'data': serializer.data}
        return Response(data)

class UserList(APIView):
    """
    列出可查看的用户或者创建一个新的用户。
    """
    def get(self, request, format=None):
        user_list = {request.user}
        serializer = UserSerializer(user_list, many=True)
        data = {'code':0,'data':serializer.data}
        return Response(data)
    # def post(self, request, format=None):
    #     serializer = UserSerializer(data=request.data)
    #     if serializer.is_valid():
    #         serializer.save()
    #         return Response(serializer.data, status=status.HTTP_201_CREATED)
    #     return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class UserDetail(APIView):
    """
    检索，更新或删除一个snippet示例。
    """
    def get_object(self, pk):
        try:
            return User.objects.get(pk=pk)
        except User.DoesNotExist:
            raise Http404

    def get(self, request, pk, format=None):
        user = self.get_object(pk)
        serializer = UserSerializer(user)
        return Response(serializer.data)

    def put(self, request, pk, format=None):
        user = self.get_object(pk)
        serializer = UserSerializer(user, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, pk, format=None):
        user = self.get_object(pk)
        user.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

# 根据每个人不同的权限生成LayuiAdmin侧边栏
@csrf_exempt
def generateMenu(request):
    dataDict = {'code': 0, 'msg': '', 'data': []}
    if belongToDepartment(request.user,2) and request.GET.get('type')=='m':
        dataDict['data']=[{
          "name": "task",
          "title": "生产任务",
          "icon": "layui-icon-home",
          "list": [
            {
              "title": "任务中心",
              "jump": "CPA/task/taskpackageIndex"
            },
            {
              "title": "我的任务",
              "jump": "CPA/task/mytask"
            },
            # {
            #   "title": "已反馈任务",
            #   "jump": "CPA/task/myfeedback"
            # },
            {
              "title": "反馈记录",
              "jump": "CPA/task/feedbackRecord"
            }
          ]
        }]

        PPI = PersonnelProfessionalInfo.objects.filter(user=request.user)
        fx_auth = AuthorizationClassify.objects.filter(name__icontains='放行')
        if PPI.count() == 1:
            for j in fx_auth.all():
                if PPI[0].isAuthorized(j):  # 如果该协助人员有放行授权，返回该人员为“放行”
                    dataDict['data'][0]['list'].append({
                        "title": "人员评价",
                        "jump": "CPA/task/evaluteIndex"
                    })
                    break
    elif belongToDepartment(request.user,2) and request.GET.get('type')=='web':
        dataDict['data'] = [{
            "name": "task",
            "title": "生产任务",
            "icon": "layui-icon-home",
            "list": [
                {
                    "title": "任务分配",
                    "jump": "CPA/task/taskAssign"
                },{
                    "title": "考勤管理",
                    "jump": "CPA/task/attendanceManagement"
                }
            ]
        }]
    return JsonResponse(dataDict)