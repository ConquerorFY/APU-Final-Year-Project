import json
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

# Get all resident data within the same neighborhood group
@api_view(['GET'])
def getAllNeighborhoodGroupResidentData(request):
    try:
        # Get Neighborhood Group ID
        groupID = request.data["groupID"]
        groupData = ResidentSerializer(ResidentModel.objects.filter(groupID=groupID), many=True).data
        return JsonResponse({'data': {'message': ALL_RESIDENT_DATA_FOUND, 'list': groupData, 'status': SUCCESS_CODE}}, status=201)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': {'message': RESIDENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)

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

# Get all posts within the same neighborhood group
@api_view(['GET'])
def getAllNeighborhoodGroupPost(request):
    try:
        # Get neighborhood group ID
        groupID = request.data["groupID"]
        # Get all posts data
        crimePostData = CrimePostSerializer(CrimePostModel.objects.filter(reporterID__groupID=groupID), many=True).data     # reporterID__groupID -> the groupID field that is located in the table that is referenced by reporterID (foreign key)
        complaintPostData = ComplaintPostSerializer(ComplaintPostModel.objects.filter(reporterID__groupID=groupID), many=True).data
        eventPostData = EventPostSerializer(EventPostModel.objects.filter(organizerID__groupID=groupID), many=True).data
        generalPostData = GeneralPostSerializer(GeneralPostModel.objects.filter(authorID__groupID=groupID), many=True).data
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

# Get all comments for a specific crime post
@api_view(['GET'])
def getAllCommentsForCrimePost(request):
    try:
        # Get crime post ID
        crimePostID = request.data["crimePostID"]
        # Get all comment data for the specific crime post
        crimePostData = CrimePostCommentModel.objects.filter(postID=crimePostID)
        crimePostCommentData = CrimePostCommentSerializer(crimePostData, many=True).data
        return JsonResponse({'data': {'message': ALL_COMMENTS_FOUND, 'comments': crimePostCommentData}}, status=201)
    except CrimePostCommentModel.DoesNotExist:
        return JsonResponse({'data': {'message': CRIME_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except CrimePostModel.DoesNotExist:
        return JsonResponse({'data': {'message': CRIME_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)

# Get all comments for a specific complaint post
@api_view(['GET'])
def getAllCommentsForComplaintPost(request):
    try:
        # Get complaint post ID
        complaintPostID = request.data["complaintPostID"]
        # Get all comment data for the specific complaint post
        complaintPostData = ComplaintPostCommentModel.objects.filter(postID=complaintPostID)
        complaintPostCommentData = ComplaintPostCommentSerializer(complaintPostData, many=True).data
        return JsonResponse({'data': {'message': ALL_COMMENTS_FOUND, 'comments': complaintPostCommentData}}, status=201)
    except ComplaintPostCommentModel.DoesNotExist:
        return JsonResponse({'data': {'message': COMPLAINT_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ComplaintPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': COMPLAINT_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)

# Get all comments for a specific event post
@api_view(['GET'])
def getAllCommentsForEventPost(request):
    try:
        # Get event post ID
        eventPostID = request.data["eventPostID"]
        # Get all comment data for the specific event post
        eventPostData = EventPostCommentModel.objects.filter(postID=eventPostID)
        eventPostCommentData = EventPostCommentSerializer(eventPostData, many=True).data
        return JsonResponse({'data': {'message': ALL_COMMENTS_FOUND, 'comments': eventPostCommentData}}, status=201)
    except EventPostCommentModel.DoesNotExist:
        return JsonResponse({'data': {'message': EVENT_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except EventPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': EVENT_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)

# Get all comments for a specific general post
@api_view(['GET'])
def getAllCommentsForGeneralPost(request):
    try:
        # Get general post ID
        generalPostID = request.data["generalPostID"]
        # Get all comment data for the specific general post
        generalPostData = GeneralPostCommentModel.objects.filter(postID=generalPostID)
        generalPostCommentData = GeneralPostCommentSerializer(generalPostData, many=True).data
        return JsonResponse({'data': {'message': ALL_COMMENTS_FOUND, 'comments': generalPostCommentData}}, status=201)
    except GeneralPostCommentModel.DoesNotExist:
        return JsonResponse({'data': {'message': GENERAL_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except GeneralPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': GENERAL_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)

# Get all facilities for a specific neighborhood group
@api_view(['GET'])
def getAllFacilitiesForNeighborhoodGroup(request):
    try:
        # Get Neighborhood Group ID
        groupID = request.data["groupID"]
        facilities = FacilitiesModel.objects.filter(groupID=groupID)
        facilitiesData = FacilitiesSerializer(facilities, many=True).data
        return JsonResponse({'data': {'message': ALL_FACILITIES_FOUND, 'list': facilitiesData, 'status': SUCCESS_CODE}}, status=201)
    except FacilitiesModel.DoesNotExist:
        return JsonResponse({'data': {'message': FACILITIES_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except NeighborhoodGroupModel.DoesNotExist:
        return JsonResponse({'data': {'message': NEIGHBORHOOD_GROUP_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)






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

# Like crime post
@api_view(['POST'])
def likeCrimePost(request):
    try:
        # Get resident ID
        residentID = decodeJWTToken(request.data['token'])['id']
        residentData = ResidentModel.objects.get(pk=residentID)
        # Get crime post ID
        crimePostID = request.data['crimePostID']
        crimePostData = CrimePostModel.objects.get(pk=crimePostID)
        # Check whether the resident is within the same neighborhood as the crime post owner
        if crimePostData.reporterID.groupID.id == residentData.groupID.id:
            # Get user data and crime post like count
            residentUserData = json.loads(residentData.userData)
            crimePostLikeCount = crimePostData.likes
            crimePostDislikeCount = crimePostData.dislikes
            if crimePostID not in residentUserData['crimePostLikes']:
                residentUserData['crimePostLikes'].append(crimePostID)
                crimePostLikeCount = crimePostData.likes + 1
            if crimePostID in residentUserData['crimePostDislikes']:
                residentUserData['crimePostDislikes'].remove(crimePostID)
                crimePostDislikeCount = crimePostData.dislikes - 1
            newResidentData = {
                'userData': json.dumps(residentUserData)
            }
            newCrimePostData = {
                'likes': crimePostLikeCount,
                'dislikes': crimePostDislikeCount
            }
            newResident = ResidentSerializer(residentData, data=newResidentData, partial=True)
            newCrimePost = CrimePostSerializer(crimePostData, data=newCrimePostData, partial=True)
            # Check if data is valid
            if newResident.is_valid() and newCrimePost.is_valid():
                newResident.save()
                newCrimePost.save()
                return JsonResponse({'data': {'message': CRIME_POST_UPDATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
        else:
            return JsonResponse({'data': {'message': CRIME_POST_NOT_PART_OF_NEIGHBORHOOD_GROUP, 'status': ERROR_CODE}}, status=400)
    except CrimePostModel.DoesNotExist:
        return JsonResponse({'data': {'message': CRIME_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': {'message': RESIDENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)

# Dislike crime post
@api_view(['POST'])
def dislikeCrimePost(request):
    try:
        # Get resident ID
        residentID = decodeJWTToken(request.data['token'])['id']
        residentData = ResidentModel.objects.get(pk=residentID)
        # Get crime post ID
        crimePostID = request.data['crimePostID']
        crimePostData = CrimePostModel.objects.get(pk=crimePostID)
        # Check whether the resident is within the same neighborhood as the crime post owner
        if crimePostData.reporterID.groupID.id == residentData.groupID.id:
            # Get user data and crime post dislike count
            residentUserData = json.loads(residentData.userData)
            crimePostLikeCount = crimePostData.likes
            crimePostDislikeCount = crimePostData.dislikes
            if crimePostID not in residentUserData['crimePostDislikes']:
                residentUserData['crimePostDislikes'].append(crimePostID)
                crimePostDislikeCount = crimePostData.dislikes + 1
            if crimePostID in residentUserData['crimePostLikes']:
                residentUserData['crimePostLikes'].remove(crimePostID)
                crimePostLikeCount = crimePostData.likes - 1
            newResidentData = {
                'userData': json.dumps(residentUserData)
            }
            newCrimePostData = {
                'likes': crimePostLikeCount,
                'dislikes': crimePostDislikeCount
            }
            newResident = ResidentSerializer(residentData, data=newResidentData, partial=True)
            newCrimePost = CrimePostSerializer(crimePostData, data=newCrimePostData, partial=True)
            # Check if data is valid
            if newResident.is_valid() and newCrimePost.is_valid():
                newResident.save()
                newCrimePost.save()
                return JsonResponse({'data': {'message': CRIME_POST_UPDATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
        else:
            return JsonResponse({'data': {'message': CRIME_POST_NOT_PART_OF_NEIGHBORHOOD_GROUP, 'status': ERROR_CODE}}, status=400)
    except CrimePostModel.DoesNotExist:
        return JsonResponse({'data': {'message': CRIME_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': {'message': RESIDENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)

# Create crime post comment
@api_view(['POST'])
def createCrimePostComment(request):
    try:
        # Get crime post ID
        crimePostID = request.data["crimePostID"]
        crimePostData = CrimePostModel.objects.get(pk=crimePostID)
        # Get resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentID)
        # Check whether resident belongs to the same neighborhood group as the crime post author
        if residentData.groupID.id == crimePostData.reporterID.groupID.id:
            newCrimePostComment = {
                'content': request.data['content'],
                'postID': crimePostID,
                'authorID': residentID
            }
            newCrimePostCommentData = CrimePostCommentSerializer(data = newCrimePostComment)
            # Check whether all data is valid
            if newCrimePostCommentData.is_valid():
                newCrimePostCommentData.save()
                return JsonResponse({'data': {'message': CRIME_POST_COMMENT_CREATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
        else:
            return JsonResponse({'data': {'message': CRIME_POST_COMMENT_NOT_SAME_GROUP, 'status': ERROR_CODE}}, status=400)
    except CrimePostCommentModel.DoesNotExist:
        return JsonResponse({'data': {'message': CRIME_POST_COMMENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
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

# Like complaint post
@api_view(['POST'])
def likeComplaintPost(request):
    try:
        # Get resident ID
        residentID = decodeJWTToken(request.data['token'])['id']
        residentData = ResidentModel.objects.get(pk=residentID)
        # Get complaint post ID
        complaintPostID = request.data['complaintPostID']
        complaintPostData = ComplaintPostModel.objects.get(pk=complaintPostID)
        # Check whether the resident is within the same neighborhood as the complaint post owner
        if complaintPostData.reporterID.groupID.id == residentData.groupID.id:
            # Get user data and complaint post like count
            residentUserData = json.loads(residentData.userData)
            complaintPostLikeCount = complaintPostData.likes
            complaintPostDislikeCount = complaintPostData.dislikes
            if complaintPostID not in residentUserData['complaintPostLikes']:
                residentUserData['complaintPostLikes'].append(complaintPostID)
                complaintPostLikeCount = complaintPostData.likes + 1
            if complaintPostID in residentUserData['complaintPostDislikes']:
                residentUserData['complaintPostDislikes'].remove(complaintPostID)
                complaintPostDislikeCount = complaintPostData.dislikes - 1
            newResidentData = {
                'userData': json.dumps(residentUserData)
            }
            newComplaintPostData = {
                'likes': complaintPostLikeCount,
                'dislikes': complaintPostDislikeCount
            }
            newResident = ResidentSerializer(residentData, data=newResidentData, partial=True)
            newComplaintPost = ComplaintPostSerializer(complaintPostData, data=newComplaintPostData, partial=True)
            # Check if data is valid
            if newResident.is_valid() and newComplaintPost.is_valid():
                newResident.save()
                newComplaintPost.save()
                return JsonResponse({'data': {'message': COMPLAINT_POST_UPDATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
        else:
            return JsonResponse({'data': {'message': COMPLAINT_POST_NOT_PART_OF_NEIGHBORHOOD_GROUP, 'status': ERROR_CODE}}, status=400)
    except ComplaintPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': COMPLAINT_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': {'message': RESIDENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)

# Dislike complaint post
@api_view(['POST'])
def dislikeComplaintPost(request):
    try:
        # Get resident ID
        residentID = decodeJWTToken(request.data['token'])['id']
        residentData = ResidentModel.objects.get(pk=residentID)
        # Get complaint post ID
        complaintPostID = request.data['complaintPostID']
        complaintPostData = ComplaintPostModel.objects.get(pk=complaintPostID)
        # Check whether the resident is within the same neighborhood as the complaint post owner
        if complaintPostData.reporterID.groupID.id == residentData.groupID.id:
            # Get user data and complaint post dislike count
            residentUserData = json.loads(residentData.userData)
            complaintPostLikeCount = complaintPostData.likes
            complaintPostDislikeCount = complaintPostData.dislikes
            if complaintPostID not in residentUserData['complaintPostDislikes']:
                residentUserData['complaintPostDislikes'].append(complaintPostID)
                complaintPostDislikeCount = complaintPostData.dislikes + 1
            if complaintPostID in residentUserData['complaintPostLikes']:
                residentUserData['complaintPostLikes'].remove(complaintPostID)
                complaintPostLikeCount = complaintPostData.likes - 1
            newResidentData = {
                'userData': json.dumps(residentUserData)
            }
            newComplaintPostData = {
                'likes': complaintPostLikeCount,
                'dislikes': complaintPostDislikeCount
            }
            newResident = ResidentSerializer(residentData, data=newResidentData, partial=True)
            newComplaintPost = ComplaintPostSerializer(complaintPostData, data=newComplaintPostData, partial=True)
            # Check if data is valid
            if newResident.is_valid() and newComplaintPost.is_valid():
                newResident.save()
                newComplaintPost.save()
                return JsonResponse({'data': {'message': COMPLAINT_POST_UPDATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
        else:
            return JsonResponse({'data': {'message': COMPLAINT_POST_NOT_PART_OF_NEIGHBORHOOD_GROUP, 'status': ERROR_CODE}}, status=400)
    except ComplaintPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': COMPLAINT_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': {'message': RESIDENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)

# Create complaint post comment
@api_view(['POST'])
def createComplaintPostComment(request):
    try:
        # Get complaint post ID
        complaintPostID = request.data["complaintPostID"]
        complaintPostData = ComplaintPostModel.objects.get(pk=complaintPostID)
        # Get resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentID)
        # Check whether resident belongs to the same neighborhood group as the complaint post author
        if residentData.groupID.id == complaintPostData.reporterID.groupID.id:
            newComplaintPostComment = {
                'content': request.data['content'],
                'postID': complaintPostID,
                'authorID': residentID
            }
            newComplaintPostCommentData = ComplaintPostCommentSerializer(data = newComplaintPostComment)
            # Check whether all data is valid
            if newComplaintPostCommentData.is_valid():
                newComplaintPostCommentData.save()
                return JsonResponse({'data': {'message': COMPLAINT_POST_COMMENT_CREATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
        else:
            return JsonResponse({'data': {'message': COMPLAINT_POST_COMMENT_NOT_SAME_GROUP, 'status': ERROR_CODE}}, status=400)
    except ComplaintPostCommentModel.DoesNotExist:
        return JsonResponse({'data': {'message': COMPLAINT_POST_COMMENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
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

# Like event post
@api_view(['POST'])
def likeEventPost(request):
    try:
        # Get resident ID
        residentID = decodeJWTToken(request.data['token'])['id']
        residentData = ResidentModel.objects.get(pk=residentID)
        # Get event post ID
        eventPostID = request.data['eventPostID']
        eventPostData = EventPostModel.objects.get(pk=eventPostID)
        # Check whether the resident is within the same neighborhood as the event post owner
        if eventPostData.organizerID.groupID.id == residentData.groupID.id:
            # Get user data and event post like count
            residentUserData = json.loads(residentData.userData)
            eventPostLikeCount = eventPostData.likes
            eventPostDislikeCount = eventPostData.dislikes
            if eventPostID not in residentUserData['eventPostLikes']:
                residentUserData['eventPostLikes'].append(eventPostID)
                eventPostLikeCount = eventPostData.likes + 1
            if eventPostID in residentUserData['eventPostDislikes']:
                residentUserData['eventPostDislikes'].remove(eventPostID)
                eventPostDislikeCount = eventPostData.dislikes - 1
            newResidentData = {
                'userData': json.dumps(residentUserData)
            }
            newEventPostData = {
                'likes': eventPostLikeCount,
                'dislikes': eventPostDislikeCount
            }
            newResident = ResidentSerializer(residentData, data=newResidentData, partial=True)
            newEventPost = EventPostSerializer(eventPostData, data=newEventPostData, partial=True)
            # Check if data is valid
            if newResident.is_valid() and newEventPost.is_valid():
                newResident.save()
                newEventPost.save()
                return JsonResponse({'data': {'message': EVENT_POST_UPDATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
        else:
            return JsonResponse({'data': {'message': EVENT_POST_NOT_PART_OF_NEIGHBORHOOD_GROUP, 'status': ERROR_CODE}}, status=400)
    except EventPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': EVENT_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': {'message': RESIDENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)

# Dislike event post
@api_view(['POST'])
def dislikeEventPost(request):
    try:
        # Get resident ID
        residentID = decodeJWTToken(request.data['token'])['id']
        residentData = ResidentModel.objects.get(pk=residentID)
        # Get event post ID
        eventPostID = request.data['eventPostID']
        eventPostData = EventPostModel.objects.get(pk=eventPostID)
        # Check whether the resident is within the same neighborhood as the event post owner
        if eventPostData.organizerID.groupID.id == residentData.groupID.id:
            # Get user data and event post dislike count
            residentUserData = json.loads(residentData.userData)
            eventPostLikeCount = eventPostData.likes
            eventPostDislikeCount = eventPostData.dislikes
            if eventPostID not in residentUserData['eventPostDislikes']:
                residentUserData['eventPostDislikes'].append(eventPostID)
                eventPostDislikeCount = eventPostData.dislikes + 1
            if eventPostID in residentUserData['eventPostLikes']:
                residentUserData['eventPostLikes'].remove(eventPostID)
                eventPostLikeCount = eventPostData.likes - 1
            newResidentData = {
                'userData': json.dumps(residentUserData)
            }
            newEventPostData = {
                'likes': eventPostLikeCount,
                'dislikes': eventPostDislikeCount
            }
            newResident = ResidentSerializer(residentData, data=newResidentData, partial=True)
            newEventPost = EventPostSerializer(eventPostData, data=newEventPostData, partial=True)
            # Check if data is valid
            if newResident.is_valid() and newEventPost.is_valid():
                newResident.save()
                newEventPost.save()
                return JsonResponse({'data': {'message': EVENT_POST_UPDATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
        else:
            return JsonResponse({'data': {'message': EVENT_POST_NOT_PART_OF_NEIGHBORHOOD_GROUP, 'status': ERROR_CODE}}, status=400)
    except EventPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': EVENT_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': {'message': RESIDENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)

# Create event post comment
@api_view(['POST'])
def createEventPostComment(request):
    try:
        # Get event post ID
        eventPostID = request.data["eventPostID"]
        eventPostData = EventPostModel.objects.get(pk=eventPostID)
        # Get resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentID)
        # Check whether resident belongs to the same neighborhood group as the event post author
        if residentData.groupID.id == eventPostData.organizerID.groupID.id:
            newEventPostComment = {
                'content': request.data['content'],
                'postID': eventPostID,
                'authorID': residentID
            }
            newEventPostCommentData = EventPostCommentSerializer(data = newEventPostComment)
            # Check whether all data is valid
            if newEventPostCommentData.is_valid():
                newEventPostCommentData.save()
                return JsonResponse({'data': {'message': EVENT_POST_COMMENT_CREATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
        else:
            return JsonResponse({'data': {'message': EVENT_POST_COMMENT_NOT_SAME_GROUP, 'status': ERROR_CODE}}, status=400)
    except EventPostCommentModel.DoesNotExist:
        return JsonResponse({'data': {'message': EVENT_POST_COMMENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except EventPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': EVENT_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': {'message': RESIDENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)

# Join event post
@api_view(['POST'])
def joinEventPost(request):
    try:
        # Get event post ID
        eventPostID = request.data["eventPostID"]
        eventPostData = EventPostModel.objects.get(pk=eventPostID)
        # Get resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentID)
        # Check whether the resident is within the same neighborhood group
        if eventPostData.organizerID.groupID.id == residentData.groupID.id:
            participantsList = json.loads(eventPostData.participants)
            participantsList.append(residentID)
            newEventPost = {
                'participants': json.dumps(participantsList)
            }
            newEventPostData = EventPostSerializer(eventPostData, data=newEventPost, partial=True)
            # Check whether data is valid
            if newEventPostData.is_valid(raise_exception=True):
                newEventPostData.save()
                return JsonResponse({"data": {'message': EVENT_POST_UPDATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
        else:
            return JsonResponse({'data': {'message': EVENT_POST_NOT_PART_OF_NEIGHBORHOOD_GROUP, 'status': ERROR_CODE}}, status=400)
    except EventPostCommentModel.DoesNotExist:
        return JsonResponse({"data": {'message': EVENT_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': {'message': RESIDENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)

# Leave event post
@api_view(['POST'])
def leaveEventPost(request):
    try:
        # Get event post ID
        eventPostID = request.data["eventPostID"]
        eventPostData = EventPostModel.objects.get(pk=eventPostID)
        # Get resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        # Remove resident ID from the participants list
        participantsList = json.loads(eventPostData.participants)
        participantsList.remove(residentID)
        newEventPost = {
            'participants': json.dumps(participantsList)
        }
        newEventPostData = EventPostSerializer(eventPostData, data=newEventPost, partial=True)
        # Check whether data is valid
        if newEventPostData.is_valid(raise_exception=True):
            newEventPostData.save()
            return JsonResponse({"data": {'message': EVENT_POST_UPDATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
        else:
            # An error has occured
            return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
    except EventPostCommentModel.DoesNotExist:
        return JsonResponse({"data": {'message': EVENT_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
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

# Like general post
@api_view(['POST'])
def likeGeneralPost(request):
    try:
        # Get resident ID
        residentID = decodeJWTToken(request.data['token'])['id']
        residentData = ResidentModel.objects.get(pk=residentID)
        # Get general post ID
        generalPostID = request.data['generalPostID']
        generalPostData = GeneralPostModel.objects.get(pk=generalPostID)
        # Check whether the resident is within the same neighborhood as the general post owner
        if generalPostData.authorID.groupID.id == residentData.groupID.id:
            # Get user data and general post like count
            residentUserData = json.loads(residentData.userData)
            generalPostLikeCount = generalPostData.likes
            generalPostDislikeCount = generalPostData.dislikes
            if generalPostID not in residentUserData['generalPostLikes']:
                residentUserData['generalPostLikes'].append(generalPostID)
                generalPostLikeCount = generalPostData.likes + 1
            if generalPostID in residentUserData['generalPostDislikes']:
                residentUserData['generalPostDislikes'].remove(generalPostID)
                generalPostDislikeCount = generalPostData.dislikes - 1
            newResidentData = {
                'userData': json.dumps(residentUserData)
            }
            newGeneralPostData = {
                'likes': generalPostLikeCount,
                'dislikes': generalPostDislikeCount
            }
            newResident = ResidentSerializer(residentData, data=newResidentData, partial=True)
            newGeneralPost = GeneralPostSerializer(generalPostData, data=newGeneralPostData, partial=True)
            # Check if data is valid
            if newResident.is_valid() and newGeneralPost.is_valid():
                newResident.save()
                newGeneralPost.save()
                return JsonResponse({'data': {'message': GENERAL_POST_UPDATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
        else:
            return JsonResponse({'data': {'message': GENERAL_POST_NOT_PART_OF_NEIGHBORHOOD_GROUP, 'status': ERROR_CODE}}, status=400)
    except GeneralPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': GENERAL_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': {'message': RESIDENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)

# Dislike general post
@api_view(['POST'])
def dislikeGeneralPost(request):
    try:
        # Get resident ID
        residentID = decodeJWTToken(request.data['token'])['id']
        residentData = ResidentModel.objects.get(pk=residentID)
        # Get general post ID
        generalPostID = request.data['generalPostID']
        generalPostData = GeneralPostModel.objects.get(pk=generalPostID)
        # Check whether the resident is within the same neighborhood as the general post owner
        if generalPostData.authorID.groupID.id == residentData.groupID.id:
            # Get user data and general post dislike count
            residentUserData = json.loads(residentData.userData)
            generalPostLikeCount = generalPostData.likes
            generalPostDislikeCount = generalPostData.dislikes
            if generalPostID not in residentUserData['generalPostDislikes']:
                residentUserData['generalPostDislikes'].append(generalPostID)
                generalPostDislikeCount = generalPostData.dislikes + 1
            if generalPostID in residentUserData['generalPostLikes']:
                residentUserData['generalPostLikes'].remove(generalPostID)
                generalPostLikeCount = generalPostData.likes - 1
            newResidentData = {
                'userData': json.dumps(residentUserData)
            }
            newGeneralPostData = {
                'likes': generalPostLikeCount,
                'dislikes': generalPostDislikeCount
            }
            newResident = ResidentSerializer(residentData, data=newResidentData, partial=True)
            newGeneralPost = GeneralPostSerializer(generalPostData, data=newGeneralPostData, partial=True)
            # Check if data is valid
            if newResident.is_valid() and newGeneralPost.is_valid():
                newResident.save()
                newGeneralPost.save()
                return JsonResponse({'data': {'message': GENERAL_POST_UPDATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
        else:
            return JsonResponse({'data': {'message': GENERAL_POST_NOT_PART_OF_NEIGHBORHOOD_GROUP, 'status': ERROR_CODE}}, status=400)
    except GeneralPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': GENERAL_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': {'message': RESIDENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)

# Create general post comment
@api_view(['POST'])
def createGeneralPostComment(request):
    try:
        # Get general post ID
        generalPostID = request.data["generalPostID"]
        generalPostData = GeneralPostModel.objects.get(pk=generalPostID)
        # Get resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentID)
        # Check whether resident belongs to the same neighborhood group as the general post author
        if residentData.groupID.id == generalPostData.authorID.groupID.id:
            newGeneralPostComment = {
                'content': request.data['content'],
                'postID': generalPostID,
                'authorID': residentID
            }
            newGeneralPostCommentData = GeneralPostCommentSerializer(data = newGeneralPostComment)
            # Check whether all data is valid
            if newGeneralPostCommentData.is_valid():
                newGeneralPostCommentData.save()
                return JsonResponse({'data': {'message': GENERAL_POST_COMMENT_CREATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
        else:
            return JsonResponse({'data': {'message': GENERAL_POST_COMMENT_NOT_SAME_GROUP, 'status': ERROR_CODE}}, status=400)
    except GeneralPostCommentModel.DoesNotExist:
        return JsonResponse({'data': {'message': GENERAL_POST_COMMENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except GeneralPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': GENERAL_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': {'message': RESIDENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)

# Register facilities into neighborhood groups
@api_view(['POST'])
def registerNeighborhoodFacilities(request):
    try:
        # Get resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentID)
        # Check whether resident is the resident leader
        if residentData.isLeader:
            groupID = residentData.groupID.id
            newFacilities = {
                'name': request.data['name'],
                'description': request.data['description'],
                'status': 'Available',
                'groupID': groupID
            }
            newFacilitiesData = FacilitiesSerializer(data = newFacilities)
            # Check whether all data is valid
            if newFacilitiesData.is_valid():
                newFacilitiesData.save()
                return JsonResponse({'data': {'message': FACILITIES_CREATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
        else:
            return JsonResponse({'data': {'message': FACILITIES_NOT_RESIDENT_LEADER, 'status': ERROR_CODE}}, status=400)
    except FacilitiesModel.DoesNotExist:
        return JsonResponse({'data': {'message': FACILITIES_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': {'message': RESIDENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)

# Book facilities
@api_view(['POST'])
def bookNeighborhoodFacilities(request):
    try:
        # Get resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentID)
        # Get facilities ID
        facilitiesID = request.data["facilitiesID"]
        facilitiesData = FacilitiesModel.objects.get(pk=facilitiesID)
        # Check whether resident is part of the neighborhood group
        if residentData.groupID.id == facilitiesData.groupID.id:
            bookedFacilities = {
                'holder': residentID,
                'status': 'Occupied'
            }
            bookFacilitiesData = FacilitiesSerializer(facilitiesData, data=bookedFacilities, partial=True)
            if bookFacilitiesData.is_valid():
                bookFacilitiesData.save()
                return JsonResponse({"data": {'message': FACILITIES_UPDATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
        else:
            return JsonResponse({'data': {'message': FACILITIES_NOT_PART_OF_NEIGHBORHOOD_GROUP, 'status': ERROR_CODE}}, status=400)
    except FacilitiesModel.DoesNotExist:
        return JsonResponse({"data": {'message': FACILITIES_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': {'message': RESIDENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)

# Return facilities
@api_view(['POST'])
def returnNeighborhoodFacilities(request):
    try:
        # Get resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentID)
        # Get facilities ID
        facilitiesID = request.data["facilitiesID"]
        facilitiesData = FacilitiesModel.objects.get(pk=facilitiesID)
        # Check whether resident is part of the neighborhood group
        if residentData.groupID.id == facilitiesData.groupID.id:
            bookedFacilities = {
                'holder': None,
                'status': 'Available'
            }
            bookFacilitiesData = FacilitiesSerializer(facilitiesData, data=bookedFacilities, partial=True)
            if bookFacilitiesData.is_valid():
                bookFacilitiesData.save()
                return JsonResponse({"data": {'message': FACILITIES_UPDATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
        else:
            return JsonResponse({'data': {'message': FACILITIES_NOT_PART_OF_NEIGHBORHOOD_GROUP, 'status': ERROR_CODE}}, status=400)
    except FacilitiesModel.DoesNotExist:
        return JsonResponse({"data": {'message': FACILITIES_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': {'message': RESIDENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)

# Change resident leader
@api_view(['POST'])
def changeResidentLeader(request):
    try:
        # Get sender resident ID
        senderID = decodeJWTToken(request.data["token"])['id']
        senderData = ResidentModel.objects.get(pk=senderID)
        # Get target resident ID
        targetID = request.data["targetID"]
        targetData = ResidentModel.objects.get(pk=targetID)
        newSenderData = ResidentSerializer(senderData, data={'isLeader': False}, partial=True)
        newTargetData = ResidentSerializer(targetData, data={'isLeader': True}, partial=True)
        # Check whether data is valid
        if newSenderData.is_valid() and newTargetData.is_valid():
            newSenderData.save()
            newTargetData.save()
            return JsonResponse({'data': {'message': RESIDENT_ACCOUNT_UPDATED, 'status': SUCCESS_CODE}}, status=201)
        else:
            # An error has occured
            return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
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

# Update crime post comment
@api_view(["PATCH"])
def updateCrimePostComment(request):
    try:
        # Get Crime Post Comment ID
        crimePostCommentID = request.data["crimePostCommentID"]
        crimePostCommentData = CrimePostCommentModel.objects.get(pk=crimePostCommentID)
        # Get Resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentID)
        # Check if either the resident is the owner or the resident is the resident leader
        if crimePostCommentData.authorID.id == residentData.id or (crimePostCommentData.authorID.groupID.id == residentData.groupID.id and residentData.isLeader):
            newCrimePostCommentData = CrimePostCommentSerializer(crimePostCommentData, data=request.data, partial=True)
            # Check whether data is valid
            if newCrimePostCommentData.is_valid():
                newCrimePostCommentData.save()
                return JsonResponse({'data': {'message': CRIME_POST_COMMENT_UPDATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
        else:
            # The resident is either not the owner or not the resident leader of the neighborhood group
            return JsonResponse({'data': {'message': CRIME_POST_NOT_OWNER_RESIDENT_LEADER, 'status': ERROR_CODE}}, status=400)
    except CrimePostCommentModel.DoesNotExist:
        return JsonResponse({'data': {'message': CRIME_POST_COMMENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
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

# Update complaint post comment
@api_view(["PATCH"])
def updateComplaintPostComment(request):
    try:
        # Get Complaint Post Comment ID
        complaintPostCommentID = request.data["complaintPostCommentID"]
        complaintPostCommentData = ComplaintPostCommentModel.objects.get(pk=complaintPostCommentID)
        # Get Resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentID)
        # Check if either the resident is the owner or the resident is the resident leader
        if complaintPostCommentData.authorID.id == residentData.id or (complaintPostCommentData.authorID.groupID.id == residentData.groupID.id and residentData.isLeader):
            newComplaintPostCommentData = ComplaintPostCommentSerializer(complaintPostCommentData, data=request.data, partial=True)
            # Check whether data is valid
            if newComplaintPostCommentData.is_valid():
                newComplaintPostCommentData.save()
                return JsonResponse({'data': {'message': COMPLAINT_POST_COMMENT_UPDATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
        else:
            # The resident is either not the owner or not the resident leader of the neighborhood group
            return JsonResponse({'data': {'message': COMPLAINT_POST_NOT_OWNER_RESIDENT_LEADER, 'status': ERROR_CODE}}, status=400)
    except ComplaintPostCommentModel.DoesNotExist:
        return JsonResponse({'data': {'message': COMPLAINT_POST_COMMENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
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

# Update event post comment
@api_view(["PATCH"])
def updateEventPostComment(request):
    try:
        # Get Event Post Comment ID
        eventPostCommentID = request.data["eventPostCommentID"]
        eventPostCommentData = EventPostCommentModel.objects.get(pk=eventPostCommentID)
        # Get Resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentID)
        # Check if either the resident is the owner or the resident is the resident leader
        if eventPostCommentData.authorID.id == residentData.id or (eventPostCommentData.authorID.groupID.id == residentData.groupID.id and residentData.isLeader):
            newEventPostCommentData = EventPostCommentSerializer(eventPostCommentData, data=request.data, partial=True)
            # Check whether data is valid
            if newEventPostCommentData.is_valid():
                newEventPostCommentData.save()
                return JsonResponse({'data': {'message': EVENT_POST_COMMENT_UPDATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
        else:
            # The resident is either not the owner or not the resident leader of the neighborhood group
            return JsonResponse({'data': {'message': COMPLAINT_POST_NOT_OWNER_RESIDENT_LEADER, 'status': ERROR_CODE}}, status=400)
    except EventPostCommentModel.DoesNotExist:
        return JsonResponse({'data': {'message': EVENT_POST_COMMENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
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

# Update general post comment
@api_view(["PATCH"])
def updateGeneralPostComment(request):
    try:
        # Get General Post Comment ID
        generalPostCommentID = request.data["generalPostCommentID"]
        generalPostCommentData = GeneralPostCommentModel.objects.get(pk=generalPostCommentID)
        # Get Resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentID)
        # Check if either the resident is the owner or the resident is the resident leader
        if generalPostCommentData.authorID.id == residentData.id or (generalPostCommentData.authorID.groupID.id == residentData.groupID.id and residentData.isLeader):
            newGeneralPostCommentData = GeneralPostCommentSerializer(generalPostCommentData, data=request.data, partial=True)
            # Check whether data is valid
            if newGeneralPostCommentData.is_valid():
                newGeneralPostCommentData.save()
                return JsonResponse({'data': {'message': GENERAL_POST_COMMENT_UPDATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
        else:
            # The resident is either not the owner or not the resident leader of the neighborhood group
            return JsonResponse({'data': {'message': COMPLAINT_POST_NOT_OWNER_RESIDENT_LEADER, 'status': ERROR_CODE}}, status=400)
    except GeneralPostCommentModel.DoesNotExist:
        return JsonResponse({'data': {'message': GENERAL_POST_COMMENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except GeneralPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': GENERAL_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({"data": {"message": RESIDENT_DATABASE_NOT_EXIST, "status": ERROR_CODE}}, status=404)

# Update facilities
@api_view(['PATCH'])
def updateNeighborhoodFacilities(request):
    try:
        # Get resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentID)
        # Get facilities ID
        facilitiesID = request.data["facilitiesID"]
        facilitiesData = FacilitiesModel.objects.get(pk=facilitiesID)
        # Check whether resident is part of the neighborhood group and is resident leader
        if residentData.groupID.id == facilitiesData.groupID.id and residentData.isLeader:
            newFacilitiesData = FacilitiesSerializer(facilitiesData, data=request.data, partial=True)
            if newFacilitiesData.is_valid():
                newFacilitiesData.save()
                return JsonResponse({"data": {'message': FACILITIES_UPDATED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
            else:
                # An error has occured
                return JsonResponse({'data': {'message': DATABASE_WRITE_ERROR, 'status': ERROR_CODE}}, status=400)
        else:
            return JsonResponse({'data': {'message': FACILITIES_NOT_RESIDENT_LEADER, 'status': ERROR_CODE}}, status=400)
    except FacilitiesModel.DoesNotExist:
        return JsonResponse({"data": {'message': FACILITIES_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': {'message': RESIDENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)






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

# Delete crime post
@api_view(['DELETE'])
def deleteCrimePost(request):
    try:
        # Get Crime Post ID
        crimePostID = request.data["crimePostID"]
        crimePostData = CrimePostModel.objects.get(pk=crimePostID)
        # Get Resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentID)
        # Check if either the resident is the owner or the resident is the resident leader
        if crimePostData.reporterID.id == residentData.id or (crimePostData.reporterID.groupID.id == residentData.groupID.id and residentData.isLeader):
            crimePostData.delete()
            return JsonResponse({'data': {'message': CRIME_POST_DELETED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
        else:
            # The resident is either not the owner or not the resident leader of the neighborhood group
            return JsonResponse({'data': {'message': CRIME_POST_NOT_OWNER_RESIDENT_LEADER, 'status': ERROR_CODE}}, status=400)
    except CrimePostModel.DoesNotExist:
        return JsonResponse({'data': {'message': CRIME_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({"data": {"message": RESIDENT_DATABASE_NOT_EXIST, "status": ERROR_CODE}}, status=404)

# Delete crime post comment
@api_view(['DELETE'])
def deleteCrimePostComment(request):
    try:
        # Get Crime Post Comment ID
        crimePostCommentID = request.data["crimePostCommentID"]
        crimePostCommentData = CrimePostCommentModel.objects.get(pk=crimePostCommentID)
        # Get Resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentID)
        # Check if either the resident is the owner or the resident is the resident leader
        if crimePostCommentData.authorID.id == residentData.id or (crimePostCommentData.authorID.groupID.id == residentData.groupID.id and residentData.isLeader):
            crimePostCommentData.delete()
            return JsonResponse({'data': {'message': CRIME_POST_COMMENT_DELETED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
        else:
            # The resident is either not the owner or not the resident leader of the neighborhood group
            return JsonResponse({'data': {'message': CRIME_POST_NOT_OWNER_RESIDENT_LEADER, 'status': ERROR_CODE}}, status=400)
    except CrimePostCommentModel.DoesNotExist:
        return JsonResponse({'data': {'message': CRIME_POST_COMMENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except CrimePostModel.DoesNotExist:
        return JsonResponse({'data': {'message': CRIME_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({"data": {"message": RESIDENT_DATABASE_NOT_EXIST, "status": ERROR_CODE}}, status=404)

# Delete complaint post
@api_view(['DELETE'])
def deleteComplaintPost(request):
    try:
        # Get Complaint Post ID
        complaintPostID = request.data["complaintPostID"]
        complaintPostData = ComplaintPostModel.objects.get(pk=complaintPostID)
        # Get Resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentID)
        # Check if either the resident is the owner or the resident is the resident leader
        if complaintPostData.reporterID.id == residentData.id or (complaintPostData.reporterID.groupID.id == residentData.groupID.id and residentData.isLeader):
            complaintPostData.delete()
            return JsonResponse({'data': {'message': COMPLAINT_POST_DELETED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
        else:
            # The resident is either not the owner or not the resident leader of the neighborhood group
            return JsonResponse({'data': {'message': COMPLAINT_POST_NOT_OWNER_RESIDENT_LEADER, 'status': ERROR_CODE}}, status=400)
    except ComplaintPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': COMPLAINT_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({"data": {"message": RESIDENT_DATABASE_NOT_EXIST, "status": ERROR_CODE}}, status=404)

# Delete complaint post comment
@api_view(['DELETE'])
def deleteComplaintPostComment(request):
    try:
        # Get Complaint Post Comment ID
        complaintPostCommentID = request.data["complaintPostCommentID"]
        complaintPostCommentData = ComplaintPostCommentModel.objects.get(pk=complaintPostCommentID)
        # Get Resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentID)
        # Check if either the resident is the owner or the resident is the resident leader
        if complaintPostCommentData.authorID.id == residentData.id or (complaintPostCommentData.authorID.groupID.id == residentData.groupID.id and residentData.isLeader):
            complaintPostCommentData.delete()
            return JsonResponse({'data': {'message': COMPLAINT_POST_COMMENT_DELETED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
        else:
            # The resident is either not the owner or not the resident leader of the neighborhood group
            return JsonResponse({'data': {'message': COMPLAINT_POST_NOT_OWNER_RESIDENT_LEADER, 'status': ERROR_CODE}}, status=400)
    except ComplaintPostCommentModel.DoesNotExist:
        return JsonResponse({'data': {'message': COMPLAINT_POST_COMMENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ComplaintPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': COMPLAINT_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({"data": {"message": RESIDENT_DATABASE_NOT_EXIST, "status": ERROR_CODE}}, status=404)

# Delete event post
@api_view(['DELETE'])
def deleteEventPost(request):
    try:
        # Get Event Post ID
        eventPostID = request.data["eventPostID"]
        eventPostData = EventPostModel.objects.get(pk=eventPostID)
        # Get Resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentID)
        # Check if either the resident is the owner or the resident is the resident leader
        if eventPostData.organizerID.id == residentData.id or (eventPostData.organizerID.groupID.id == residentData.groupID.id and residentData.isLeader):
            eventPostData.delete()
            return JsonResponse({'data': {'message': EVENT_POST_DELETED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
        else:
            # The resident is either not the owner or not the resident leader of the neighborhood group
            return JsonResponse({'data': {'message': EVENT_POST_NOT_OWNER_RESIDENT_LEADER, 'status': ERROR_CODE}}, status=400)
    except EventPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': EVENT_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({"data": {"message": RESIDENT_DATABASE_NOT_EXIST, "status": ERROR_CODE}}, status=404)

# Delete event post comment
@api_view(['DELETE'])
def deleteEventPostComment(request):
    try:
        # Get Event Post Comment ID
        eventPostCommentID = request.data["eventPostCommentID"]
        eventPostCommentData = EventPostCommentModel.objects.get(pk=eventPostCommentID)
        # Get Resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentID)
        # Check if either the resident is the owner or the resident is the resident leader
        if eventPostCommentData.authorID.id == residentData.id or (eventPostCommentData.authorID.groupID.id == residentData.groupID.id and residentData.isLeader):
            eventPostCommentData.delete()
            return JsonResponse({'data': {'message': EVENT_POST_COMMENT_DELETED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
        else:
            # The resident is either not the owner or not the resident leader of the neighborhood group
            return JsonResponse({'data': {'message': EVENT_POST_NOT_OWNER_RESIDENT_LEADER, 'status': ERROR_CODE}}, status=400)
    except EventPostCommentModel.DoesNotExist:
        return JsonResponse({'data': {'message': EVENT_POST_COMMENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except EventPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': EVENT_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({"data": {"message": RESIDENT_DATABASE_NOT_EXIST, "status": ERROR_CODE}}, status=404)

# Delete general post
@api_view(['DELETE'])
def deleteGeneralPost(request):
    try:
        # Get General Post ID
        generalPostID = request.data["generalPostID"]
        generalPostData = GeneralPostModel.objects.get(pk=generalPostID)
        # Get Resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentID)
        # Check if either the resident is the owner or the resident is the resident leader
        if generalPostData.authorID.id == residentData.id or (generalPostData.authorID.groupID.id == residentData.groupID.id and residentData.isLeader):
            generalPostData.delete()
            return JsonResponse({'data': {'message': GENERAL_POST_DELETED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
        else:
            # The resident is either not the owner or not the resident leader of the neighborhood group
            return JsonResponse({'data': {'message': GENERAL_POST_NOT_OWNER_RESIDENT_LEADER, 'status': ERROR_CODE}}, status=400)
    except GeneralPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': GENERAL_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({"data": {"message": RESIDENT_DATABASE_NOT_EXIST, "status": ERROR_CODE}}, status=404)

# Delete general post comment
@api_view(['DELETE'])
def deleteGeneralPostComment(request):
    try:
        # Get General Post Comment ID
        generalPostCommentID = request.data["generalPostCommentID"]
        generalPostCommentData = GeneralPostCommentModel.objects.get(pk=generalPostCommentID)
        # Get Resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentID)
        # Check if either the resident is the owner or the resident is the resident leader
        if generalPostCommentData.authorID.id == residentData.id or (generalPostCommentData.authorID.groupID.id == residentData.groupID.id and residentData.isLeader):
            generalPostCommentData.delete()
            return JsonResponse({'data': {'message': GENERAL_POST_COMMENT_DELETED_SUCCESSFUL, 'status': SUCCESS_CODE}}, status=201)
        else:
            # The resident is either not the owner or not the resident leader of the neighborhood group
            return JsonResponse({'data': {'message': GENERAL_POST_NOT_OWNER_RESIDENT_LEADER, 'status': ERROR_CODE}}, status=400)
    except GeneralPostCommentModel.DoesNotExist:
        return JsonResponse({'data': {'message': GENERAL_POST_COMMENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except GeneralPostModel.DoesNotExist:
        return JsonResponse({'data': {'message': GENERAL_POST_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({"data": {"message": RESIDENT_DATABASE_NOT_EXIST, "status": ERROR_CODE}}, status=404)

# Delete facilities
@api_view(['DELETE'])
def deleteNeighborhoodFacilities(request):
    try:
        # Get resident ID
        residentID = decodeJWTToken(request.data["token"])["id"]
        residentData = ResidentModel.objects.get(pk=residentID)
        # Get facilities ID
        facilitiesID = request.data["facilitiesID"]
        facilitiesData = FacilitiesModel.objects.get(pk=facilitiesID)
        # Check whether resident is part of the neighborhood group and is resident leader
        if residentData.groupID.id == facilitiesData.groupID.id and residentData.isLeader:
            facilitiesData.delete()
            return JsonResponse({'data': {'message': FACILITIES_DELETED_SUCCESSFUL, 'status': ERROR_CODE}}, status=201)
        else:
            return JsonResponse({'data': {'message': FACILITIES_NOT_RESIDENT_LEADER, 'status': ERROR_CODE}}, status=400)
    except FacilitiesModel.DoesNotExist:
        return JsonResponse({"data": {'message': FACILITIES_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
    except ResidentModel.DoesNotExist:
        return JsonResponse({'data': {'message': RESIDENT_DATABASE_NOT_EXIST, 'status': ERROR_CODE}}, status=404)
