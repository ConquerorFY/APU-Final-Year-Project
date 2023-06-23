from rest_framework.decorators import api_view
from django.http import JsonResponse
from .models import TestModel, ResidentModel, NeighborhoodGroupModel
from .serializers import TestSerializer, ResidentSerializer, NeighborhoodGroupSerializer
from .constants import * 
from .password import *
from collections import OrderedDict

# Create your views here.

####################################################
#    _____ ______ _______            _____ _____   #
#   / ____|  ____|__   __|     /\   |  __ \_   _|  #
#  | |  __| |__     | |       /  \  | |__) || |    # 
#  | | |_ |  __|    | |      / /\ \ |  ___/ | |    #
#  | |__| | |____   | |     / ____ \| |    _| |_   #
#   \_____|______|  |_|    /_/    \_\_|   |_____|  #
#                                                  #
####################################################

# Test API
@api_view(['GET'])
def testGetAPI(request):
    try:
        testList = TestModel.objects.all()
        serializer = TestSerializer(testList, many=True)
        return JsonResponse(serializer.data, safe=False)
    except TestModel.DoesNotExist:
        return JsonResponse({'message': 'The Data is Not Found!'}, status=404)

# Get all resident data
@api_view(['GET'])
def getAllResidentData(request):
    try:
        residents = ResidentSerializer(ResidentModel.objects.all(), many=True)
        residentsData = residents.data
        filteredResidentsData = []
        # Filter out password in all data entries
        for i in range(len(residentsData)):
            filteredResidentsData.append(OrderedDict((key, value) for key, value in residentsData[i].items() if key != "password"))
        return JsonResponse({"data": filteredResidentsData, "status": SUCCESS_CODE}, safe=False)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': RESIDENT_DATABASE_NOT_EXIST, "status": ERROR_CODE}, status=404)

# Get particular resident information
@api_view(['GET'])
def getResidentData(request):
    try:
        # Get resident ID
        id = request.data["id"]
        resident = ResidentSerializer(ResidentModel.objects.get(pk=id))
        residentData = resident.data
        # Filter out password in data entry
        filteredResidentData = dict(filter(lambda item: item[0] != "password", residentData.items()))
        return JsonResponse({"data": filteredResidentData, "status": SUCCESS_CODE}, status=201)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': RESIDENT_DATABASE_NOT_EXIST, "status": ERROR_CODE}, status=404)




###########################################################
#   _____   ____   _____ _______            _____ _____   #
#  |  __ \ / __ \ / ____|__   __|     /\   |  __ \_   _|  #
#  | |__) | |  | | (___    | |       /  \  | |__) || |    #
#  |  ___/| |  | |\___ \   | |      / /\ \ |  ___/ | |    #
#  | |    | |__| |____) |  | |     / ____ \| |    _| |_   #
#  |_|     \____/|_____/   |_|    /_/    \_\_|   |_____|  #
#                                                         #
###########################################################

# Test API
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

# Register resident account
@api_view(['POST'])
def registerResidentAccount(request):
    try:
        # Encrypt password
        request.data['password'] = encryptPassword(request.data['password'])
        # Set isLeader and groupID to defaults (False and 0)
        request.data['isLeader'] = DEFAULT_RESIDENT_LEADER_STATUS
        request.data['groupID'] = DEFAULT_NEW_RESIDENT_GROUP_ID
        residentData = ResidentSerializer(data = request.data)
        # Check whether username has been taken
        username = residentData.initial_data['username']
        if ResidentModel.objects.filter(username=username).exists():
            return JsonResponse({'data': RESIDENT_USERNAME_TAKEN, "status": ERROR_CODE}, status=400)
        # Check whether all data is valid
        if residentData.is_valid():
            residentData.save()
            return JsonResponse({'data': RESIDENT_REGISTER_SUCCESSFUL, "status": SUCCESS_CODE}, status=201)
        else:
            # An error has occured
            return JsonResponse({'data': DATABASE_WRITE_ERROR, "status": ERROR_CODE}, status=400)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': RESIDENT_DATABASE_NOT_EXIST, "status": ERROR_CODE}, status=404)

# Login resident account
@api_view(['POST'])
def loginResidentAccount(request):
    pass




#############################################################
#   _____     _______ _____ _    _            _____ _____   #
#  |  __ \ /\|__   __/ ____| |  | |     /\   |  __ \_   _|  #
#  | |__) /  \  | | | |    | |__| |    /  \  | |__) || |    #
#  |  ___/ /\ \ | | | |    |  __  |   / /\ \ |  ___/ | |    #
#  | |  / ____ \| | | |____| |  | |  / ____ \| |    _| |_   #
#  |_| /_/    \_\_|  \_____|_|  |_| /_/    \_\_|   |_____|  #
#                                                           #
#############################################################

# Test API
@api_view(['PATCH'])
def testPutAPI(request, id):
    try:
        testData = TestModel.objects.get(pk=id)
        serializer = TestSerializer(testData, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse({'message': 'Message has been successfully updated in database'}, status=201)
        return JsonResponse({'message': 'An error has occured! Please try again!'}, status=400)
    except TestModel.DoesNotExist:
        return JsonResponse({'message': 'The Data is Not Found!'}, status=404)

# Update resident account
@api_view(['PATCH'])
def updateResidentAccount(request):
    try:
        # Get resident ID
        id = request.data["id"]
        residentData = ResidentSerializer(ResidentModel.objects.get(pk=id), data=request.data, partial=True)
        # Check whether data is valid
        if residentData.is_valid():
            residentData.save()
            return JsonResponse({'data': RESIDENT_ACCOUNT_UPDATED, "status": SUCCESS_CODE}, status=201)
        else:
            # An error has occured
            return JsonResponse({'data': DATABASE_WRITE_ERROR, "status": ERROR_CODE}, status=400)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': RESIDENT_DATABASE_NOT_EXIST, "status": ERROR_CODE}, status=404)




#########################################################################
#   _____  ______ _      ______ _______ ______            _____ _____   #
#  |  __ \|  ____| |    |  ____|__   __|  ____|     /\   |  __ \_   _|  #
#  | |  | | |__  | |    | |__     | |  | |__       /  \  | |__) || |    #
#  | |  | |  __| | |    |  __|    | |  |  __|     / /\ \ |  ___/ | |    #
#  | |__| | |____| |____| |____   | |  | |____   / ____ \| |    _| |_   #
#  |_____/|______|______|______|  |_|  |______| /_/    \_\_|   |_____|  #
#                                                                       #
#########################################################################

# Test API
@api_view(['DELETE'])
def testDeleteAPI(request, id):
    try:
        testData = TestModel.objects.get(pk=id)
        testData.delete()
        return JsonResponse({'message': 'Message has been successfully deleted from database'}, status=201)
    except TestModel.DoesNotExist:
        return JsonResponse({'message': 'The Data is Not Found!'}, status=404)
