from django.db import models
from lms.conta.models import User
from lms.aluno.models import *


class Professor(User):
    '''
    Classe usuários/Professor
    '''
    nome_completo =  models.CharField(max_length=80, null=False, blank=False)
    ra = models.CharField(unique=True, max_length=11, default=gera_ra(), null=False, blank=False)
    contato = models.CharField(max_length=11, null=False, blank=False)

    class Meta:
        verbose_name = 'Professor'
        verbose_name_plural = 'Professores'

