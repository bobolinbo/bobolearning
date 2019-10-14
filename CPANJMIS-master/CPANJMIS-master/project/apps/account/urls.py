from django.conf.urls import url
from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from . import views
from .vxwork import vxworkAPI

urlpatterns = [
    # url(r'^userlist/$', views.UserList.as_view()),
    # url(r'^userdetail/(?P<pk>[0-9]+)/$', views.UserDetail.as_view()),
    # url(r'^userdata/$', views.UserData1.as_view()),
    url(r'^api/account/LA_login_auth/$',views.LA_login_auth),
    url(r'^api/account/generateMenu/$', views.generateMenu),
    url(r'^api/account/LA_login/$',views.LA_login),
    url(r'^api/account/genVERCODE/$',views.genVERCODE),
]

urlpatterns = format_suffix_patterns(urlpatterns)