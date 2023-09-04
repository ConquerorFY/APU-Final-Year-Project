import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'logging.dart';

class ApiService {
  // Create Singleton instance
  ApiService._();
  static final ApiService _instance = ApiService._();
  factory ApiService() => _instance;

  // Logger
  EtamanLogger logger = EtamanLogger(); // logger

  final baseUrl = "http://localhost:8000/api";
  final mediaUrl = "http://localhost:8000";
  final wsUrl = "ws://localhost:8000/ws";
  // final baseUrl = "http://13.92.190.149:8000/api";
  // final mediaUrl = "http://13.92.190.149:8000";
  // final wsUrl = "ws://13.92.190.149:8000/ws";

  // Register Resident Account API
  dynamic registerAccountAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/registerResident/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Register Account - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Register Account - $e");
      return null;
    }
  }

  // Login Resident Account API
  dynamic loginAccountAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/loginResident/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Login Account - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Login Account - $e");
      return null;
    }
  }

  // Get Resident Account Data API
  dynamic getResidentDataAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/getResident/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Get Resident Data - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Get Resident Data - $e");
      return null;
    }
  }

  // Logout Resident Account API
  dynamic logoutAccountAPI() async {
    try {
      final url = Uri.parse("$baseUrl/logoutResident/");
      final response = await post(url);
      final responseData = jsonDecode(response.body);

      logger.info("Logout Resident Account - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Logout Resident Account - $e");
      return null;
    }
  }

  // Get All Neighborhood Groups API
  dynamic getAllNeighborhoodGroupsAPI() async {
    try {
      final url = Uri.parse("$baseUrl/getGroupAll/");

      final response = await get(url);
      final responseData = jsonDecode(response.body);

      logger.info("Get All Neighborhood Groups - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Get All Neighborhood Groups - $e");
      return null;
    }
  }

  // Create Neighborhood Group API
  dynamic createNeighborhoodGroupAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/createGroup/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Create Neighborhood Group - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Create Neighborhood Group - $e");
      return null;
    }
  }

  // Get All Neighborhood Groups Join Requests API
  dynamic getAllNeighborhoodGroupsJoinRequestAPI() async {
    try {
      final url = Uri.parse("$baseUrl/getAllJoinRequests/");

      final response = await get(url);
      final responseData = jsonDecode(response.body);

      logger.info("Get All Neighborhood Groups Join Requests - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Get All Neighborhood Groups Join Requests - $e");
      return null;
    }
  }

  // Submit Join Neighborhood Group Request API
  dynamic submitJoinGroupRequestAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/joinGroup/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Submit Join Neighborhood Group Request - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Submit Join Neighborhood Group Request - $e");
      return null;
    }
  }

  // Delete Join Neighborhood Group Request API
  dynamic deleteJoinGroupRequestAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/deleteJoinGroupRequest/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await delete(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Delete Join Neighborhood Group Request - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Delete Join Neighborhood Group Request - $e");
      return null;
    }
  }

  // Leave Neighborhood Group API
  dynamic leaveGroupAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/leaveGroup/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Leave Neighborhood Group - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Leave Neighborhood Group - $e");
      return null;
    }
  }

  // Get All Residents Within Same Neighborhood Group API
  dynamic getAllNeighborhoodResidentsAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/getAllNeighborhoodGroupResidents/");
      final headers = {'Content-Type': "application/json"};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Get All Neighborhood Group Residents - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Get All Neighborhood Group Residents - $e");
      return null;
    }
  }

  // Update Neighborhood Group Rules API
  dynamic updateNeighborhoodGroupRuleAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/updateGroupRule/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await patch(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Update Neighborhood Group Rules - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Update Neighborhood Group Rules - $e");
      return null;
    }
  }

  // Update Neighborhood Group Name API
  dynamic updateNeighborhoodGroupNameAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/updateGroupName/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await patch(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Update Neighborhood Group Name - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Update Neighborhood Group Name - $e");
      return null;
    }
  }

  // Change Resident Leader API
  dynamic changeResidentLeaderAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/changeResidentLeader/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Change Resident Leader - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Change Resident Leader - $e");
      return null;
    }
  }

  // Kick Resident API
  dynamic kickResidentAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/kickResident/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Kick Resident - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Kick Resident - $e");
      return null;
    }
  }

  // Get All Neighborhood Group Join Requests
  dynamic getAllNeighborhoodGroupJoinRequestsAPI() async {
    try {
      final url = Uri.parse("$baseUrl/getAllJoinRequests/");

      final response = await get(url);
      final responseData = jsonDecode(response.body);

      logger.info("Get All Neighborhood Group Join Requests - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Get All Neighborhood Group Join Requests - $e");
      return null;
    }
  }

  // Handle Neighborhood Group Join Request
  dynamic handleNeighborhoodGroupJoinRequestAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/handleJoinRequest/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Handle Neighborhood Group Join Request - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Handle Neighborhood Group Join Request - $e");
      return null;
    }
  }

  // Delete Rejected Neighborhood Group Join Request
  dynamic deleteRejectedNeighborhoodGroupJoinRequestAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/deleteRejectedJoinGroupRequest/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info(
          "Delete Rejected Neighborhood Group Join Request - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Delete Rejected Neighborhood Group Join Request - $e");
      return null;
    }
  }

  // Get All Neighborhood Group Posts API
  dynamic getAllPostsAPI() async {
    try {
      final url = Uri.parse("$baseUrl/getPostAll/");

      final response = await get(url);
      final responseData = jsonDecode(response.body);

      logger.info("Get All Posts - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Get All Posts - $e");
      return null;
    }
  }

  // Get All Posts Within Same Neighborhood Group API
  dynamic getAllNeighborhoodPostsAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/getAllNeighborhoodGroupPost/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Get All Neighborhood Posts - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Get All Neighborhood Posts - $e");
      return null;
    }
  }

  // Submit Crime Post
  dynamic submitCrimePostAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/createCrimePost/");
      final request = MultipartRequest('POST', url);

      body.forEach((key, value) {
        if (key != 'image') {
          request.fields[key] = value;
        }
      });

      File image = body['image'] as File;
      var stream = ByteStream(image.openRead());
      var length = await image.length();
      var multipartFile = MultipartFile('image', stream, length,
          filename: '${request.fields['title']}.jpg');
      request.files.add(multipartFile);

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);

      logger.info("Submit Crime Post - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Submit Crime Post - $e");
      return null;
    }
  }

  // Get All Crime Post Comments API
  dynamic getAllCrimePostCommentsAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/getAllCrimePostComment/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Get All Crime Post Comments - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Get All Crime Post Comments - $e");
      return null;
    }
  }

  // Submit Crime Post Comment API
  dynamic submitCrimePostCommentAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/createCrimePostComment/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Submit Crime Post Comment - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Submit Crime Post Comment - $e");
      return null;
    }
  }

  // Like Crime Post API
  dynamic likeCrimePostAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/likeCrimePost/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Like Crime Post - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Like Crime Post - $e");
      return null;
    }
  }

  // Dislike Crime Post API
  dynamic dislikeCrimePostAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/dislikeCrimePost/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Dislike Crime Post - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Dislike Crime Post - $e");
      return null;
    }
  }

  // Submit Complaint Post
  dynamic submitComplaintPostAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/createComplaintPost/");
      final request = MultipartRequest('POST', url);

      body.forEach((key, value) {
        if (key != 'image') {
          request.fields[key] = value;
        }
      });

      File image = body['image'] as File;
      var stream = ByteStream(image.openRead());
      var length = await image.length();
      var multipartFile = MultipartFile('image', stream, length,
          filename: '${request.fields['title']}.jpg');
      request.files.add(multipartFile);

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);

      logger.info("Submit Complaint Post - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Submit Complaint Post - $e");
      return null;
    }
  }

  // Get All Complaint Post Comments API
  dynamic getAllComplaintPostCommentsAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/getAllComplaintPostComment/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Get All Complaint Post Comments - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Get All Complaint Post Comments - $e");
      return null;
    }
  }

  // Submit Complaint Post Comment API
  dynamic submitComplaintPostCommentAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/createComplaintPostComment/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Submit Complaint Post Comment - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Submit Complaint Post Comment - $e");
      return null;
    }
  }

  // Like Complaint Post API
  dynamic likeComplaintPostAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/likeComplaintPost/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Like Complaint Post - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Like Complaint Post - $e");
      return null;
    }
  }

  // Dislike Complaint Post API
  dynamic dislikeComplaintPostAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/dislikeComplaintPost/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Dislike Complaint Post - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Dislike Complaint Post - $e");
      return null;
    }
  }

  // Submit Event Post
  dynamic submitEventPostAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/createEventPost/");
      final request = MultipartRequest('POST', url);

      body.forEach((key, value) {
        if (key != 'image') {
          request.fields[key] = value;
        }
      });

      File image = body['image'] as File;
      var stream = ByteStream(image.openRead());
      var length = await image.length();
      var multipartFile = MultipartFile('image', stream, length,
          filename: '${request.fields['title']}.jpg');
      request.files.add(multipartFile);

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);

      logger.info("Submit Event Post - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Submit Event Post - $e");
      return null;
    }
  }

  // Get All Event Post Comments API
  dynamic getAllEventPostCommentsAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/getAllEventPostComment/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Get All Event Post Comments - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Get All Event Post Comments - $e");
      return null;
    }
  }

  // Submit Event Post Comment API
  dynamic submitEventPostCommentAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/createEventPostComment/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Submit Event Post Comment - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Submit Event Post Comment - $e");
      return null;
    }
  }

  // Like Event Post API
  dynamic likeEventPostAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/likeEventPost/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Like Event Post - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Like Event Post - $e");
      return null;
    }
  }

  // Dislike Event Post API
  dynamic dislikeEventPostAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/dislikeEventPost/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Dislike Event Post - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Dislike Event Post - $e");
      return null;
    }
  }

  // Join Event Post API
  dynamic joinEventPostAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/joinEventPost/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Join Event Post - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Join Event Post - $e");
      return null;
    }
  }

  // Leave Event Post API
  dynamic leaveEventPostAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/leaveEventPost/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Leave Event Post - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Leave Event Post - $e");
      return null;
    }
  }

  // Submit General Post
  dynamic submitGeneralPostAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/createGeneralPost/");
      final request = MultipartRequest('POST', url);

      body.forEach((key, value) {
        if (key != 'image') {
          request.fields[key] = value;
        }
      });

      File image = body['image'] as File;
      var stream = ByteStream(image.openRead());
      var length = await image.length();
      var multipartFile = MultipartFile('image', stream, length,
          filename: '${request.fields['title']}.jpg');
      request.files.add(multipartFile);

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);

      logger.info("Submit General Post - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Submit General Post - $e");
      return null;
    }
  }

  // Get All General Post Comments API
  dynamic getAllGeneralPostCommentsAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/getAllGeneralPostComment/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Get All General Post Comments - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Get All General Post Comments - $e");
      return null;
    }
  }

  // Submit General Post Comment API
  dynamic submitGeneralPostCommentAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/createGeneralPostComment/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Submit General Post Comment - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Submit General Post Comment - $e");
      return null;
    }
  }

  // Like General Post API
  dynamic likeGeneralPostAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/likeGeneralPost/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Like General Post - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Like General Post - $e");
      return null;
    }
  }

  // Dislike General Post API
  dynamic dislikeGeneralPostAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/dislikeGeneralPost/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Dislike General Post - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Dislike General Post - $e");
      return null;
    }
  }

  // Edit Resident Account API
  dynamic editAccountAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/updateResident/");
      final request = MultipartRequest('PATCH', url);

      body.forEach((key, value) {
        if (key != 'image') {
          request.fields[key] = value;
        }
      });

      if (body['image'] != null) {
        File image = body['image'] as File;
        var stream = ByteStream(image.openRead());
        var length = await image.length();
        var multipartFile = MultipartFile('image', stream, length,
            filename: 'Profile Image.jpg');
        request.files.add(multipartFile);
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);

      logger.info("Edit Resident Account - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Edit Resident Account - $e");
      return null;
    }
  }

  // Get All Specific Neighborhood Group Facilities
  dynamic getGroupFacilities(body) async {
    try {
      final url = Uri.parse("$baseUrl/getAllFacilities/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Get Neighborhood Group Facilities - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Get Neighborhood Group Facilities - $e");
      return null;
    }
  }

  // Get Specific Neighborhood Group Facilities
  dynamic getSpecificGroupFacilities(body) async {
    try {
      final url = Uri.parse("$baseUrl/getFacilities/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Get Specific Neighborhood Group Facilities - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Get Specific Neighborhood Group Facilities - $e");
      return null;
    }
  }

  // Register Neighborhood Group Facilities
  dynamic registerGroupFacilities(body) async {
    try {
      final url = Uri.parse("$baseUrl/registerFacilities/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Register New Neighborhood Group Facilities - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Register New Neighborhood Group Facilities - $e");
      return null;
    }
  }

  // Edit Neighborhood Group Facilities
  dynamic editGroupFacilitiesAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/updateFacilities/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await patch(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Edit Neighborhood Group Facilities - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Edit Neighborhood Group Facilities - $e");
      return null;
    }
  }

  // Book Neighborhood Group Facilities
  dynamic bookGroupFacilitiesAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/bookFacilities/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Book Neighborhood Group Facilities - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Book Neighborhood Group Facilities - $e");
      return null;
    }
  }

  // Return Neighborhood Group Facilities
  dynamic returnGroupFacilitiesAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/returnFacilities/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Return Neighborhood Group Facilities - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Return Neighborhood Group Facilities - $e");
      return null;
    }
  }

  // Delete Neighborhood Group Facilities
  dynamic deleteGroupFacilitiesAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/deleteFacilities/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await delete(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Delete Neighborhood Group Facilities - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Delete Neighborhood Group Facilities - $e");
      return null;
    }
  }

  // Edit Crime Post API
  dynamic editCrimePostAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/updateCrimePost/");
      final request = MultipartRequest('PATCH', url);

      body.forEach((key, value) {
        if (key != 'image') {
          request.fields[key] = value;
        }
      });

      if (body['image'] != null) {
        File image = body['image'] as File;
        var stream = ByteStream(image.openRead());
        var length = await image.length();
        var multipartFile = MultipartFile('image', stream, length,
            filename: '${request.fields['title']}.jpg');
        request.files.add(multipartFile);
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);

      logger.info("Edit Crime Post - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Edit Crime Post - $e");
      return null;
    }
  }

  // Edit Complaint Post API
  dynamic editComplaintPostAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/updateComplaintPost/");
      final request = MultipartRequest('PATCH', url);

      body.forEach((key, value) {
        if (key != 'image') {
          request.fields[key] = value;
        }
      });

      if (body['image'] != null) {
        File image = body['image'] as File;
        var stream = ByteStream(image.openRead());
        var length = await image.length();
        var multipartFile = MultipartFile('image', stream, length,
            filename: '${request.fields['title']}.jpg');
        request.files.add(multipartFile);
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);

      logger.info("Edit Complaint Post - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Edit Complaint Post - $e");
      return null;
    }
  }

  // Edit Event Post API
  dynamic editEventPostAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/updateEventPost/");
      final request = MultipartRequest('PATCH', url);

      body.forEach((key, value) {
        if (key != 'image') {
          request.fields[key] = value;
        }
      });

      if (body['image'] != null) {
        File image = body['image'] as File;
        var stream = ByteStream(image.openRead());
        var length = await image.length();
        var multipartFile = MultipartFile('image', stream, length,
            filename: '${request.fields['title']}.jpg');
        request.files.add(multipartFile);
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);

      logger.info("Edit Event Post - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Edit Event Post - $e");
      return null;
    }
  }

  // Edit General Post API
  dynamic editGeneralPostAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/updateGeneralPost/");
      final request = MultipartRequest('PATCH', url);

      body.forEach((key, value) {
        if (key != 'image') {
          request.fields[key] = value;
        }
      });

      if (body['image'] != null) {
        File image = body['image'] as File;
        var stream = ByteStream(image.openRead());
        var length = await image.length();
        var multipartFile = MultipartFile('image', stream, length,
            filename: '${request.fields['title']}.jpg');
        request.files.add(multipartFile);
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);

      logger.info("Edit General Post - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Edit General Post - $e");
      return null;
    }
  }

  // Delete Crime Post API
  dynamic deleteCrimePostAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/deleteCrimePost/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await delete(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Delete Crime Post - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Delete Crime Post - $e");
      return null;
    }
  }

  // Delete Complaint Post API
  dynamic deleteComplaintPostAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/deleteComplaintPost/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await delete(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Delete Complaint Post - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Delete Complaint Post - $e");
      return null;
    }
  }

  // Delete Event Post API
  dynamic deleteEventPostAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/deleteEventPost/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await delete(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Delete Event Post - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Delete Event Post - $e");
      return null;
    }
  }

  // Delete General Post API
  dynamic deleteGeneralPostAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/deleteGeneralPost/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await delete(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Delete General Post - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Delete General Post - $e");
      return null;
    }
  }

  // Edit Crime Post Comment API
  dynamic editCrimePostCommentAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/updateCrimePostComment/");
      final request = MultipartRequest('PATCH', url);

      body.forEach((key, value) {
        if (key != 'image') {
          request.fields[key] = value;
        }
      });

      if (body['image'] != null) {
        File image = body['image'] as File;
        var stream = ByteStream(image.openRead());
        var length = await image.length();
        var multipartFile = MultipartFile('image', stream, length,
            filename: '${request.fields['title']}.jpg');
        request.files.add(multipartFile);
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);

      logger.info("Edit Crime Post Comment - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Edit Crime Post Comment - $e");
      return null;
    }
  }

  // Edit Complaint Post Comment API
  dynamic editComplaintPostCommentAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/updateComplaintPostComment/");
      final request = MultipartRequest('PATCH', url);

      body.forEach((key, value) {
        if (key != 'image') {
          request.fields[key] = value;
        }
      });

      if (body['image'] != null) {
        File image = body['image'] as File;
        var stream = ByteStream(image.openRead());
        var length = await image.length();
        var multipartFile = MultipartFile('image', stream, length,
            filename: '${request.fields['title']}.jpg');
        request.files.add(multipartFile);
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);

      logger.info("Edit Complaint Post Comment - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Edit Complaint Post Comment - $e");
      return null;
    }
  }

  // Edit Event Post Comment API
  dynamic editEventPostCommentAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/updateEventPostComment/");
      final request = MultipartRequest('PATCH', url);

      body.forEach((key, value) {
        if (key != 'image') {
          request.fields[key] = value;
        }
      });

      if (body['image'] != null) {
        File image = body['image'] as File;
        var stream = ByteStream(image.openRead());
        var length = await image.length();
        var multipartFile = MultipartFile('image', stream, length,
            filename: '${request.fields['title']}.jpg');
        request.files.add(multipartFile);
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);

      logger.info("Edit Event Post Comment - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Edit Event Post Comment - $e");
      return null;
    }
  }

  // Edit General Post Comment API
  dynamic editGeneralPostCommentAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/updateGeneralPostComment/");
      final request = MultipartRequest('PATCH', url);

      body.forEach((key, value) {
        if (key != 'image') {
          request.fields[key] = value;
        }
      });

      if (body['image'] != null) {
        File image = body['image'] as File;
        var stream = ByteStream(image.openRead());
        var length = await image.length();
        var multipartFile = MultipartFile('image', stream, length,
            filename: '${request.fields['title']}.jpg');
        request.files.add(multipartFile);
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);

      logger.info("Edit General Post Comment - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Edit General Post Comment - $e");
      return null;
    }
  }

  // Delete Crime Post Comment API
  dynamic deleteCrimePostCommentAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/deleteCrimePostComment/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await delete(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Delete Crime Post Comment - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Delete Crime Post Comment - $e");
      return null;
    }
  }

  // Delete Complaint Post Comment API
  dynamic deleteComplaintPostCommentAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/deleteComplaintPostComment/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await delete(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Delete Complaint Post Comment - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Delete Complaint Post Comment - $e");
      return null;
    }
  }

  // Delete Event Post Comment API
  dynamic deleteEventPostCommentAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/deleteEventPostComment/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await delete(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Delete Event Post Comment - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Delete Event Post Comment - $e");
      return null;
    }
  }

  // Delete General Post Comment API
  dynamic deleteGeneralPostCommentAPI(body) async {
    try {
      final url = Uri.parse("$baseUrl/deleteGeneralPostComment/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await delete(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Delete General Post Comment - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Delete General Post Comment - $e");
      return null;
    }
  }

  // Get all residents data (only ID, Name, Username and Neighborhood Group Name)
  dynamic getAllResidentsData() async {
    try {
      final url = Uri.parse("$baseUrl/getResidentAll/");

      final response = await get(url);
      final responseData = jsonDecode(response.body);

      logger.info("Get All Residents Data - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Get All Residents Data - $e");
      return null;
    }
  }

  // Get Chat History Betwen 2 Residents
  dynamic getChatHistory(body) async {
    try {
      final url = Uri.parse("$baseUrl/getChat/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Get Chat History - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Get Chat History - $e");
      return null;
    }
  }

  // Submit Chat Message
  dynamic submitChatMessage(body) async {
    try {
      final url = Uri.parse("$baseUrl/createChat/");
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await post(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Submit Chat Message - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Submit Chat Message - $e");
      return null;
    }
  }
}
