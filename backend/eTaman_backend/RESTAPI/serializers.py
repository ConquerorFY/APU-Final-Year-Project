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
        fields = ('id', 'name', 'email', 'contact', 'state', 'city', 'street', 'postcode', 'username', 'password', 'isLeader', 'groupID')

# Join Request Serializer
class JoinRequestSerializer(serializers.ModelSerializer):
    class Meta:
        model = JoinRequestModel
        fields = ('id', 'residentID', 'groupID')

# Crime Post Serializer
class CrimePostSerializer(serializers.ModelSerializer):
    class Meta:
        model = CrimePostModel
        fields = ('id', 'datetime', 'image', 'title', 'description', 'actions', 'reporterID')

# Complaint Post Serializer
class ComplaintPostSerializer(serializers.ModelSerializer):
    class Meta:
        model = ComplaintPostModel
        fields = ('id', 'datetime', 'title', 'description', 'target', 'isAnonymous', 'reporterID')

# Event Post Serializer
class EventPostSerializer(serializers.ModelSerializer):
    class Meta:
        model = EventPostModel
        fields = ('id', 'date', 'time', 'venue', 'title', 'description', 'participants', 'organizerID')

# General Post Serializer
class GeneralPostSerialiser(serializers.ModelSerializer):
    class Meta:
        model = GeneralPostModel
        fields = ('id', 'datetime', 'title', 'description', 'authorID')