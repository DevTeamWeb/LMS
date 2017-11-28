from django.shortcuts import render


# Create your views here.

def home_aluno(request, template_name='aluno/home_aluno.html'):
    return render(request, template_name)