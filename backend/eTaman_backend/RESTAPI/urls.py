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
    path('registerResident/', views.registerResidentAccount),
    path('updateResident/', views.updateResidentAccount),
    path('loginResident/', views.loginResidentAccount),
    path('logoutResident/', views.logoutResidentAccount),

    # Neigborhood Group API
    path('getAllJoinRequests/', views.getAllNeighborhoodGroupJoinRequest),
    path('getGroup/', views.getNeighborhoodGroup),
    path('getGroupAll/', views.getAllNeighborhoodGroup),
    path('createGroup/', views.createNeighborhoodGroup),
    path('joinGroup/', views.createNeighborhoodGroupJoinRequest),
    path('handleJoinRequest/', views.approveRejectNeighborhoodGroupJoinRequest),
    path('viewGroupRule/', views.getNeighborhoodGroupRule),
    path('updateGroupRule/', views.updateNeighborhoodGroupRules),
    path('updateGroupName/', views.updateNeighborhoodGroupName),
    path('leaveGroup/', views.leaveNeighborhoodGroup),

    # Post API
    path('getPostAll/', views.getAllPost),

    # Crime Post API
    path('createCrimePost/', views.createCrimePost),
    path('updateCrimePost/', views.updateCrimePost),
    path('deleteCrimePost/', views.deleteCrimePost),
    path('createCrimePostComment/', views.createCrimePostComment),
    path('getAllCrimePostComment/', views.getAllCommentsForCrimePost),

    # Complaint Post API
    path('createComplaintPost/', views.createComplaintPost),
    path('updateComplaintPost/', views.updateComplaintPost),
    path('deleteComplaintPost/', views.deleteComplaintPost),
    path('createComplaintPostComment/', views.createComplaintPostComment),
    path('getAllComplaintPostComment/', views.getAllCommentsForComplaintPost),

    # Event Post API
    path('createEventPost/', views.createEventPost),
    path('updateEventPost/', views.updateEventPost),
    path('deleteEventPost/', views.deleteEventPost),
    path('createEventPostComment/', views.createEventPostComment),
    path('getAllEventPostComment/', views.getAllCommentsForEventPost),

    # General Post API
    path('createGeneralPost/', views.createGeneralPost),
    path('updateGeneralPost/', views.updateGeneralPost),
    path('deleteGeneralPost/', views.deleteGeneralPost),
    path('createGeneralPostComment/', views.createGeneralPostComment),
    path('getAllGeneralPostComment/', views.getAllCommentsForGeneralPost),
]