from django.db import models
from lms.conta.models import User
from datetime import datetime
import random



def gera_ra():
    #FUNÇÃO PARA GERAR RA AUTOMATICO
    x = datetime.now()
    y = str(x.year)
    return (y[2:]+"%i"%(random.randint(1000,90000)))


class Aluno(User):
    '''
    Classe usuários/Aluno
    '''
    ra = models.CharField(max_length=7, default=gera_ra(),unique=True, null=False, blank=False)
    nome_completo = models.CharField(max_length=100, null=False, blank=False)
    contatos = models.CharField(max_length=11, null=False, blank=False)


    class Meta:
        verbose_name = 'Aluno'
        verbose_name_plural = 'Alunos'


