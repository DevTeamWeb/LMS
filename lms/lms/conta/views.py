# coding=utf-8
from django.shortcuts import render
from django.views.generic import CreateView
from django.http import HttpResponseRedirect
from django.contrib.auth.views import login
from django.contrib.auth.views import logout
from django.core.urlresolvers import reverse_lazy, reverse

from .forms import CustomUserCreationForm


def home(request):
    return render(request, 'conta/home.html')


def login_view(request, *args, **kwargs):
    if request.user.is_authenticated():
        return HttpResponseRedirect(reverse('conta:home'))

    kwargs['extra_context'] = {'next': reverse('aluno:home')}
    kwargs['template_name'] = 'conta/login.html'
    return login(request, *args, **kwargs)


def logout_view(request, *args, **kwargs):
    kwargs['next_page'] = reverse('conta:login')
    return logout(request, *args, **kwargs)


class RegistrationView(CreateView):
    form_class = CustomUserCreationForm
    success_url = reverse_lazy('conta:login')
    template_name = "conta/register.html"


'''

--------------------------------------------------------------------------
from django.contrib.auth.models import User
from django.shortcuts import render, redirect

def cadastro(request, template_name='conta/cadastro_aluno.html'):
    if request.method == "POST":
        username == request.POST['username']
        email == request.POST['email']
        password == request.POST['password']
        user = User.objects.create_user(username, email, password)
        return redirect('')
    return render(request, template_name, {})

def login(request, template_name='conta/login.html'):
    return render(request, template_name)


'''