from django.conf.urls import url

from .views import *

app_name = 'conta'
urlpatterns = [
    url(r'^$', home, name="home"),
    url(r'^login/$', login_view, name="login"),
    url(r'^logout/$', logout_view, name="logout"),
    url(r'^register/$', RegistrationView.as_view(), name="register"),
]
