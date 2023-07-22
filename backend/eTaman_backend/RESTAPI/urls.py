from django.urls import path
from RESTAPI import views

urlpatterns = [
    # Test API
    path('testGET/', views.testGetAPI),
    path('testPOST/', views.testPostAPI),
    path('testPUT/<int:id>', views.testPutAPI),
    path('testDELETE/<int:id>', views.testDeleteAPI),

    # Resident API
    path('getResident/', views.getResidentData),
    path('getResidentAll/', views.getAllResidentData),
    path('getAllNeighborhoodGroupResidentData/', views.getAllNeighborhoodGroupResidentData),
    path('registerResident/', views.registerResidentAccount),
    path('updateResident/', views.updateResidentAccount),
    path('loginResident/', views.loginResidentAccount),
    path('logoutResident/', views.logoutResidentAccount),
    path('changeResidentLeader/', views.changeResidentLeader),
    path('kickResident/', views.kickResident),

    # Neigborhood Group API
    path('getJoinRequests/', views.getNeighborhoodGroupJoinRequest),
    path('getAllJoinRequests/', views.getAllNeighborhoodGroupJoinRequest),
    path('getGroup/', views.getNeighborhoodGroup),
    path('getGroupAll/', views.getAllNeighborhoodGroup),
    path('createGroup/', views.createNeighborhoodGroup),
    path('joinGroup/', views.createNeighborhoodGroupJoinRequest),
    path('deleteJoinGroupRequest/', views.deleteNeighborhoodGroupJoinRequest),
    path('handleJoinRequest/', views.approveRejectNeighborhoodGroupJoinRequest),
    path('viewGroupRule/', views.getNeighborhoodGroupRule),
    path('updateGroupRule/', views.updateNeighborhoodGroupRules),
    path('updateGroupName/', views.updateNeighborhoodGroupName),
    path('leaveGroup/', views.leaveNeighborhoodGroup),
    path('getAllNeighborhoodGroupResidents/', views.getAllNeighborhoodGroupResidents),

    # Post API
    path('getPostAll/', views.getAllPost),
    path('getAllNeighborhoodGroupPost/', views.getAllNeighborhoodGroupPost),

    # Crime Post API
    path('createCrimePost/', views.createCrimePost),
    path('updateCrimePost/', views.updateCrimePost),
    path('deleteCrimePost/', views.deleteCrimePost),
    path('createCrimePostComment/', views.createCrimePostComment),
    path('getAllCrimePostComment/', views.getAllCommentsForCrimePost),
    path('updateCrimePostComment/', views.updateCrimePostComment),
    path('deleteCrimePostComment/', views.deleteCrimePostComment),
    path('likeCrimePost/', views.likeCrimePost),
    path('dislikeCrimePost/', views.dislikeCrimePost),

    # Complaint Post API
    path('createComplaintPost/', views.createComplaintPost),
    path('updateComplaintPost/', views.updateComplaintPost),
    path('deleteComplaintPost/', views.deleteComplaintPost),
    path('createComplaintPostComment/', views.createComplaintPostComment),
    path('getAllComplaintPostComment/', views.getAllCommentsForComplaintPost),
    path('updateComplaintPostComment/', views.updateComplaintPostComment),
    path('deleteComplaintPostComment/', views.deleteComplaintPostComment),
    path('likeComplaintPost/', views.likeComplaintPost),
    path('dislikeComplaintPost/', views.dislikeComplaintPost),

    # Event Post API
    path('createEventPost/', views.createEventPost),
    path('updateEventPost/', views.updateEventPost),
    path('deleteEventPost/', views.deleteEventPost),
    path('joinEventPost/', views.joinEventPost),
    path('leaveEventPost/', views.leaveEventPost),
    path('createEventPostComment/', views.createEventPostComment),
    path('getAllEventPostComment/', views.getAllCommentsForEventPost),
    path('updateEventPostComment/', views.updateEventPostComment),
    path('deleteEventPostComment/', views.deleteEventPostComment),
    path('likeEventPost/', views.likeEventPost),
    path('dislikeEventPost/', views.dislikeEventPost),

    # General Post API
    path('createGeneralPost/', views.createGeneralPost),
    path('updateGeneralPost/', views.updateGeneralPost),
    path('deleteGeneralPost/', views.deleteGeneralPost),
    path('createGeneralPostComment/', views.createGeneralPostComment),
    path('getAllGeneralPostComment/', views.getAllCommentsForGeneralPost),
    path('updateGeneralPostComment/', views.updateGeneralPostComment),
    path('deleteGeneralPostComment/', views.deleteGeneralPostComment),
    path('likeGeneralPost/', views.likeGeneralPost),
    path('dislikeGeneralPost/', views.dislikeGeneralPost),

    # Facilities API
    path('registerFacilities/', views.registerNeighborhoodFacilities),
    path('getAllFacilities/', views.getAllFacilitiesForNeighborhoodGroup),
    path('getFacilities/', views.getFacilitiesForNeighborhoodGroup),
    path('bookFacilities/', views.bookNeighborhoodFacilities),
    path('returnFacilities/', views.returnNeighborhoodFacilities),
    path('updateFacilities/', views.updateNeighborhoodFacilities),
    path('deleteFacilities/', views.deleteNeighborhoodFacilities),
]