# Arquivo: apps/users/forms.py'

from django.contrib.auth.forms import UserCreationForm

from lms.aluno.models import Aluno



class CustomUserCreationForm(UserCreationForm):
    '''
    Customizando os campos do formulario de cadastro aluno
    '''
    class Meta:
        model = Aluno
        fields = ['username','email','nome_completo','contatos']

