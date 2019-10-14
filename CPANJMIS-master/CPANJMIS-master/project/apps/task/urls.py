from django.conf.urls import url
from task import views
from rest_framework.urlpatterns import format_suffix_patterns

urlpatterns = [
    # url(r'^task/$', views.TaskList.as_view()),
    # url(r'^task/(?P<pk>[0-9]+)$', views.TaskDetail.as_view()),
    url(r'^api/taskpackage/$',views.TaskPackageList.as_view()),
    url(r'^api/taskpackagedetail/(?P<pk>[0-9]+)$',views.TaskPackageDetail.as_view()),
    url(r'^api/task/(?P<pk>[0-9]+)$',views.TaskDetail.as_view()),
    url(r'^api/taskfeedbacklist/$',views.TaskFeedbackList.as_view()),

    url(r'^api/getTaskPackageList/$',views.getTaskPackageList),
    url(r'^api/getTaskPackageDetail/$',views.getTaskPackageDetail),
    url(r'^api/getTaskDetail/$',views.getTaskDetail),
    url(r'^api/postTaskFeedback/$',views.postTaskFeedback),
    url(r'^api/getMyFeedbackTask/$',views.getMyFeedbackTask),
    url(r'^api/getMyFeedbackRecord/$', views.getMyFeedbackRecord),
    url(r'^api/getMyTask/$',views.getMyTask),
    url(r'^api/getMyFeedbackDetail/$', views.getMyFeedbackDetail),
    url(r'^api/getAddTaskTable/$',views.getAddTaskTable),
    url(r'^api/postNewTask/$',views.postNewTask),
    url(r'^api/getEvaluteList/$',views.getEvaluteList),
    url(r'^api/postPersonEvalute/$',views.postPersonEvalute),
    url(r'^api/getActivateTask/$',views.getActivateTask),
    url(r'^api/postAssignTask/$',views.postAssignTask),
    url(r'^api/getAttendanceList/$',views.getAttendanceList),
    url(r'^api/getaddattendancetable/$',views.getaddattendancetable),
    url(r'^api/getuser/$',views.getuser),
    url(r'^api/postnewattendance/$',views.postnewattendance),
    url(r'^api/getattendancelistdetail/$',views.getattendancelistdetail),
    url(r'^api/getattendancemembers/$',views.getattendancemembers),

]

urlpatterns = format_suffix_patterns(urlpatterns)