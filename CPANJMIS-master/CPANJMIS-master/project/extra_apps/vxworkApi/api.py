from cpa import cpa_init
import urllib,json

#使用管理组的开发者凭据获得access_token
def access_token():
    url = 'https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid='+cpa_init.qy_weixin_CorpID+'&corpsecret='+cpa_init.qy_weixin_Secret
    response = urllib.request.urlopen(url)
    text = response.read()
    text = eval(text)                   #str转换为dict
    access_token = text['access_token']
    return access_token

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
    req = urllib.request.Request(url = url2,data = body)
    res_data = urllib.request.urlopen(req)
    response = res_data.read()
    return response