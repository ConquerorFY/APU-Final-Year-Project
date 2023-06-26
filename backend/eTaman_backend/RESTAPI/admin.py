from django.contrib import admin
from .models import *

# Register your models here.
admin.site.register(TestModel)
admin.site.register(ResidentModel)
admin.site.register(NeighborhoodGroupModel)
admin.site.register(JoinRequestModel)
admin.site.register(CrimePostModel)
admin.site.register(ComplaintPostModel)
admin.site.register(EventPostModel)
admin.site.register(GeneralPostModel)