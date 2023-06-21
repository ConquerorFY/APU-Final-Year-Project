from django.shortcuts import render
from rest_framework.decorators import api_view
from django.http import HttpResponse, JsonResponse
from .models import TestModel
from .serializers import TestSerializer

# Create your views here.

# Test GET API
@api_view(['GET'])
def testGetAPI(request):
    try:
        testList = TestModel.objects.all()
        serializer = TestSerializer(testList, many=True)
        return JsonResponse(serializer.data, safe=False)
    except TestModel.DoesNotExist:
        return JsonResponse({'message': 'The Data is Not Found!'}, status=404)

# Test POST API
@api_view(['POST'])
def testPostAPI(request):
    try:
        serializer = TestSerializer(data = request.data)

        if serializer.is_valid():
            serializer.save()
            return JsonResponse({'message': 'Message has been successfully written to database'}, status=201)

        return JsonResponse({'message': 'An error has occured! Please try again!'}, status=400)
    except TestModel.DoesNotExist:
        return JsonResponse({'message': 'The Data is Not Found!'}, status=404) 

# Test PUT API
@api_view(['PUT'])
def testPutAPI(request, id):
    try:
        testData = TestModel.objects.get(pk=id)
        serializer = TestSerializer(testData, data=request.data)

        if serializer.is_valid():
            serializer.save()
            return JsonResponse({'message': 'Message has been successfully updated in database'}, status=201)

        return JsonResponse({'message': 'An error has occured! Please try again!'}, status=400)
    except TestModel.DoesNotExist:
        return JsonResponse({'message': 'The Data is Not Found!'}, status=404)

# Test DELETE API
@api_view(['DELETE'])
def testDeleteAPI(request, id):
    try:
        testData = TestModel.objects.get(pk=id)
        testData.delete()
        return JsonResponse({'message': 'Message has been successfully deleted from database'}, status=201)
    except TestModel.DoesNotExist:
        return JsonResponse({'message': 'The Data is Not Found!'}, status=404)
