import 'dart:convert';
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
}
