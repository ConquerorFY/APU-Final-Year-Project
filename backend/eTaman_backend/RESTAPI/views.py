from rest_framework.decorators import api_view
from django.http import JsonResponse
from .models import *
from .serializers import *
from .constants import * 
from .password import *
from collections import OrderedDict
from datetime import datetime

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

# Get all neighborhood groups
@api_view(['GET'])
def getAllNeighborhoodGroup(request):
    try:
        groups = NeighborhoodGroupSerializer(NeighborhoodGroupModel.objects.all(), many=True)
        groupsData = groups.data
        return JsonResponse({"data": {"message": ALL_NEIGHBORHOOD_GROUP_FOUND, "list": groupsData, "status": SUCCESS_CODE}}, status=201)
    except NeighborhoodGroupModel.DoesNotExist:
        return JsonResponse({"data": {"message": NEIGHBORHOOD_GROUP_DATABASE_NOT_EXIST, "status": ERROR_CODE}}, status=404)

# Find neighborhood group
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

# Get neighborhood rules (for particular group)
@api_view(['GET'])
def getNeighborhoodGroupRule(request):
    try:
        # Get group ID
        id = request.data['groupId']
        groupData = NeighborhoodGroupModel.objects.get(pk=id)
        rules = groupData.rules
        return JsonResponse({'data': {'message': NEIGHBORHOOD_GROUP_RULE_FOUND, 'rules': rules, 'status': SUCCESS_CODE}}, status=201)
    except NeighborhoodGroupModel.DoesNotExist:
        return JsonResponse({'data': {'message': NEIGHBORHOOD_GROUP_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)

# Get all posts
@api_view(['GET'])
def getAllPost(request):
    try:
        # Get all posts data
        crimePostData = CrimePostSerializer(CrimePostModel.objects.all(), many=True).data
        complaintPostData = ComplaintPostSerializer(ComplaintPostModel.objects.all(), many=True).data
        eventPostData = EventPostSerializer(EventPostModel.objects.all(), many=True).data
        generalPostData = GeneralPostSerializer(GeneralPostModel.objects.all(), many=True).data
        return JsonResponse({
            'data': {
                'message': ALL_POSTS_FOUND,
                'crime': crimePostData,
                'complaint': complaintPostData,
                'event': eventPostData,
                'general': generalPostData
            },
            'status': SUCCESS_CODE
        }, status = 201)
    except CrimePostModel.DoesNotExist:
        return JsonResponse({'data': {'message': CRIME_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ComplaintPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': COMPLAINT_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except EventPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': EVENT_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except GeneralPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': GENERAL_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)



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
        # Check whether all data is valid
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

# Leave neighborhood group
@api_view(['POST'])
def leaveNeighborhoodGroup(request):
    try:
        # Get resident ID
        residentId = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentSerializer(ResidentModel.objects.get(pk=residentId), data={"groupID": None}, partial=True)
        # Check whether all data is valid
        if residentData.is_valid():
            residentData.save()
            return JsonResponse({'data': {'message': RESIDENT_LEAVE_NEIGHBORHOOD_GROUP_SUCCESSUL, 'status': SUCCESS_CODE}}, status=201)
        else:
            # An error has occured
            return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
    except ResidentModel.DoesNotExist:
        return JsonResponse({"data": {"message": RESIDENT_DATABASE_NOT_EXIST, "status": ERROR_CODE}}, status=404)

# Create crime post
@api_view(['POST'])
def createCrimePost(request):
    global datetime
    try:
        # Get resident id
        residentId = decodeJWTToken(request.data["token"])["id"]
        # Get datetime field attributes and values
        date = datetime.strptime(request.data["date"], "%Y-%m-%d").date()
        time = datetime.strptime(request.data["time"], "%H:%M:%S").time()
        dt = datetime.combine(date, time)
        # Get image field attributes and values
        image = request.FILES['image']
        # Create new crime post serializer
        crimeData = {
            'datetime': dt, 
            'image': image, 
            'reporterID': residentId, 
            'title': request.data['title'],
            'description': request.data['description'],
            'actions': request.data['actions']
        }
        crimePostData = CrimePostSerializer(data = crimeData)
        # Check whether all data is valid
        if crimePostData.is_valid():
            crimePostData.save()
            return JsonResponse({'data': {'message': CRIME_POST_CREATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
        else:
            # An error has occured
            return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
    except CrimePostModel.DoesNotExist:
        return JsonResponse({'data': {'message': CRIME_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': {'message': RESIDENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)

# Create complaint post
@api_view(['POST'])
def createComplaintPost(request):
    try:
        # Get resident ID
        residentId = decodeJWTToken(request.data["token"])["id"]
        # Create new complaint post serializer
        complaintData = {
            "target": request.data['target'],
            "title": request.data['title'],
            'description': request.data['description'],
            'reporterID': residentId,
            'isAnonymous': request.data['isAnonymous']
        }
        complaintPostData = ComplaintPostSerializer(data = complaintData)
        # Check whether all data is valid
        if complaintPostData.is_valid():
            complaintPostData.save()
            return JsonResponse({'data': {'message': COMPLAINT_POST_CREATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
        else:
            # An error has occured
            return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
    except ComplaintPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': COMPLAINT_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': {'message': RESIDENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)

# Create event post
@api_view(['POST'])
def createEventPost(request):
    global datetime
    try:
        # Get resident ID
        residentId = decodeJWTToken(request.data["token"])["id"]
        # Get datetime field attributes and values
        date = datetime.strptime(request.data['date'], "%Y-%m-%d").date()
        time = datetime.strptime(request.data['time'], "%H:%M:%S").time()
        dt = datetime.combine(date, time)
        # Create new event post serializer
        eventData = {
            'datetime': dt,
            'venue': request.data['venue'],
            'title': request.data['title'],
            'description': request.data['description'],
            'organizerID': residentId,
            'participants': "[]"
        }
        eventPostData = EventPostSerializer(data = eventData)
        # Check whether all data is valid
        if eventPostData.is_valid():
            eventPostData.save()
            return JsonResponse({'data': {'message': EVENT_POST_CREATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
        else:
            return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
    except EventPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': EVENT_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': {'message': RESIDENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)

# Create general post
@api_view(['POST'])
def createGeneralPost(request):
    try:
        # Get resident ID
        residentId = decodeJWTToken(request.data["token"])["id"]
        # Create  new general post serializer
        generalData = {
            'title': request.data['title'],
            'description': request.data['description'],
            'authorID': residentId
        }
        generalPostData = GeneralPostSerializer(data = generalData)
        # Check whether all data is valid
        if generalPostData.is_valid():
            generalPostData.save()
            return JsonResponse({'data': {'message': GENERAL_POST_CREATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
        else:
            return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
    except GeneralPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': GENERAL_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': {'message': RESIDENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)



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
        id = decodeJWTToken(request.data["token"])["id"]
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

# Update neighborhood group name
@api_view(['PATCH'])
def updateNeighborhoodGroupName(request):
    try:
        # Get neighborhood group ID
        groupId = request.data["groupId"]
        groupData = NeighborhoodGroupModel.objects.get(pk=groupId)
        # Get resident ID
        residentId = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentId)
        # Check whether resident belongs to the group and is the resident leader
        if residentData.groupID.id == groupData.id and residentData.isLeader:
            newGroupData = NeighborhoodGroupSerializer(groupData, data={"name": request.data["name"]}, partial=True)
            # Check whether data is valid
            if newGroupData.is_valid():
                newGroupData.save()
                return JsonResponse({"data": {"message": NEIGHBORHOOD_GROUP_NAME_UPDATED_SUCCESSFUL, "status": SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {"message": DATABASE_WRITE_ERROR}, "status": ERROR_CODE}, status=400)
        else:
            # Not belong to the group or not the leader
            return JsonResponse({'data': {'message': NEIGHBORHOOD_GROUP_NOT_PART_OF_NOT_LEADER, 'status': ERROR_CODE}}, status=400)
    except NeighborhoodGroupModel.DoesNotExist:
        return JsonResponse({'data': {'message': NEIGHBORHOOD_GROUP_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({"data": {"message": RESIDENT_DATABASE_NOT_EXIST, "status": ERROR_CODE}}, status=404)

# Update neighborhood group rules
@api_view(['PATCH'])
def updateNeighborhoodGroupRules(request):
    try:
        # Get neighborhood group ID
        groupId = request.data["groupId"]
        groupData = NeighborhoodGroupModel.objects.get(pk=groupId)
        # Get resident ID
        residentId = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentId)
        # Check whether resident belongs to the group and is the resident leader
        if residentData.groupID.id == groupData.id and residentData.isLeader:
            newGroupData = NeighborhoodGroupSerializer(groupData, data={"rules": request.data["rules"]}, partial=True)
            # Check whether data is valid
            if newGroupData.is_valid():
                newGroupData.save()
                return JsonResponse({"data": {"message": NEIGHBORHOOD_GROUP_RULE_UPDATED_SUCCESSFUL, "status": SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {"message": NEIGHBORHOOD_GROUP_DATABASE_NOT_EXIST, "status": ERROR_CODE}}, status=400)
        else:
            # Not belong to the group or not the leader
            return JsonResponse({'data': {'message': NEIGHBORHOOD_GROUP_NOT_PART_OF_NOT_LEADER, 'status': ERROR_CODE}}, status=400)
    except NeighborhoodGroupModel.DoesNotExist:
        return JsonResponse({"data": {"message": NEIGHBORHOOD_GROUP_DATABASE_NOT_EXIST, "status": ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({"data": {"message": RESIDENT_DATABASE_NOT_EXIST, "status": ERROR_CODE}}, status=404)

# Update crime post
@api_view(['PATCH'])
def updateCrimePost(request):
    try:
        # Get Crime Post ID
        crimePostID = request.data["crimePostID"]
        crimePostData = CrimePostModel.objects.get(pk=crimePostID)
        # Get Resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentID)
        # Check if either the resident is the owner or the resident is the resident leader
        if crimePostData.reporterID.id == residentData.id or (crimePostData.reporterID.groupID.id == residentData.groupID.id and residentData.isLeader):
            newCrimePostData = CrimePostSerializer(crimePostData, data=request.data, partial=True)
            # Check whether data is valid
            if newCrimePostData.is_valid():
                newCrimePostData.save()
                return JsonResponse({'data': {'message': CRIME_POST_UPDATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
        else:
            # The resident is either not the owner or not the resident leader of the neighborhood group
            return JsonResponse({'data': {'message': CRIME_POST_NOT_OWNER_RESIDENT_LEADER, 'status': ERROR_CODE}}, status=400)
    except CrimePostModel.DoesNotExist:
        return JsonResponse({'data': {'message': CRIME_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({"data": {"message": RESIDENT_DATABASE_NOT_EXIST, "status": ERROR_CODE}}, status=404)

# Update complaint post
@api_view(['PATCH'])
def updateComplaintPost(request):
    try:
        # Get Complaint Post ID
        complaintPostID = request.data["complaintPostID"]
        complaintPostData = ComplaintPostModel.objects.get(pk=complaintPostID)
        # Get Resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentID)
        # Check if either the resident is the owner or the resident is the resident leader
        if complaintPostData.reporterID.id == residentData.id or (complaintPostData.reporterID.groupID.id == residentData.groupID.id and residentData.isLeader):
            newComplaintPostData = ComplaintPostSerializer(complaintPostData, data=request.data, partial=True)
            # Check whether data is valid
            if newComplaintPostData.is_valid():
                newComplaintPostData.save()
                return JsonResponse({'data': {'message': COMPLAINT_POST_UPDATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
        else:
            # The resident is either not the owner or not the resident leader of the neighborhood group
            return JsonResponse({'data': {'message': COMPLAINT_POST_NOT_OWNER_RESIDENT_LEADER, 'status': ERROR_CODE}}, status=400)
    except ComplaintPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': COMPLAINT_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({"data": {"message": RESIDENT_DATABASE_NOT_EXIST, "status": ERROR_CODE}}, status=404)

# Update event post
@api_view(['PATCH'])
def updateEventPost(request):
    try:
        # Get Event Post ID
        eventPostID = request.data["eventPostID"]
        eventPostData = EventPostModel.objects.get(pk=eventPostID)
        # Get Resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentID)
        # Check if either the resident is the owner or the resident is the resident leader
        if eventPostData.organizerID.id == residentData.id or (eventPostData.organizerID.groupID.id == residentData.groupID.id and residentData.isLeader):
            newEventPostData = EventPostSerializer(eventPostData, data=request.data, partial=True)
            # Check whether data is valid
            if newEventPostData.is_valid():
                newEventPostData.save()
                return JsonResponse({'data': {'message': EVENT_POST_UPDATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
        else:
            # The resident is either not the owner or not the resident leader of the neighborhood group
            return JsonResponse({'data': {'message': EVENT_POST_NOT_OWNER_RESIDENT_LEADER, 'status': ERROR_CODE}}, status=400)
    except EventPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': EVENT_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({"data": {"message": RESIDENT_DATABASE_NOT_EXIST, "status": ERROR_CODE}}, status=404)

# Update general post
@api_view(['PATCH'])
def updateGeneralPost(request):
    try:
        # Get General Post ID
        generalPostID = request.data["generalPostID"]
        generalPostData = GeneralPostModel.objects.get(pk=generalPostID)
        # Get Resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentID)
        # Check if either the resident is the owner or the resident is the resident leader
        if generalPostData.authorID.id == residentData.id or (generalPostData.authorID.groupID.id == residentData.groupID.id and residentData.isLeader):
            newGeneralPostData = GeneralPostSerializer(generalPostData, data=request.data, partial=True)
            # Check whether data is valid
            if newGeneralPostData.is_valid():
                newGeneralPostData.save()
                return JsonResponse({'data': {'message': GENERAL_POST_UPDATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
        else:
            # The resident is either not the owner or not the resident leader of the neighborhood group
            return JsonResponse({'data': {'message': GENERAL_POST_NOT_OWNER_RESIDENT_LEADER, 'status': ERROR_CODE}}, status=400)
    except GeneralPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': GENERAL_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({"data": {"message": RESIDENT_DATABASE_NOT_EXIST, "status": ERROR_CODE}}, status=404)



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
