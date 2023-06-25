from django.db import models

# Create your models here.

# Test Model
class TestModel(models.Model):
    name = models.CharField(max_length=70, blank=False, default='')
    # class Meta:
    #     app_label = 'RESTAPI'
    def __str__(self):
        return self.name

# Neighborhood Group Model
class NeighborhoodGroupModel(models.Model):
    name = models.CharField(max_length=100, blank=False, unique=True)
    state = models.CharField(max_length=20, blank=False)
    city = models.CharField(max_length=100, blank=False)
    street = models.CharField(max_length=100, blank=False)
    postcode = models.IntegerField(blank=False)
    rules = models.CharField(max_length=10000, default="")

    def __str__(self):
        return self.name

# Resident Model
class ResidentModel(models.Model):
    name = models.CharField(max_length=100, blank=False)
    email = models.EmailField(max_length=1000, blank=False)
    contact = models.CharField(max_length=20, blank=False)
    state = models.CharField(max_length=20, blank=False)
    city = models.CharField(max_length=100, blank=False)
    street = models.CharField(max_length=100, blank=False)
    postcode = models.IntegerField(blank=False)
    username = models.CharField(max_length=100, blank=False, unique=True)
    password = models.CharField(max_length=150, blank=False)
    isLeader = models.BooleanField(default=False)
    groupID = models.ForeignKey(NeighborhoodGroupModel, null=True, on_delete=models.SET_NULL)

    def __str__(self):
        return self.name

# Join Request Model
class JoinRequestModel(models.Model):
    residentID = models.OneToOneField(ResidentModel, null=True, on_delete=models.SET_NULL)
    groupID = models.ForeignKey(NeighborhoodGroupModel, null=True, on_delete=models.SET_NULL)