from django.db import models
from lms.aluno.models import Aluno

# Create your models here.

class Disciplinas(models.Model):
    '''
    Classe das disciplinas
    '''
    nome = models.CharField(primary_key=True, max_length=240, null=False)
    apelido = models.SlugField(unique=True)
    carga_horario = models.PositiveSmallIntegerField()
    teoria = models.CharField(max_length=500, null=False)
    pratica = models.CharField(max_length=500, null=False)
    ementa = models.TextField()
    competencias = models.TextField()
    habilidades = models.TextField()
    conteudo = models.TextField()
    bibliografia_basica = models.TextField()
    bibliografia_complementar = models.TextField()

    class Meta:
        verbose_name = 'Disciplina'
        verbose_name_plural = 'Disciplinas'

    def __str__(self):
        return self.nome



class Cursos(models.Model):
    '''
    Classe dos cursos
    '''
    sigla = models.CharField(primary_key=True, max_length=5, null=False)
    nome = models.CharField(max_length=50, null=False)

    class Meta:
        verbose_name = 'Curso'
        verbose_name_plural = 'Cursos'

    def __str__(self):
        return self.sigla or self.nome

class Semestre(models.Model):
    '''
    Classe para determinar o ano e semestre da turma
    '''
    SEMESTRE_CHOICES = (
        ('1', '1'),
        ('2', '2'),
        ('3', '3'),
        ('4', '4'),
        ('5', '5'),
        ('6', '6'),
        ('7', '7'),
        ('8', '8'),
    )
    semestre = models.CharField(max_length=1, null=False, default='Semestre do Curso', choices=SEMESTRE_CHOICES)

    class Meta:
        verbose_name = 'Semestre Ano'
        verbose_name_plural = 'Semestres'

    def __str__(self):
        return self.semestre

class Ano(models.Model):
    ano = models.SmallIntegerField(null=False, default='Ano Semestre')

    def __str__(self):
        return str(self.ano)

class Periodo(models.Model):
    '''
    Classe para determinar o periodo dos cursos
    '''
    PERIODO_CHOICES = (
        ('Manhã', 'Matutino'),
        ('Noite', 'Noturno'),
    )
    periodo = models.CharField(max_length=8, choices=PERIODO_CHOICES, null=False)

    class Meta:
        verbose_name = 'Periodo'
        verbose_name_plural = 'Periodos'

    def __str__(self):
        return self.periodo




class Turma(models.Model):
    '''
    Classes das turmas
    '''
    turma_id = models.AutoField(primary_key=True)
    apelido_turma = models.SlugField(unique=True, null=False, verbose_name='Apelido da Turma')
    periodo = models.ManyToManyField(Periodo, verbose_name='Periodo da Turma')
    grade_materias_turma = models.ManyToManyField(Disciplinas, verbose_name='Grade Curricular do Semestre')
    semestre = models.ManyToManyField(Semestre, verbose_name='Semestre da Turma')
    ano = models.ManyToManyField(Ano, verbose_name='Ano Letivo da Turma')
    alunos = models.ManyToManyField(Aluno, verbose_name='Alunos')

    class Meta:
        verbose_name = "Turma"
        verbose_name_plural = "Turmas"


    def __str__(self):
        return "Turma: %s " %(self.apelido_turma)
