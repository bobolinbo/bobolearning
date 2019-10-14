#!/usr/bin/env python
#-*- encoding:utf-8 -*-
from account.vxwork.WXBizMsgCrypt3 import WXBizMsgCrypt
from account.vxwork.WXBizMsgCrypt3 import SHA1
import xml.etree.cElementTree as ET
import sys
import time
import random
from django.template.loader import get_template
from django.template import Context
import urllib.request as urllib2
from account.models import User
from django.contrib import auth
from django.http import HttpResponse
import json


#以下定义了微信平台的几个常量,token EncodingAESKey CorpID,在更换平台的时候，修改一下常量，否则固定

TOKEN = 'vQ9LKGLITfu734h29x2dCdiNRAY'

ENCODINGAESKEY = 'QfKhRyJ1IpdcmgQjM95Cg3rGNLSX2IVK5WojIXPEEAn'

CORPID = 'wxe736c12ef5dc6c05'

corpSecret = 'CiL0l-YQbV3sgmIUc6-Z7rtaxFcsbqc160T9rx9iv5Nn45qUSDP35SniEyZDTNqQ'

############################################################################################################################
# wechat_URL_verify()是URL验证函数，新应用可以调用该函数验证URL
# req：传入参数，request，即：django.http.HttpRequest
# EchoStr：返回参数，EchoStr：解密之后的echostr，当ret为0时有效。
############################################################################################################################
def wechat_URL_verify(req):
    msg_signature = req.GET.get('msg_signature')
    timestamp = req.GET.get('timestamp')
    nonce = req.GET.get('nonce')
    echostr = req.GET.get('echostr')
    wxcpt=WXBizMsgCrypt(TOKEN, ENCODINGAESKEY, CORPID)
    ret,EchoStr = wxcpt.VerifyURL(msg_signature,timestamp,nonce,echostr)
    if(ret!=0):
      print("ERR: VerifyURL ret: " + str(ret))
      sys.exit(1)
    return EchoStr

############################################################################################################################
#wechat_receive_msg()是接收普通消息处理函数
# req：传入参数，request，即：django.http.HttpRequest
# 解密后返回一个字典，key包括ToUserName, FromUserName, CreateTime, MsgType, 等等，value为相应的接收字符串，依据不同类型消息
#       如text，image，video，voice，event等，返回不同key-value组成的字典
############################################################################################################################
def wechat_receive_msg(req):
    sReqMsgSig = req.GET['msg_signature']
    sReqTimeStamp = req.GET['timestamp']
    sReqNonce = req.GET['nonce']
    sReqData = req.body
    wxcpt=WXBizMsgCrypt(TOKEN, ENCODINGAESKEY, CORPID)
    ret,sMsg=wxcpt.DecryptMsg(sReqData, sReqMsgSig, sReqTimeStamp, sReqNonce)
    if( ret!=0 ):
        print("ERR: DecryptMsg ret: " + ret)
        sys.exit(1)
    # 解密成功，sMsg即为xml格式的明文
    xml_tree = ET.fromstring(sMsg)
    ToUserName = xml_tree.find("ToUserName").text
    FromUserName = xml_tree.find("FromUserName").text
    CreateTime = xml_tree.find("CreateTime").text
    MsgType = xml_tree.find("MsgType").text
    if   MsgType == 'text':
        Content = xml_tree.find("Content").text
        MsgId = xml_tree.find("MsgId").text
        AgentID = xml_tree.find("AgentID").text
        dict_msg = {'ToUserName': ToUserName,
                    'FromUserName': FromUserName,
                    'CreateTime': CreateTime,
                    'MsgType': MsgType,
                    'Content': Content,
                    'MsgId': MsgId,
                    'AgentID': AgentID}
        return dict_msg

    elif MsgType == 'image':
        pass
        # PicUrl = xml_tree.find("PicUrl").text
        # MediaId = xml_tree.find("MediaId").text
        # MsgId = xml_tree.find("MsgId").text
        # AgentID = xml_tree.find("AgentID").text
        # dict_msg = {'ToUserName': ToUserName,
        #             'FromUserName': FromUserName,
        #             'CreateTime': CreateTime,
        #             'MsgType': MsgType,
        #             'PicUrl': PicUrl,
        #             'MediaId': MediaId,
        #             'MsgId': MsgId,
        #             'AgentID': AgentID}
        # return dict_msg
    elif MsgType == 'voice':
        pass
    elif MsgType == 'video':
        pass
    elif MsgType == 'location':
        pass
    elif MsgType == 'event':
        AgentID = xml_tree.find("AgentID").text
        Event = xml_tree.find("Event").text
        if Event == 'click':
            EventKey = xml_tree.find('EventKey').text
            dict_msg = {'ToUserName': ToUserName,
                    'FromUserName': FromUserName,
                    'CreateTime': CreateTime,
                    'MsgType': MsgType,
                    'Event': Event,
                    'EventKey': EventKey,
                    'AgentID': AgentID}
        return dict_msg

############################################################################################################################
#wechat_reply_text_msg()是发送普通消息处理函数
############################################################################################################################
def wechat_reply_text_msg(ToUserName, FromUserName, CreateTime, MsgType, Content):
    sReqTimeStamp = str(time.time())                        #生成时间戳，且转换为字符型
    sReqNonce = str(random.randint(1000000000,9999999999))           #生成随机字符串，且转换为字符型
    xml_template = get_template('text.xml')
    sRespData = xml_template.render({'ToUserName': ToUserName, 'FromUserName':FromUserName, 'CreateTime':CreateTime, 'MsgType':MsgType, 'Content':Content})
    wxcpt=WXBizMsgCrypt(TOKEN, ENCODINGAESKEY, CORPID)
    ret,sEncryptMsg=wxcpt.EncryptMsg(sRespData, sReqNonce, sReqTimeStamp)
    if( ret!=0 ):
        print("ERR: EncryptMsg ret: " + ret)
        sys.exit(1)
    return sEncryptMsg

############################################################################################################################
#wechat_reply_text_msg()是发送图片消息处理函数，该功能还未完成！！
############################################################################################################################
def wechat_reply_image_msg(ToUserName, FromUserName, CreateTime, MsgType, PicUrl, MediaId, MsgId, AgentID):
    sReqTimeStamp = str(time.time())                        #生成时间戳，且转换为字符型
    sReqNonce = str(random.randint(1000000000,9999999999))           #生成随机字符串，且转换为字符型
    xml_template = get_template('image.xml')
    sRespData = xml_template.render(Context({'ToUserName': ToUserName, 'FromUserName':FromUserName, 'CreateTime':CreateTime, 'MsgType':MsgType, 'MediaId':MediaId}))
    wxcpt=WXBizMsgCrypt(TOKEN, ENCODINGAESKEY, CORPID)
    ret,sEncryptMsg=wxcpt.EncryptMsg(sRespData, sReqNonce, sReqTimeStamp)
    if( ret!=0 ):
        print("ERR: EncryptMsg ret: " + ret)
        sys.exit(1)
    return sEncryptMsg


############################################################################################################################
#wechat_reply_news_msg()是发送多图文列表处理函数
############################################################################################################################
def wechat_reply_news_msg(ToUserName, FromUserName, CreateTime, MsgType,ArticleCount, Title=[], Description=[], PicUrl=[], Url=[]):
    sReqTimeStamp = str(time.time())                        #生成时间戳，且转换为字符型
    sReqNonce = str(random.randint(1000000000,9999999999))           #生成随机字符串，且转换为字符型
    xml_template = get_template('news.xml')
    count = []
    if ArticleCount>9:
        ArticleCount = 9
    for num in range(ArticleCount):
        count.append(num)
    sRespData = xml_template.render(Context({'ToUserName': ToUserName, 'FromUserName': FromUserName, 'CreateTime': CreateTime, 'MsgType': MsgType, 'ArticleCount': ArticleCount, 'count': count, 'Title': Title, 'Description': Description, 'PicUrl': PicUrl, 'Url': Url}))
    wxcpt=WXBizMsgCrypt(TOKEN, ENCODINGAESKEY, CORPID)
    ret,sEncryptMsg=wxcpt.EncryptMsg(sRespData, sReqNonce, sReqTimeStamp)
    if( ret!=0 ):
        print("ERR: EncryptMsg ret: " + ret)
        sys.exit(1)
    return sEncryptMsg


def wechat_sendmessage_text(touser="",toparty="",totag="",msgtype="text",agentid="1000023",content="",safe="0"):
    accessToken = access_token()
    url = 'https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token='+accessToken
    data = {
        "touser": touser,
        "toparty": toparty,
        "totag": totag,
        "msgtype": msgtype,
        "agentid": str(agentid),
        "text": {
        "content": content
                },
        "safe":safe
    }
    #解决json不支持中文，ensure_ascii=False
    body = json.dumps(data,ensure_ascii=False)
    body = body.encode('utf-8')
    req = urllib2.Request(url = url,data = body)
    res_data = urllib2.urlopen(req)
    response = res_data.read()
    return response

def wechat_send_textcard(touser="",toparty="",totag="",msgtype="textcard",agentid="0",title="",description="",url="",btntxt=""):
    accessToken = access_token()
    url2 = 'https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token='+accessToken
    data = {
        "touser": touser,
        "toparty": toparty,
        "totag": totag,
        "msgtype": msgtype,
        "agentid": str(agentid),
        "textcard": {
            'title':title,
            'description':description,
            'url':url,
            'btntxt':btntxt
        },
    }
    #解决json不支持中文，ensure_ascii=False
    body = json.dumps(data,ensure_ascii=False)
    body = body.encode('utf-8')
    req = urllib2.Request(url = url2,data = body)
    res_data = urllib2.urlopen(req)
    response = res_data.read()
    return response

def wechat_sendmessage_news(touser="",toparty="",totag="",msgtype="news",agentid=0,articles=[],safe=0):
    accessToken = access_token()
    url = 'https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token='+accessToken
    data = {
        "touser": touser,
        "toparty": toparty,
        "totag": totag,
        "msgtype": msgtype,
        "agentid": agentid,
        "news":{
            "articles":articles
        },
        "safe":safe
    }
    #解决json不支持中文，ensure_ascii=False
    body = json.dumps(data,ensure_ascii=False)
    req = urllib2.Request(url = url,data = body)
    res_data = urllib2.urlopen(req)
    response = res_data.read()
    return response

#使用管理组的开发者凭据获得access_token
def access_token():
    url = 'https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid='+CORPID+'&corpsecret='+corpSecret
    response = urllib2.urlopen(url)
    text = response.read()
    text = eval(text)                   #str转换为dict
    access_token = text['access_token']
    return access_token

##################################################################################################################################
#req：传入参数，带有CODE和STATE（参考：http://qydev.weixin.qq.com/wiki/index.php?title=%E4%BC%81%E4%B8%9A%E8%8E%B7%E5%8F%96code）
#返回一个UserId，该请求微信号在企业号中的账号
##################################################################################################################################
def OAuth(code):
    CODE = code
    # state = req.GET.get('state')
    ACCESS_TOKEN = access_token()
    url = 'https://qyapi.weixin.qq.com/cgi-bin/user/getuserinfo?access_token='+ACCESS_TOKEN+'&code='+CODE
    url2 ='https://qyapi.weixin.qq.com/cgi-bin/user/getuserinfo?access_token=t0p18OpuQlu0d10DQy0mIE23PupY3rwILbtqmCI5CsDz0X_MoRDQ5ZGRFEqG5fQh&code=15e80c60ec225d1bed78ccbea96a99df'
    response = urllib2.urlopen(url)
    text = response.read()
    text = eval(text)                   #str转换为dict
    return text['UserId']

####################################################################################################################################################
#req：传入参数，带有CODE和STATE（参考：http://qydev.weixin.qq.com/wiki/index.php?title=%E4%BC%81%E4%B8%9A%E8%8E%B7%E5%8F%96code）
#返回参数，正确，说明该传入参数为内部微信用户发出的请求，并且指定返回一个公共权限账号cookie，让微信浏览器保存登录，同时返回True，否则返回False
####################################################################################################################################################
def wechat_logined(req,code):
    wechat_qy_ID = OAuth(code)
    try:
        user = User.objects.get(wechat_qy_account = wechat_qy_ID)
        # YourAccount = UserProfile.objects.get(wechat_qy_ID = wechat_qy_ID)
    except User.DoesNotExist:
        return False
    else:
        # user = YourAccount.user
        user.backend='django.contrib.auth.backends.ModelBackend'
        auth.login(req, user)
        return True

####################################################################################################################################################
#req：传入参数，带有CODE和STATE（参考：http://qydev.weixin.qq.com/wiki/index.php?title=%E4%BC%81%E4%B8%9A%E8%8E%B7%E5%8F%96code）
#返回参数，正确，说明该传入参数为内部微信用户发出的请求，并且判断是否为已注册用户，自动在后台注册帐号和绑定微信企业号，同时返回True，和注册的企业号ＩＤ，否则返回False，和已注册的企业号ＩＤ
####################################################################################################################################################
def auto_register(req):

    wechat_qy_ID = OAuth(req)
    try:
        user = UserProfile.objects.get(wechat_qy_ID=wechat_qy_ID)
    except UserProfile.DoesNotExist:
        try:
            User.objects.get(username=wechat_qy_ID)
        except User.DoesNotExist:
            NewUser = User.objects.create_user(wechat_qy_ID)
            NewUser.save()
        NewUserProfile = UserProfile(user=User.objects.get(username=wechat_qy_ID), wechat_qy_ID=wechat_qy_ID)
        NewUserProfile.save()
        user = NewUserProfile.user
        user.backend='django.contrib.auth.backends.ModelBackend'
        auth.login(req, user)
        return True,wechat_qy_ID
    # user = auth.authenticate(username='jw', password='123456')
    user = user.user
    user.backend='django.contrib.auth.backends.ModelBackend'
    auth.login(req, user)
    return False,wechat_qy_ID

######################################################################################################################################################
#req:传入参数，带有CODE和STATE（参考：http://qydev.weixin.qq.com/wiki/index.php?title=%E4%BC%81%E4%B8%9A%E8%8E%B7%E5%8F%96code）
#id:父部门ID
#返回参数：所有子部门组成的list,list包括[父部门id，部门名称，部门id]。注：部门名称需要.decode('string_escape')后才能正常显示。
######################################################################################################################################################
def get_department_list(id):
    ACCESS_TOKEN = access_token()
    url = 'https://qyapi.weixin.qq.com/cgi-bin/department/list?access_token='+ACCESS_TOKEN+'&id='+str(id)
    response = urllib2.urlopen(url)
    text = response.read()
    text.decode('utf-8').encode('utf-8')
    text = eval(text)                   #str转换为dict
    department = []
    for i in text['department']:
        data = [i['parentid'],i['name'],i['id']]
        department.append(data)
    return department