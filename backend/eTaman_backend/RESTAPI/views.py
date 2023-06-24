from rest_framework.decorators import api_view
from django.http import JsonResponse
from .models import TestModel, ResidentModel, NeighborhoodGroupModel, JoinRequestModel
from .serializers import TestSerializer, ResidentSerializer, NeighborhoodGroupSerializer, JoinRequestSerializer
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
        return JsonResponse({"data": {"message": ALL_RESIDENT_DATA_FOUND, "list": filteredResidentsData}, "status": SUCCESS_CODE})
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': {"message": RESIDENT_DATABASE_NOT_EXIST}, "status": ERROR_CODE}, status=404)

# Get particular resident information
@api_view(['GET'])
def getResidentData(request):
    try:
        # Get resident ID from JWT
        id = decodeJWTToken(request.data["token"])["id"]
        resident = ResidentSerializer(ResidentModel.objects.get(pk=id))
        residentData = resident.data
        # Filter out password in data entry
        filteredResidentData = dict(filter(lambda item: item[0] != "password", residentData.items()))
        return JsonResponse({"data": {"message": RESIDENT_DATA_FOUND, "list": filteredResidentData}, "status": SUCCESS_CODE}, status=201)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': {"message": RESIDENT_DATABASE_NOT_EXIST}, "status": ERROR_CODE}, status=404)

# Find neighborhood groups
@api_view(['GET'])
def getNeighborhoodGroup(request):
    try:
        # Get neighborhood group using criteria
        state = request.data["state"]
        city = request.data["city"]
        street = request.data["street"]
        postcode = request.data["postcode"]
        neighborhoodGroup = NeighborhoodGroupSerializer(NeighborhoodGroupModel.objects.get(state=state, city=city, street=street, postcode=postcode))
        # Get neighborhood name and id
        name = neighborhoodGroup.data["name"]
        id = neighborhoodGroup.data["id"]
        return JsonResponse({"data": {"message": NEIGHBORHOOD_GROUP_FOUND, "name": name, "id": id}, "status": SUCCESS_CODE}, status=201)
    except NeighborhoodGroupModel.DoesNotExist:
        return JsonResponse({'data': {"message": NEIGHBORHOOD_GROUP_DATABASE_NOT_EXIST}, "status": ERROR_CODE}, status=404)

# Get all neighborhood group join requests (for particular group)
@api_view(['GET'])
def getAllNeighborhoodGroupJoinRequest(request):
    try:
        # Get neighborhood group ID
        id = request.data["id"]
        neighborhoodGroup = NeighborhoodGroupModel.objects.get(id=id)
        # Get all neighborhood group join requests with the same group ID (use filter() instead of get() in this case)
        requestData = JoinRequestSerializer(JoinRequestModel.objects.filter(groupID=neighborhoodGroup), many=True)
        return JsonResponse({"data": {"message": ALL_JOIN_REQUEST_DATA_FOUND, "list": requestData.data, "status": SUCCESS_CODE}}, status=201)
    except JoinRequestModel.DoesNotExist:
        return JsonResponse({"data": {"message": JOIN_REQUEST_DATABASE_NOT_EXIST, "status": ERROR_CODE}}, status=404)
    except NeighborhoodGroupModel.DoesNotExist:
        return JsonResponse({"data": {"message": NEIGHBORHOOD_GROUP_DATABASE_NOT_EXIST, "status": ERROR_CODE}}, status=404)






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
            return JsonResponse({'data': {"message": RESIDENT_USERNAME_TAKEN}, "status": ERROR_CODE}, status=400)
        # Check whether all data is valid
        if residentData.is_valid():
            residentData.save()
            return JsonResponse({'data': {"message": RESIDENT_REGISTER_SUCCESSFUL}, "status": SUCCESS_CODE}, status=201)
        else:
            # An error has occured
            return JsonResponse({'data': {"message": DATABASE_WRITE_ERROR}, "status": ERROR_CODE}, status=400)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': {"message": RESIDENT_DATABASE_NOT_EXIST}, "status": ERROR_CODE}, status=404)

# Login resident account
@api_view(['POST'])
def loginResidentAccount(request):
    try:
        # Get username and password
        username = request.data['username']
        password = request.data['password']
        # Check whether username and password match
        residentData = ResidentSerializer(ResidentModel.objects.get(username=username))
        if decryptPassword(password, residentData.data["password"]):
            token = generateJWTToken({"id": residentData.data["id"]})
            return JsonResponse({"data": {"message": RESIDENT_LOGIN_SUCCESS, "token": token}, "status": SUCCESS_CODE}, status=201)
        return JsonResponse({"data": {"message": RESIDENT_PASSWORD_MISMATCH}, "status": ERROR_CODE}, status=400)
    except ResidentModel.DoesNotExist:
        # If username does not exist
        return JsonResponse({"data": {"message": RESIDENT_USERNAME_NOT_EXIST}, "status": ERROR_CODE}, status=404)

# Logout resident account
@api_view(['POST'])
def logoutResidentAccount(request):
    return JsonResponse({"data": {"message": RESIDENT_LOGOUT_SUCCESS}, "status": SUCCESS_CODE}, status=200)

# Create neighborhood group
@api_view(['POST'])
def createNeighborhoodGroup(request):
    try:
        # Get resident ID from JWT
        id = decodeJWTToken(request.data["token"])["id"]
        resident = ResidentModel.objects.get(pk=id)
        # Serialize neighborhood data
        neighborhoodGroupData = NeighborhoodGroupSerializer(data = request.data)
        # Check whether all data is valid
        if neighborhoodGroupData.is_valid():
            neighborhoodGroupData.save()
            # Update resident data
            resident.isLeader = True
            resident.groupID = NeighborhoodGroupModel.objects.get(name=neighborhoodGroupData.data["name"])
            resident.save()
            return JsonResponse({'data': {"message": NEIGHBORHOOD_GROUP_CREATED_SUCCESSFUL}, "status": SUCCESS_CODE}, status=201)
        else:
            # Neighborhood group name taken
            return JsonResponse({'data': {"message": NEIGHBORHOOD_GROUP_NAME_TAKEN}, "status": ERROR_CODE}, status=400)
    except NeighborhoodGroupModel.DoesNotExist:
        return JsonResponse({'data': {'message': NEIGHBORHOOD_GROUP_DATABASE_NOT_EXIST, "status": ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': {'message': RESIDENT_DATABASE_NOT_EXIST, "status": ERROR_CODE}}, status=404)

# Create neighborhood group join request
@api_view(['POST'])
def createNeighborhoodGroupJoinRequest(request):
    try:
        # Get resident id and neighborhood group id
        residentId = decodeJWTToken(request.data["token"])["id"]
        groupId = request.data["groupId"]
        # Serialize request data
        requestData = JoinRequestSerializer(data = {"residentID": residentId, "groupID": groupId})
        # Check whether all datga is valid
        if requestData.is_valid():
            requestData.save()
            return JsonResponse({'data': {"message": JOIN_REQUEST_CREATED_SUCCESSFUL, "status": SUCCESS_CODE}}, status=201)
        else:
            # An existing request already exists
            return JsonResponse({"data": {"message": JOIN_REQUEST_ALREADY_EXIST, "status": ERROR_CODE}}, status=400)
    except NeighborhoodGroupModel.DoesNotExist:
        return JsonResponse({"data": {"message": NEIGHBORHOOD_GROUP_DATABASE_NOT_EXIST, "status": ERROR_CODE}}, status=404)

# Approve / Reject neighborhood group join request
@api_view(['POST'])
def approveRejectNeighborhoodGroupJoinRequest(request):
    try:
        # Get action
        action = request.data["action"]
        # Get Neighborhood Group Join Request ID
        requestId = request.data["id"]
        requestData = JoinRequestModel.objects.get(id=requestId)
        if action == "approve":
            # Update resident group ID
            residentData = requestData.residentID
            groupData = requestData.groupID
            residentData.groupID = groupData
            # Update resident data
            residentData.save()
            # Delete request data
            requestData.delete()
            return JsonResponse({'data': {"message": JOIN_REQUEST_APPROVED_SUCCESSFULLY, "status": SUCCESS_CODE}}, status=201)
        elif action == "reject":
            # Delete request data
            requestData.delete()
            return JsonResponse({'data': {"message": JOIN_REQUEST_REJECTED_SUCCESSFULLY, "status": SUCCESS_CODE}}, status=201)
    except JoinRequestModel.DoesNotExist:
        return JsonResponse({"data": {"message": JOIN_REQUEST_DATABASE_NOT_EXIST, "status": ERROR_CODE}}, status=404)



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
            return JsonResponse({'data': {"message": RESIDENT_ACCOUNT_UPDATED}, "status": SUCCESS_CODE}, status=201)
        else:
            # An error has occured
            return JsonResponse({'data': {"message": DATABASE_WRITE_ERROR}, "status": ERROR_CODE}, status=400)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': {"message": RESIDENT_DATABASE_NOT_EXIST}, "status": ERROR_CODE}, status=404)






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
