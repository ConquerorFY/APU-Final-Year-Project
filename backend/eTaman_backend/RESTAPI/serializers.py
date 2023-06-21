from rest_framework import serializers
from .models import TestModel

# Create your serializers here

# Test Serializer
class TestSerializer(serializers.ModelSerializer):
    class Meta:
        model = TestModel 
        fields = ('id', 'name')