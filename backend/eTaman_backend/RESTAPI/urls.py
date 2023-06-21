from django.urls import path
from RESTAPI import views

urlpatterns = [
    # Test API
    path('testGET/', views.testGetAPI),
    path('testPOST/', views.testPostAPI),
    path('testPUT/<int:id>', views.testPutAPI),
    path('testDELETE/<int:id>', views.testDeleteAPI)
]