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
    path('updateResident/', views.updateResidentAccount)
]