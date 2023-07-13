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
      final headers = {'Content-Type': 'application/json'};
      final jsonBody = jsonEncode(body);

      final response = await patch(url, headers: headers, body: jsonBody);
      final responseData = jsonDecode(response.body);

      logger.info("Edit Resident Account - $responseData");
      return responseData;
    } catch (e) {
      logger.error("Edit Resident Account - $e");
      return null;
    }
  }
}
