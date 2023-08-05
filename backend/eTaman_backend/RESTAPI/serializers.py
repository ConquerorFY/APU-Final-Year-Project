from rest_framework import serializers
from .models import *

# Create your serializers here.

# Test Serializer
class TestSerializer(serializers.ModelSerializer):
    class Meta:
        model = TestModel 
        fields = ('id', 'name')

# Neighborhood Group Serializer
class NeighborhoodGroupSerializer(serializers.ModelSerializer):
    class Meta:
        model = NeighborhoodGroupModel
        fields = ('id', 'name', 'state', 'city', 'street', 'postcode', 'rules')

# Resident Serializer
class ResidentSerializer(serializers.ModelSerializer):
    class Meta:
        model = ResidentModel
        fields = ('id', 'image', 'name', 'email', 'contact', 'state', 'city', 'street', 'postcode', 'username', 'password', 'isLeader', 'groupID', 'userData')

# Join Request Serializer
class JoinRequestSerializer(serializers.ModelSerializer):
    class Meta:
        model = JoinRequestModel
        fields = ('id', 'residentID', 'groupID')

# Crime Post Serializer
class CrimePostSerializer(serializers.ModelSerializer):
    class Meta:
        model = CrimePostModel
        fields = ('id', 'datetime', 'image', 'title', 'description', 'actions', 'likes', 'dislikes', 'reporterID')

# Crime Post Comment Serializer
class CrimePostCommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = CrimePostCommentModel
        fields = ('id', 'datetime', 'content', 'postID', 'authorID')

# Complaint Post Serializer
class ComplaintPostSerializer(serializers.ModelSerializer):
    class Meta:
        model = ComplaintPostModel
        fields = ('id', 'datetime', 'image', 'title', 'description', 'target', 'likes', 'dislikes', 'isAnonymous', 'reporterID')

# Complaint Post Comment Serializer
class ComplaintPostCommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = ComplaintPostCommentModel
        fields = ('id', 'datetime', 'content', 'postID', 'authorID')

# Event Post Serializer
class EventPostSerializer(serializers.ModelSerializer):
    class Meta:
        model = EventPostModel
        fields = ('id', 'datetime', 'image', 'venue', 'title', 'description', 'likes', 'dislikes', 'participants', 'organizerID')

# EVent Post Comment Serializer
class EventPostCommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = EventPostCommentModel
        fields = ('id', 'datetime', 'content', 'postID', 'authorID')

# General Post Serializer
class GeneralPostSerializer(serializers.ModelSerializer):
    class Meta:
        model = GeneralPostModel
        fields = ('id', 'datetime', 'image', 'title', 'description', 'likes', 'dislikes', 'authorID')

# General Post Comment Serializer
class GeneralPostCommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = GeneralPostCommentModel
        fields = ('id', 'datetime', 'content', 'postID', 'authorID')

# Facilities Serializer
class FacilitiesSerializer(serializers.ModelSerializer):
    class Meta:
        model = FacilitiesModel
        fields = ('id', 'name', 'description', 'status', 'holder', 'groupID')

# Chat Serializer
class ChatSerializer(serializers.ModelSerializer):
    class Meta:
        model = ChatModel
        fields = ('id', 'sender', 'receiver', 'content', 'previous')