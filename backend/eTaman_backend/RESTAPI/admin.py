from django.contrib import admin
from .models import TestModel, ResidentModel, NeighborhoodGroupModel, JoinRequestModel

# Register your models here.
admin.site.register(TestModel)
admin.site.register(ResidentModel)
admin.site.register(NeighborhoodGroupModel)
admin.site.register(JoinRequestModel)