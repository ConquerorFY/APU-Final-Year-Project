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

  // Register Resident Account API
  dynamic registerAccount(body) async {
    try {
      final url = Uri.parse("http://localhost:8000/api/registerResident/");
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
}
