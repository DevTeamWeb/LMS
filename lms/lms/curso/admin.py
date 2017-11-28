from django.contrib import admin
from .models import *
# Register your models here.


admin.site.register(Disciplinas)
admin.site.register(Cursos)
admin.site.register(Semestre)
admin.site.register(Ano)
admin.site.register(Periodo)




class TurmaAdmin(admin.ModelAdmin):
    ''' Customizando o ADMIN do django -
    lista_display organiza o conteúdo numa tabela com os valores pedidos -
    search_fields cria um campo de pesquisa com caracteristica ICONSTAINS no filtro -
    prepopulated_fields cria automaticamente o slug baseado no parametro dado, no caso nome'''

    list_display = ['apelido_turma', 'turma_id']


admin.site.register(Turma,TurmaAdmin)








