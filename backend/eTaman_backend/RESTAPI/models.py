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
    image = models.ImageField(upload_to='images/profile', null=True)
    name = models.CharField(max_length=100, blank=False)
    email = models.EmailField(max_length=1000, blank=False)
    contact = models.CharField(max_length=20, blank=False)
    state = models.CharField(max_length=20, blank=False)
    city = models.CharField(max_length=100, blank=False)
    street = models.CharField(max_length=100, blank=False)
    postcode = models.IntegerField(blank=False)
    userData = models.CharField(max_length=1000, default='{"crimePostLikes": [],"crimePostDislikes": [],"complaintPostLikes": [],"complaintPostDislikes": [],"eventPostLikes": [],"eventPostDislikes": [],"generalPostLikes": [],"generalPostDislikes": []}')
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
    status = models.CharField(max_length=100, blank=False, default="Processing")

# Crime Post Model
class CrimePostModel(models.Model):
    datetime = models.DateTimeField()
    image = models.ImageField(upload_to='images/crime', null=True)
    title = models.CharField(max_length=500, blank=False)
    description = models.CharField(max_length=2000, blank=False)
    actions = models.CharField(max_length=2000, blank=False)
    likes = models.IntegerField(default=0)
    dislikes = models.IntegerField(default=0)
    reporterID = models.ForeignKey(ResidentModel, null=True, on_delete=models.SET_NULL)
    groupID = models.ForeignKey(NeighborhoodGroupModel, null=True, on_delete=models.SET_NULL)

# Crime Post Comment Model
class CrimePostCommentModel(models.Model):
    datetime = models.DateTimeField(auto_now_add=True)
    content = models.CharField(max_length=2000, blank=False)
    postID = models.ForeignKey(CrimePostModel, null=True, on_delete=models.CASCADE)
    authorID = models.ForeignKey(ResidentModel, null=True, on_delete=models.CASCADE)
    groupID = models.ForeignKey(NeighborhoodGroupModel, null=True, on_delete=models.CASCADE)

# Complaint Post Model
class ComplaintPostModel(models.Model):
    datetime = models.DateTimeField(auto_now_add=True)
    image = models.ImageField(upload_to='images/complaint', null=True)
    title = models.CharField(max_length=500, blank=False)
    description = models.CharField(max_length=2000, blank=False)
    target = models.CharField(max_length=100, blank=False)
    isAnonymous = models.BooleanField(default=False)
    likes = models.IntegerField(default=0)
    dislikes = models.IntegerField(default=0)
    reporterID = models.ForeignKey(ResidentModel, null=True, on_delete=models.SET_NULL)
    groupID = models.ForeignKey(NeighborhoodGroupModel, null=True, on_delete=models.SET_NULL)

# Complaint Post Comment Model
class ComplaintPostCommentModel(models.Model):
    datetime = models.DateTimeField(auto_now_add=True)
    content = models.CharField(max_length=2000, blank=False)
    postID = models.ForeignKey(ComplaintPostModel, null=True, on_delete=models.CASCADE)
    authorID = models.ForeignKey(ResidentModel, null=True, on_delete=models.CASCADE)
    groupID = models.ForeignKey(NeighborhoodGroupModel, null=True, on_delete=models.CASCADE)

# Event Post Model
class EventPostModel(models.Model):
    datetime = models.DateTimeField()
    image = models.ImageField(upload_to='images/event', null=True)
    venue = models.CharField(max_length=500, blank=False)
    title = models.CharField(max_length=500, blank=False)
    description = models.CharField(max_length=2000, blank=False)
    participants = models.CharField(max_length=1000, default='')
    likes = models.IntegerField(default=0)
    dislikes = models.IntegerField(default=0)
    organizerID = models.ForeignKey(ResidentModel, null=True, on_delete=models.SET_NULL)
    groupID = models.ForeignKey(NeighborhoodGroupModel, null=True, on_delete=models.SET_NULL)

# Event Post Comment Model
class EventPostCommentModel(models.Model):
    datetime = models.DateTimeField(auto_now_add=True)
    content = models.CharField(max_length=2000, blank=False)
    postID = models.ForeignKey(EventPostModel, null=True, on_delete=models.CASCADE)
    authorID = models.ForeignKey(ResidentModel, null=True, on_delete=models.CASCADE)
    groupID = models.ForeignKey(NeighborhoodGroupModel, null=True, on_delete=models.CASCADE)

# General Post Model
class GeneralPostModel(models.Model):
    datetime = models.DateTimeField(auto_now_add=True)
    image = models.ImageField(upload_to='images/general', null=True)
    title = models.CharField(max_length=500, blank=False)
    description = models.CharField(max_length=2000, blank=False)
    likes = models.IntegerField(default=0)
    dislikes = models.IntegerField(default=0)
    authorID = models.ForeignKey(ResidentModel, null=True, on_delete=models.SET_NULL)
    groupID = models.ForeignKey(NeighborhoodGroupModel, null=True, on_delete=models.SET_NULL)

# General Post Comment Model
class GeneralPostCommentModel(models.Model):
    datetime = models.DateTimeField(auto_now_add=True)
    content = models.CharField(max_length=2000, blank=False)
    postID = models.ForeignKey(GeneralPostModel, null=True, on_delete=models.CASCADE)
    authorID = models.ForeignKey(ResidentModel, null=True, on_delete=models.CASCADE)
    groupID = models.ForeignKey(NeighborhoodGroupModel, null=True, on_delete=models.CASCADE)

# Facilities Model
class FacilitiesModel(models.Model):
    name = models.CharField(max_length=100, blank=False)
    description = models.CharField(max_length=1000, blank=False)
    status = models.CharField(max_length=100, blank=False)
    holder = models.ForeignKey(ResidentModel, null=True, on_delete=models.SET_NULL)
    groupID = models.ForeignKey(NeighborhoodGroupModel, null=True, on_delete=models.SET_NULL)

# Chat Model
class ChatModel(models.Model):
    sender = models.ForeignKey(ResidentModel, related_name='sender', on_delete=models.CASCADE)
    receiver = models.ForeignKey(ResidentModel, related_name='receiver', on_delete=models.CASCADE)
    content = models.CharField(max_length=1000, blank=False)
    previous = models.IntegerField(default=0)