from rest_framework import serializers
from .models import TestModel, ResidentModel, NeighborhoodGroupModel, JoinRequestModel

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
        fields = ('id', 'name', 'state', 'city', 'street', 'postcode')

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