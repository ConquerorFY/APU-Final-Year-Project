import json
from urllib.parse import parse_qs
from channels.generic.websocket import WebsocketConsumer
from asgiref.sync import async_to_sync
from .models import *
from .serializers import *
from .constants import * 
from .password import *

class CommentConsumer(WebsocketConsumer):
    def connect(self):
        params = parse_qs(self.scope.get('query_string').decode('utf-8'))
        self.post_id = params.get('postID', [''])[0]
        self.post_type = params.get('postType', [''])[0]
        self.group_name = f"{self.post_type}PostID{self.post_id}"

        async_to_sync(self.channel_layer.group_add) (
            self.group_name,
            self.channel_name   # will be created automatically for each user
        )

        self.accept()

    def receive(self, text_data):
        comment_data_json = json.loads(text_data)
        response_data_json = {}
        # Broadcast message to every user within the same group
        if self.post_type == 'crime':
            response_data_json = self.handleCrimeComments(comment_data_json)
        elif self.post_type == 'complaint':
            response_data_json = self.handleComplaintComments(comment_data_json)
        elif self.post_type == 'event':
            response_data_json = self.handleEventComments(comment_data_json)
        elif self.post_type == 'general':
            response_data_json = self.handleGeneralComments(comment_data_json)
        async_to_sync(self.channel_layer.group_send)(
            self.group_name,
            {   
                'type': 'comment',
                'data': response_data_json['data'],
                'status': response_data_json['status']
            }
        )

    def comment(self, event):
        # Broadcast messages to all channels within the same group
        self.send(text_data=json.dumps({
            'data': event['data'],
            'status': event['status']
        }))

    def disconnect(self, code):
        super().disconnect(code)
        async_to_sync(self.channel_layer.group_discard) (self.group_name, self.channel_name)

    def handleCrimeComments(self, comment_data):
        try:
            # Get crime post ID
            crimePostID = comment_data["crimePostID"]
            crimePostData = CrimePostModel.objects.get(pk=crimePostID)
            # Get resident ID
            residentID = decodeJWTToken(comment_data["token"])["id"]
            residentData = ResidentModel.objects.get(pk=residentID)
            # Check whether resident belongs to the same neighborhood group as the crime post author
            if residentData.groupID.id == crimePostData.reporterID.groupID.id:
                newCrimePostComment = {
                    'content': comment_data['content'],
                    'postID': crimePostID,
                    'authorID': residentID
                }
                newCrimePostCommentData = CrimePostCommentSerializer(data = newCrimePostComment)
                # Check whether all data is valid
                if newCrimePostCommentData.is_valid():
                    newCrimePostCommentData.save()
                    return {'data': {'comment': {**newCrimePostCommentData.data, 'username': residentData.username}}, 'status': SUCCESS_CODE}
                else:
                    # An error has occured
                    return {'data': {'message': DATABASE_WRITE_ERROR}, 'status': ERROR_CODE}
            else:
                return {'data': {'message': CRIME_POST_COMMENT_NOT_SAME_GROUP}, 'status': ERROR_CODE}
        except CrimePostCommentModel.DoesNotExist:
            return {'data': {'message': CRIME_POST_COMMENT_DATABASE_NOT_EXIST}, 'status': ERROR_CODE}
        except CrimePostModel.DoesNotExist:
            return {'data': {'message': CRIME_POST_DATABASE_NOT_EXIST}, 'status': ERROR_CODE}
        except ResidentModel.DoesNotExist:
            return {'data': {'message': RESIDENT_DATABASE_NOT_EXIST}, 'status': ERROR_CODE}

    def handleComplaintComments(self, comment_data):
        try:
            # Get complaint post ID
            complaintPostID = comment_data["complaintPostID"]
            complaintPostData = ComplaintPostModel.objects.get(pk=complaintPostID)
            # Get resident ID
            residentID = decodeJWTToken(comment_data["token"])["id"]
            residentData = ResidentModel.objects.get(pk=residentID)
            # Check whether resident belongs to the same neighborhood group as the complaint post author
            if residentData.groupID.id == complaintPostData.reporterID.groupID.id:
                newComplaintPostComment = {
                    'content': comment_data['content'],
                    'postID': complaintPostID,
                    'authorID': residentID
                }
                newComplaintPostCommentData = ComplaintPostCommentSerializer(data = newComplaintPostComment)
                # Check whether all data is valid
                if newComplaintPostCommentData.is_valid():
                    newComplaintPostCommentData.save()
                    return {'data': {'comment': {**newComplaintPostCommentData.data, 'username': residentData.username}}, 'status': SUCCESS_CODE}
                else:
                    # An error has occured
                    return {'data': {'message': DATABASE_WRITE_ERROR}, 'status': ERROR_CODE}
            else:
                return {'data': {'message': COMPLAINT_POST_COMMENT_NOT_SAME_GROUP}, 'status': ERROR_CODE}
        except ComplaintPostCommentModel.DoesNotExist:
            return {'data': {'message': COMPLAINT_POST_COMMENT_DATABASE_NOT_EXIST}, 'status': ERROR_CODE}
        except ComplaintPostModel.DoesNotExist:
            return {'data': {'message': COMPLAINT_POST_DATABASE_NOT_EXIST}, 'status': ERROR_CODE}
        except ResidentModel.DoesNotExist:
            return {'data': {'message': RESIDENT_DATABASE_NOT_EXIST}, 'status': ERROR_CODE}

    def handleEventComments(self, comment_data):
        try:
            # Get event post ID
            eventPostID = comment_data["eventPostID"]
            eventPostData = EventPostModel.objects.get(pk=eventPostID)
            # Get resident ID
            residentID = decodeJWTToken(comment_data["token"])["id"]
            residentData = ResidentModel.objects.get(pk=residentID)
            # Check whether resident belongs to the same neighborhood group as the event post author
            if residentData.groupID.id == eventPostData.organizerID.groupID.id:
                newEventPostComment = {
                    'content': comment_data['content'],
                    'postID': eventPostID,
                    'authorID': residentID
                }
                newEventPostCommentData = EventPostCommentSerializer(data = newEventPostComment)
                # Check whether all data is valid
                if newEventPostCommentData.is_valid():
                    newEventPostCommentData.save()
                    return {'data': {'comment': {**newEventPostCommentData.data, 'username': residentData.username}}, 'status': SUCCESS_CODE}
                else:
                    # An error has occured
                    return {'data': {'message': DATABASE_WRITE_ERROR}, 'status': ERROR_CODE}
            else:
                return {'data': {'message': EVENT_POST_COMMENT_NOT_SAME_GROUP}, 'status': ERROR_CODE}
        except EventPostCommentModel.DoesNotExist:
            return {'data': {'message': EVENT_POST_COMMENT_DATABASE_NOT_EXIST}, 'status': ERROR_CODE}
        except EventPostModel.DoesNotExist:
            return {'data': {'message': EVENT_POST_DATABASE_NOT_EXIST}, 'status': ERROR_CODE}
        except ResidentModel.DoesNotExist:
            return {'data': {'message': RESIDENT_DATABASE_NOT_EXIST}, 'status': ERROR_CODE}

    def handleGeneralComments(self, comment_data):
        try:
            # Get general post ID
            generalPostID = comment_data["generalPostID"]
            generalPostData = GeneralPostModel.objects.get(pk=generalPostID)
            # Get resident ID
            residentID = decodeJWTToken(comment_data["token"])["id"]
            residentData = ResidentModel.objects.get(pk=residentID)
            # Check whether resident belongs to the same neighborhood group as the general post author
            if residentData.groupID.id == generalPostData.authorID.groupID.id:
                newGeneralPostComment = {
                    'content': comment_data['content'],
                    'postID': generalPostID,
                    'authorID': residentID
                }
                newGeneralPostCommentData = GeneralPostCommentSerializer(data = newGeneralPostComment)
                # Check whether all data is valid
                if newGeneralPostCommentData.is_valid():
                    newGeneralPostCommentData.save()
                    return {'data': {'comment': {**newGeneralPostCommentData.data, 'username': residentData.username}}, 'status': SUCCESS_CODE}
                else:
                    # An error has occured
                    return {'data': {'message': DATABASE_WRITE_ERROR}, 'status': ERROR_CODE}
            else:
                return {'data': {'message': GENERAL_POST_COMMENT_NOT_SAME_GROUP}, 'status': ERROR_CODE}
        except GeneralPostCommentModel.DoesNotExist:
            return {'data': {'message': GENERAL_POST_COMMENT_DATABASE_NOT_EXIST}, 'status': ERROR_CODE}
        except GeneralPostModel.DoesNotExist:
            return {'data': {'message': GENERAL_POST_DATABASE_NOT_EXIST}, 'status': ERROR_CODE}
        except ResidentModel.DoesNotExist:
            return {'data': {'message': RESIDENT_DATABASE_NOT_EXIST}, 'status': ERROR_CODE}