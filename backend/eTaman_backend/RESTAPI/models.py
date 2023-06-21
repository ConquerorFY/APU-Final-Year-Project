from django.db import models

# Create your models here.

# Test Model
class TestModel(models.Model):
    name = models.CharField(max_length=70, blank=False, default='')

    class Meta:
        app_label = 'RESTAPI'

    def __str__(self):
        return self.name
