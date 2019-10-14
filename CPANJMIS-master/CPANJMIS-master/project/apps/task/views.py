from django.shortcuts import render
from django.http import HttpResponse,JsonResponse

from django.http import Http404
from django.views.generic.base import View
from account.models import User,PersonnelProfessionalInfo
from django.core.serializers import serialize
from django.core.serializers.json import DjangoJSONEncoder
from django.forms.models import model_to_dict
from .models import *
from dev.func import CreateLog
from basicdata.models import ATAChatper,AircraftBasicData,Site,AuthorizationClassify
import cpa.cpa_init as cpa_init
from rest_framework.views import APIView
from rest_framework import viewsets
from rest_framework.renderers import JSONRenderer
from rest_framework.parsers import JSONParser
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from rest_framework import mixins
from rest_framework import generics
from .serializers import TaskPackageSerializer,TaskSerializer,TaskListSerializer,TaskFeedbackSerializer
from django.views.decorators.csrf import csrf_exempt,csrf_protect
from django.db.models import Q
import json,difflib,datetime
from modules.models import RatingSystem
from extra_apps.vxworkApi.api import wechat_send_textcard
import math
# Create your views here.

@csrf_exempt
def getAttendanceList(request):
    dataDict = {'code': 0, 'msg': '', 'count': '', 'data': []}
    AM = attendance_management.objects.filter(valid=True)
    for item in AM.all():
        number = item.members.all().count()
        names = ''
        for member in item.members.all():
            names += member.name + ' '
        dataDict['data'].append(
            {
                'id': item.id,
                'datetime': item.date,
                'department': item.department.name,
                'number': number,
                'member': names,
                'valid': True,
            }
        )
    return JsonResponse(dataDict)

# task/taskAssign页面修改值处理
@csrf_exempt
def postAssignTask(request):
    dataDict = {'code': 0, 'msg': '', 'count': '', 'data': []}
    field = request.POST.get('field')
    value = request.POST.get('value').strip(' ')
    data = request.POST.get('data')
    title = request.POST.get('data[title]')
    aircraft_number = request.POST.get('data[aircraft_number]')
    id = request.POST.get('data[id]')
    fangxing = request.POST.get('data[fangxing]').strip(' ')
    assignTo = request.POST.get('data[assignedTo]').strip(' ')
    t = task.objects.get(pk=id)
    if field == 'position':
        t.position = value
        t.save()
        dataDict['msg'] += "机位更新为"+str(value)
    if field == 'leader':
        u = User.objects.filter(name=value)
        if u.count() == 0:
            if not value:
                t.leader = None
                t.save()
                dataDict['msg'] += "已清除负责人"
            else:
                dataDict['code']=-1
                dataDict['msg'] += "查找不到用户，请检查名字是否正确"
        elif u.count() >1:
            dataDict['code'] = -1
            dataDict['msg'] += "名字重复，无法认定正确人员，请联系管理员"
        else: # == 1
            t.leader = u[0]
            t.save()
            dataDict['msg'] += "负责人更新为："+u[0].name
            wechat_send_textcard(touser=u[0].wechat_qy_account, msgtype="textcard", agentid="1000023", title="收到一条生产任务",
                                 description='[B-'+aircraft_number+']'+title, url="https://fibosstore.cn/static/m/start/index.html#/CPA/task/mytask", btntxt="点击查看")
    if field == 'assignedTo':
        userList = value.split()
        if fangxing:
            for user in fangxing.split(' '):
                userList.append(user)
        t.assignedTo.clear()
        for userName in userList:
            u = User.objects.filter(name=userName)
            if u.count() == 0:
                dataDict['msg'] += "查找不到["+userName+"]，请检查名字是否正确<br>"
            elif u.count() > 1:
                dataDict['msg'] += "名字["+userName+"]重复，无法认定正确人员，请报管理员<br>"
            else:  # == 1
                t.assignedTo.add(u[0])
                dataDict['msg'] += "新增："+userName+"<br>"
        t.save()
    if field == "fangxing":
        userList = value.split()
        if assignTo:
            for user in assignTo.split(' '):
                userList.append(user)
        t.assignedTo.clear()
        for userName in userList:
            u = User.objects.filter(name=userName)
            if u.count() == 0:
                dataDict['msg'] += "查找不到[" + userName + "]，请检查名字是否正确<br>"
            elif u.count() > 1:
                dataDict['msg'] += "名字[" + userName + "]重复，无法认定正确人员，请报管理员<br>"
            else:  # == 1
                t.assignedTo.add(u[0])
                dataDict['msg'] += "新增：" + userName + "<br>"
        t.save()

    dataDict['data']={'field':field,'value':value,'data':data}
    return JsonResponse(dataDict)

def getActivateTask(request):
    # pageNo = int(request.GET['page'])
    # limit = int(request.GET['limit'])
    t = task.objects.filter(status='生效')
    count = t.count()
    dataDict = {'code': 0, 'msg': '', 'count': count, 'data': []}
    # t2 = t[(pageNo-1)*limit:pageNo*limit]
    for item in t:
        # if not task_feedback.objects.filter(task=item).filter(user=request.user):
        #     hadfeedback = False
        # else:
        #     hadfeedback = True
        if item.assignedTo:
            assignedTo = ''
            fangxing = ''
            for i in item.assignedTo.all(): # 遍历每个协助人员
                tag = False
                PPI = PersonnelProfessionalInfo.objects.filter(user=i)
                fx_auth = AuthorizationClassify.objects.filter(name__icontains='放行')
                if PPI.count() == 1 and fx_auth.count()>0:
                    for j in fx_auth.all():
                        if PPI[0].isAuthorized(j):# 如果该协助人员有放行授权，返回该人员为“放行”
                            fangxing += ' '+i.name
                            tag = True
                            break
                if not tag:
                    assignedTo = assignedTo + ' ' + i.name
        else:
            assignedTo = ''
        leaderName = item.leader.name if item.leader else ''
        dataDict['data'].append({"aircraft_number":item.aircraft.aircraft_number,
                                 "title":item.title,
                                 "id":item.id,
                                 # "hadfeedback":hadfeedback,
                                 "position":item.position,
                                 "leader":leaderName,
                                 "assignedTo":assignedTo.strip(' '),
                                 "fangxing":fangxing,})
    return JsonResponse(dataDict)

@csrf_exempt
def postPersonEvalute(request):
    dataDict = {'code': 0, 'msg': '评价成功', 'data': []}
    if request.POST.get('id'):
        RatingSystem.objects.create(
            rater = request.user,
            ratee = User.objects.get(id=request.POST.get('id')),
            type = "日常表现：综合",
            score = request.POST.get('rate01')
        )
        RatingSystem.objects.create(
            rater=request.user,
            ratee=User.objects.get(id=request.POST.get('id')),
            type="日常表现：技能",
            score=request.POST.get('rate02')
        )
        RatingSystem.objects.create(
            rater=request.user,
            ratee=User.objects.get(id=request.POST.get('id')),
            type="日常表现：态度",
            score=request.POST.get('rate03')
        )
        RatingSystem.objects.create(
            rater=request.user,
            ratee=User.objects.get(id=request.POST.get('id')),
            type="日常表现：团队",
            score=request.POST.get('rate04')
        )
        RatingSystem.objects.create(
            rater=request.user,
            ratee=User.objects.get(id=request.POST.get('id')),
            type="日常表现：服务",
            score=request.POST.get('rate05')
        )
        RatingSystem.objects.create(
            rater=request.user,
            ratee=User.objects.get(id=request.POST.get('id')),
            type="日常表现：判断",
            score=request.POST.get('rate06')
        )
    else:
        dataDict['code']=-1
        dataDict['msg']="POST数据错误，请重新评价"
    return JsonResponse(dataDict)

def getEvaluteList(request):
    dataDict = {'code': 0, 'msg': '', 'data': []}
    if request.GET.get('show') == 'weixiu': # 维修人员
        users1 = PersonnelProfessionalInfo.objects.filter(authorization__name='NJ飞机维修人员-航线')
        users2 = PersonnelProfessionalInfo.objects.filter(authorization__name='NJ飞机维修人员-定检')
        users = (users1 | users2).distinct()
    elif request.GET.get('show') == 'fx': # 放行人员
        users1 = PersonnelProfessionalInfo.objects.filter(authorization__name='NJ航线放行人员')
        users2 = PersonnelProfessionalInfo.objects.filter(authorization__name='NJ定检放行人员')
        users = (users1 | users2).distinct()
    for obj in users:
        dataDict['data'].append({'id':obj.user.id,'name':obj.user.name})

    return JsonResponse(dataDict)



@csrf_exempt
def postNewTask(request):
    if request.POST.get('access_token'):
        task_type = request.POST.get('task-type')
        ATA_id = request.POST.get('ATA')
        Aircraft_id = request.POST.get('Aircraft')
        taskTitle = request.POST.get('task-title')
        taskDesc = request.POST.get('task-desc')
        taskPackage_id = request.POST.get('task-package')
        taskHour = request.POST.get('task-hour').replace(' ', '')
        taskMan = request.POST.get('task-man').replace(' ', '')
        tmpData = task.objects.create(
            source = '现场',
            type = task_type,
            ATAChapter = ATAChatper.objects.get(id=ATA_id),
            title = taskTitle,
            description = taskDesc,
            belong_to_package = task_package.objects.get(id=taskPackage_id),
            aircraft = AircraftBasicData.objects.get(id=Aircraft_id),
            hour = taskHour,
            man = taskMan,
            exec_date = datetime.date.today(),
            exec_site = Site.objects.get(name='南京'),# 暂定为都是南京
            status = '生效',
            leader = request.user,
            creator = request.user,
            editor = request.user,
        )
        dataDict = {'code': 0, 'msg': "创建任务成功,点击'确定'后继续填报工时", 'data': {'id':tmpData.id}}
        CreateLog(request.user, "task.task", "create", model_to_dict(tmpData,exclude=['exec_date','creation_time','editor','edit_time','verifier','verify_time','who_close','status_close_time']),json.loads(request.POST.get('termInfo')))
        return JsonResponse(dataDict)
    return JsonResponse({'code': -1, 'msg': 'NO ACCESS TOKEN', 'data': []})


import demjson
@csrf_exempt
def postnewattendance(request):
    if request.POST.get('access_token'):
        workdate = request.POST.get('workdate')
        department = request.POST.get('department')
        posttype = request.POST.get('post-type')
        id = request.POST.get('post-type2')
        user = request.POST.get('user')
        user_zhuanhua = json.loads(user)

        if posttype == "Add":
            tmpData = attendance_management.objects.create(
                date = workdate,
                department = Department.objects.get(id = department),
                valid = True
            )
            for i in user_zhuanhua:
                t = i['value']
                m = User.objects.get(id = t)
                tmpData.members.add(m)

            dataDict = {'code': 0, 'msg': "创建考勤表成功,点击'确定'后查看考勤列表", 'data': {'id':tmpData.id}}
            return JsonResponse(dataDict)

        elif posttype == "Modify":
            p = attendance_management.objects.get(id=id )
            p.date = workdate
            p.department = Department.objects.get(id = department)
            p.members.clear()
            for i in user_zhuanhua:
                t = i['value']
                m = User.objects.get(id=t)
                p.members.add(m)
                p.members.all().distinct()
            p.save()
            return JsonResponse({'code': 0, 'msg': '已成功更新考勤表', 'data': ''})
    return JsonResponse({'code': -1, 'msg': 'NO ACCESS TOKEN', 'data': []})

def getAddTaskTable(request):
    dataDict = {'code': 0, 'msg': '', 'data': []}
    task_type = cpa_init.task_type
    ATAList = []
    TaskPackageList = []
    AircraftList = []
    SiteList = []
    for i in ATAChatper.objects.all():
        ATAList.append([i.id,i.chapter,i.section,i.subject_cn])
    for i in task_package.objects.filter(status='生效'):
        TaskPackageList.append([i.id,i.name])
    for i in AircraftBasicData.objects.filter(valid=True):
        AircraftList.append([i.id,i.aircraft_number,i.type.name])
    for i in Site.objects.filter(valid=True):
        SiteList.append([i.id,i.name])
    dataDict['data']={'typeList':task_type,'ATAList':ATAList,'TaskPackageList':TaskPackageList,'AircraftList':AircraftList,'SiteList':SiteList}
    return JsonResponse(dataDict)


from basicdata.models import *
def getaddattendancetable(request):
    dataDict = {'code': 0, 'msg': '', 'data': []}
    department = []
    for i in Department.objects.all():
        department.append([i.id,i.name])
    dataDict['data'] = {'department':department}
    return JsonResponse(dataDict)


from  account.models import  *
from basicdata.models import Department
def getuser(request):
    dataDict = {'code': 0, 'msg': '', 'data': []}
    for i in User.objects.all():
        if i.department:
            name_department = i.department.name
        else:
            name_department = ''
        if i.name:
            name = i.name
        else:
            name = ''
        dataDict['data'].append({"value":i.id,"title":name+'/'+name_department,"disabled": "", "checked": ""})
    return JsonResponse(dataDict)



def getMyFeedbackRecord(request):# 获得"我反馈过的所有任务"记录
    MyFeedbackData = task_feedback.objects.filter(user=request.user).filter(lock=True)
    dataDict = {'code':0,'msg':'','data':[]}
    if MyFeedbackData:
        for myfeedback in MyFeedbackData:
            status = "<i class='layui-icon layui-icon-ok'></i>" if myfeedback.status == '已完成' else "<i class='layui-icon layui-icon-close'></i>"
            dataDict['data'].append({'aircraft_number':myfeedback.task.aircraft.aircraft_number,'taskname':myfeedback.task.title,'force':myfeedback.force,'time':myfeedback.time,'status':status})
    return JsonResponse(dataDict)

def getMyFeedbackTask(request): # 获得"我反馈过的（当前有效）任务"记录
    MyFeedbackData = task_feedback.objects.filter(user=request.user).filter(lock=False)
    dataDict = {'code':0,'msg':'','data':[]}
    if MyFeedbackData:
        for myfeedback in MyFeedbackData:
            dataDict['data'].append({'aircraft_number':myfeedback.task.aircraft.aircraft_number,'taskname':myfeedback.task.title,'force':myfeedback.force,'lock':myfeedback.lock})
    return JsonResponse(dataDict)

def getMyTask(request): # 返回有效任务中，指派给我的任务和我反馈过的任务
    myTasks_hadFeedback = task.objects.filter(task_feedback__user=request.user).filter(status='生效')
    myTasks_assign = task.objects.filter(assignedTo=request.user).filter(status='生效')
    myTasks_leader = task.objects.filter(leader=request.user).filter(status='生效')
    myTasks = (myTasks_hadFeedback | myTasks_assign | myTasks_leader).distinct()
    dataDict = {'code':0,'msg':'','data':[]}
    for taskItem in myTasks:

        if task_feedback.objects.filter(task=taskItem,user=request.user).count() == 1:
            hadfeedback = True
        else:
            hadfeedback = False

        if taskItem in myTasks_leader:
            title = '[主]'+taskItem.title
        elif taskItem in myTasks_assign:
            title = '[协]' + taskItem.title
        else:
            title = taskItem.title
        if taskItem.source == '现场':
            title = '<font color="#FF0000">' + title + '</font>'
        dataDict['data'].append({'id':taskItem.id,'aircraft_number':taskItem.aircraft.aircraft_number,'taskname':title,'hadfeedback':hadfeedback})
    # for taskItem in myTasks_assign:
    #     dataDict['data'].append({'id':taskItem.id,'aircraft_number':taskItem.aircraft.aircraft_number,'taskname':taskItem.title,'hadfeedback':False})
    return JsonResponse(dataDict)

def getTaskPackageList(request): # 获得任务书列表
    # request.session.set_expiry(60)
    taskPackageList = task_package.objects.all()
    dataDict = {'code':0,'msg':'','data':[]}
    for Package in taskPackageList:
        if Package.status == '生效':
            t = model_to_dict(Package)
            dataDict['data'].append(t)
    return JsonResponse(dataDict)

# page:taskindex 获得某任务书的详细任务列表
def getTaskPackageDetail(request):
    id = request.GET.get('id')
    pageNo = int(request.GET['page'])
    limit = int(request.GET['limit'])
    package = task_package.objects.get(id=id)
    if request.GET.get('key[keyword]'):
        keyword = request.GET['key[keyword]']
        task1 = package.task.filter(status='生效').filter(aircraft__aircraft_number=keyword)
        task2 = package.task.filter(status='生效').filter(title__icontains=keyword)
        task = (task1 | task2).distinct()
    else:
        task = package.task.filter(status='生效')
    count = task.count()
    # pageCount = math.ceil(task.count()/int(limit))
    task = task[(pageNo-1)*limit:pageNo*limit]
    dataDict = {'code': 0, 'msg': '', 'count':count,'data': []}
    # for t in taskPackage.include_task.all():
    for item in task:
        if not task_feedback.objects.filter(task=item).filter(user=request.user):
            hadfeedback = False
        else:
            hadfeedback = True
        title = '<font color="#FF0000">'+item.title+'</font>' if item.source == '现场' else item.title
        dataDict['data'].append({"aircraft_number":item.aircraft.aircraft_number,"title":title,"id":item.id,"hadfeedback":hadfeedback})
    return JsonResponse(dataDict)


from basicdata.models import *
from django.core import serializers
def getattendancelistdetail(request): #获得考勤表详细信息
    id = request.GET['id']
    attendance = attendance_management.objects.get(id = id)
    dataDict = {'code':0,'msg':'','data':{}}
    member = serializers.serialize("json",attendance.members.all())
    dataDict['data'] = {"workdate":attendance.date,
                        "departments":attendance.department.name,
                        "departmentsid":attendance.department.id,
                        "members":member,
                        "id":attendance.id,
                        "valid":attendance.valid
                        }
    department = []
    for i in Department.objects.all():
        department.append([i.id, i.name])
    dataDict['data']['department']= department
    return JsonResponse(dataDict)


from  account.models import  *
from django.core import serializers
def getattendancemembers(request):
    id = request.GET['id']
    s = []
    attendance = attendance_management.objects.get(id=id)
    dataDict = {'code': 0, 'msg': '', 'data': [{"user":[]},{"member":[]}]}
    for i in User.objects.all():
        if i.department:
            name_department = i.department.name
        else:
            name_department = ''
        if i.name:
            name = i.name
        else:
            name = ''
        dataDict['data'][0]['user'].append({"value": i.id, "title": name + '/' + name_department, "disabled": "", "checked": ""})
    for member in attendance.members.all():
        dataDict['data'][1]['member'].append(member.id)
    return JsonResponse(dataDict)



def getMyFeedbackDetail(request): # 获得某条任务某人反馈的详细信息
    id = request.GET['id']
    taskItem = task.objects.get(pk=id)
    myFeedback = task_feedback.objects.filter(task=taskItem).filter(user=request.user)
    dataDict = {'code': 0, 'msg': '', 'data': {}}
    if myFeedback.count() == 1: # 此处还应该做一个判断，如果任务或反馈已被锁定，则不可修改
        if taskItem.status == '生效' and myFeedback[0].lock == False:
            dataDict['data']={"aircraft_number": taskItem.aircraft.aircraft_number,
                              "taskTitle": taskItem.title,
                              "id": taskItem.id,
                              "fb_status": myFeedback[0].status,
                              "fb_force": myFeedback[0].force,
                              "fb_notes": myFeedback[0].notes,
                              "type": taskItem.type,
                              "role": myFeedback[0].role,
                              "rate": myFeedback[0].self_score,
                              }
            if dataDict['data']['type'] == "勤务":
                dataDict['data']['standardlib_desc'] = taskItem.link_to_standard_library.description
        else:
            dataDict['code'] = -1
            dataDict['msg'] = "任务非生效状态 或 反馈已被锁定"
    elif myFeedback.count() > 1:
        dataDict['code'] = -1
        dataDict['msg'] = "您关于本条任务的反馈数多于1条，请把本条错误反馈给管理员"
    elif myFeedback.count() == 0:
        dataDict['code'] = -1
        dataDict['msg'] = "您未反馈过本条任务，无法进行修改"

    return JsonResponse(dataDict)

def getTaskDetail(request): # 获得某条任务的详细信息
    id = request.GET['id']
    taskDetail = task.objects.get(pk=id)
    dataDict = {'code': 0, 'msg': '', 'data': {}}
    jobcardTitle = taskDetail.jobcard.title_cn if taskDetail.jobcard else None
    jobcardNo = taskDetail.jobcard.jobcard_number if taskDetail.jobcard else None
    ATAChapterChapter = taskDetail.ATAChapter.chapter if taskDetail.ATAChapter else None
    ATAChapterSection = taskDetail.ATAChapter.section if taskDetail.ATAChapter else None
    ATAChapterSubject = taskDetail.ATAChapter.subject_cn if taskDetail.ATAChapter else None
    feedback_tmp = task_feedback.objects.filter(task=taskDetail).filter(user=request.user)
    exec_site = taskDetail.exec_site.name if taskDetail.exec_site else None
    exec_date = taskDetail.exec_date if taskDetail.exec_date else None

    if not feedback_tmp:
        hadfeedback=False
    else:
        hadfeedback=True

    if taskDetail.hour:
        hour = taskDetail.hour
    elif taskDetail.link_to_standard_library:
        hour = taskDetail.link_to_standard_library.hour
    else:
        hour = "未安排"

    leader = taskDetail.leader.name if taskDetail.leader else "暂未安排"

    assignTo = ""
    if taskDetail.assignedTo.all():
        for a in taskDetail.assignedTo.all():
            assignTo += ' '+a.name
        assignTo = assignTo.strip()
    else:
        assignTo = "暂未安排"

    dataDict['data']={
        "aircraft_number":taskDetail.aircraft.aircraft_number,
        "source":taskDetail.source,
        "type":taskDetail.type,
        "title":taskDetail.title,
        "id":taskDetail.id,
        "jobcardNo":jobcardNo,
        "jobcardTitle":jobcardTitle,
        "ATAChapterChapter":ATAChapterChapter,
        "ATAChapterSection": ATAChapterSection,
        "ATAChapterSubject": ATAChapterSubject,
        "description":taskDetail.description,
        "finish_status":taskDetail.finish_status,
        "hadfeedback":hadfeedback,
        "hour":hour,
        "exec_site":exec_site,
        "exec_date":exec_date,
        "leader":leader,
        "assignTo":assignTo,
    }

    if taskDetail.type == '勤务':
        dataDict['data']['standardlib_desc'] = taskDetail.link_to_standard_library.description

    return JsonResponse(dataDict)

@csrf_exempt
def postTaskFeedback(request):
    if request.POST.get('access_token'):
        if request.POST.get('post-status'):
            status = "已完成"
        else:
            status = "未完成"
        role = request.POST['post-role']
        notes = {'manual':request.POST.get('post-notes')}
        rate = request.POST.get('post-rate')
        taskID = request.POST.get('post-taskID')
        isCommonTask = request.POST.get('post-isCommonTask')
        type = request.POST.get('post-type')
        if isCommonTask == 'True':
            hour = float(request.POST.get('post-hour'))
        else:
            hour = 0
            notes['system'] = {}
            theTaskdetail = task.objects.get(id=taskID)
            items = json.loads(theTaskdetail.link_to_standard_library.description.replace("\r","").replace("\n",""))
            for num in range(len(items['data'])):
                item = items['data'][num]
                if request.POST.get('post-hour-'+str(num)) == 'on':
                    hour += float(items['data'][num][1])
                    notes['system'][items['data'][num][0]] = items['data'][num][1]

        taskset = task_feedback.objects.filter(user=request.user,task__id=taskID)
        if hour == 0:
            return JsonResponse({'code': -4, 'msg': '反馈工时为0，无效反馈，请重新填写', 'data': ''})

        if taskset.count() > 1:
            return JsonResponse({'code': -2, 'msg': '重复反馈>1', 'data': ''})
        elif taskset.count() == 1:
            if type == "Modify":
                data = taskset[0]
                data.status = status
                data.role = role
                data.notes = json.dumps(notes, ensure_ascii=False, indent=4)
                data.force = hour
                data.self_score = rate
                data.save()
                CreateLog(request.user,"task.task_feedback","modify",model_to_dict(data),json.loads(request.POST.get('termInfo')))
                return JsonResponse({'code': 0, 'msg': '更新信息成功', 'data': ''})
            elif type == "Create":
                return JsonResponse({'code': -3, 'msg': '您已反馈过一次，请勿重复反馈', 'data': ''})
        else:
            tmpData = task_feedback.objects.create(
                task = task.objects.get(id=taskID),
                user = request.user,
                status = status,
                force = hour,
                notes = json.dumps(notes, ensure_ascii=False, indent=4),
                role = role,
                self_score = rate
            )
            CreateLog(request.user, "task.task_feedback", "create",model_to_dict(tmpData),json.loads(request.POST.get('termInfo')))
            return JsonResponse({'code':0,'msg':'工时反馈成功','data':''})
    return JsonResponse({'code':-1,'msg':'with out access_token','data':''})

class TaskPackageList(APIView):
    """
    列出所有的TaskPackage。
    """
    def get(self, request, format=None):
        taskPackageList = task_package.objects.all()
        serializer = TaskPackageSerializer(taskPackageList, many=True)
        data = {'code': 0, 'msg': '', 'data': serializer.data}
        return Response(data)

    # def post(self, request, format=None):
    #     serializer = SnippetSerializer(data=request.data)
    #     if serializer.is_valid():
    #         serializer.save()
    #         return Response(serializer.data, status=status.HTTP_201_CREATED)
    #     return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class TaskPackageDetail(APIView):
    """
    列出所有的TaskPackageDetail。
    """
    def get(self, request, pk, format=None):
        taskPackage = task_package.objects.get(pk=pk)
        serializer = TaskListSerializer(taskPackage.include_task, many=True)
        data = {'code': 0, 'msg': '', 'data': serializer.data}
        return Response(data)

class TaskDetail(APIView):
    """
    列出所有的TaskPackageDetail。
    """
    def get(self, request, pk, format=None):
        taskPackage = task.objects.get(pk=pk)
        serializer = TaskSerializer({taskPackage}, many=True)
        data = {'code': 0, 'msg': '', 'data': serializer.data}
        return Response(data)

class TaskFeedbackList(APIView):
    def get(self, request, format=None):
        feedback = task_feedback.objects.all()
        serializer = TaskFeedbackSerializer(feedback, many=True)
        data = {'code': 0, 'msg': '', 'data': serializer.data}
        return Response(data)

    def post(self, request, format=None):
        serializer = TaskFeedbackSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
