# from django.conf.urls import url
# from rest_framework.urlpatterns import format_suffix_patterns
# from . import views
#
# urlpatterns = [
#     url(r'^snippets/$', views.SnippetList.as_view()),
#     url(r'^snippets/(?P<pk>[0-9]+)/$', views.SnippetDetail.as_view()),
#     url(r'^users/$', views.UserList.as_view()),
#     url(r'^users/(?P<pk>[0-9]+)/$', views.UserDetail.as_view()),
#     url(r'^$', views.api_root),
#     url(r'^snippets/(?P<pk>[0-9]+)/highlight/$', views.SnippetHighlight.as_view()),
# ]
#
# urlpatterns = format_suffix_patterns(urlpatterns)
from django.conf.urls import url, include
from rest_framework.urlpatterns import format_suffix_patterns
from rest_framework import renderers
from . import views

snippet_list = views.SnippetViewSet.as_view({
    'get': 'list',
    'post': 'create'
})
snippet_detail = views.SnippetViewSet.as_view({
    'get': 'retrieve',
    'put': 'update',
    'patch': 'partial_update',
    'delete': 'destroy'
})
snippet_highlight = views.SnippetViewSet.as_view({
    'get': 'highlight'
}, renderer_classes=[renderers.StaticHTMLRenderer])
user_list = views.UserViewSet.as_view({
    'get': 'list'
})
user_detail = views.UserViewSet.as_view({
    'get': 'retrieve'
})

urlpatterns = format_suffix_patterns([
    # url(r'^$', views.api_root),
    # url(r'^snippets/$',
    #     views.SnippetList.as_view(),
    #     name='snippet-list'),
    # url(r'^snippets/(?P<pk>[0-9]+)/$',
    #     views.SnippetDetail.as_view(),
    #     name='snippet-detail'),
    # url(r'^snippets/(?P<pk>[0-9]+)/highlight/$',
    #     views.SnippetHighlight.as_view(),
    #     name='snippet-highlight'),
    # url(r'^users/$',
    #     views.UserList.as_view(),
    #     name='user-list'),
    # url(r'^users/(?P<pk>[0-9]+)/$',
    #     views.UserDetail.as_view(),
    #     name='user-detail')
    url(r'^$', views.api_root),
    url(r'^snippets/$', snippet_list, name='snippet-list'),
    url(r'^snippets/(?P<pk>[0-9]+)/$', snippet_detail, name='snippet-detail'),
    url(r'^snippets/(?P<pk>[0-9]+)/highlight/$', snippet_highlight, name='snippet-highlight'),
    url(r'^users/$', user_list, name='user-list'),
    url(r'^users/(?P<pk>[0-9]+)/$', user_detail, name='user-detail')
])

# 可浏览API的登录和注销视图
urlpatterns += [
    url(r'^api-auth/', include('rest_framework.urls',namespace='rest_framework')),
]