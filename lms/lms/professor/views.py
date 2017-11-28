from django.shortcuts import render



def home_professor(request, template_name='professor/home_professor.html'):
    return render(request, template_name)