from django.conf.urls import url
from .views import *


app_name = 'prfessor'
urlpatterns = [
    url(r'^$', home_professor, name='home'),
]