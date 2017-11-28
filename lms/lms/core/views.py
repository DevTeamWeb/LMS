from django.shortcuts import render
from .models import *


def home(request, template_name='home.html'):
    return render(request, template_name)
