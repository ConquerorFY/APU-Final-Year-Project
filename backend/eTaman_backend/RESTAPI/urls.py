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
]