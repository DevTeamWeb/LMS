from django.conf.urls import url
from .views import *


app_name = 'aluno'
urlpatterns = [
    url(r'^$', home_aluno, name='home'),
]