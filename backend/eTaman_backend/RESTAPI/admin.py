from django.contrib import admin
from .models import *

# Register your models here.
admin.site.register(TestModel)
admin.site.register(ResidentModel)
admin.site.register(NeighborhoodGroupModel)
admin.site.register(JoinRequestModel)
admin.site.register(CrimePostModel)
admin.site.register(CrimePostCommentModel)
admin.site.register(ComplaintPostModel)
admin.site.register(ComplaintPostCommentModel)
admin.site.register(EventPostModel)
admin.site.register(EventPostCommentModel)
admin.site.register(GeneralPostModel)
admin.site.register(GeneralPostCommentModel)