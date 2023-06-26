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

# Crime Post Model
class CrimePostModel(models.Model):
    datetime = models.DateTimeField()
    image = models.ImageField(upload_to='images/')
    title = models.CharField(max_length=500, blank=False)
    description = models.CharField(max_length=2000, blank=False)
    actions = models.CharField(max_length=2000, blank=False)
    reporterID = models.ForeignKey(ResidentModel, null=True, on_delete=models.SET_NULL)

# Complaint Post Model
class ComplaintPostModel(models.Model):
    datetime = models.DateTimeField(auto_now_add=True)
    title = models.CharField(max_length=500, blank=False)
    description = models.CharField(max_length=2000, blank=False)
    target = models.CharField(max_length=100, blank=False)
    isAnonymous = models.BooleanField(default=False)
    reporterID = models.ForeignKey(ResidentModel, null=True, on_delete=models.SET_NULL)

# Event Post Model
class EventPostModel(models.Model):
    datetime = models.DateTimeField()
    venue = models.CharField(max_length=500, blank=False)
    title = models.CharField(max_length=500, blank=False)
    description = models.CharField(max_length=2000, blank=False)
    participants = models.CharField(max_length=1000, default='')
    organizerID = models.ForeignKey(ResidentModel, null=True, on_delete=models.SET_NULL)

# General Post Model
class GeneralPostModel(models.Model):
    datetime = models.DateTimeField(auto_now_add=True)
    title = models.CharField(max_length=500, blank=False)
    description = models.CharField(max_length=2000, blank=False)
    authorID = models.ForeignKey(ResidentModel, null=True, on_delete=models.SET_NULL)
