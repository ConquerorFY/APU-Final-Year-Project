import 'dart:convert';

import 'package:etaman_frontend/services/snackbar.dart';
import 'package:web_socket_channel/io.dart';

class AuthService {
  // Create Singleton instance
  AuthService._();
  static final AuthService _instance = AuthService._();
  factory AuthService() => _instance;

  SnackbarService snackbar = SnackbarService();
  String _authToken = "";
  dynamic emergencyChannel;

  void setAuthToken(String tokenVal) {
    _authToken = tokenVal;
  }

  String getAuthToken() {
    return _authToken;
  }

  void clearAuthToken() {
    _authToken = "";
  }

  void initEmergencyChannel(wsUrl, groupID) {
    emergencyChannel?.sink?.close();
    emergencyChannel =
        IOWebSocketChannel.connect("$wsUrl/emergency/?id=$groupID");
    emergencyChannel.stream.asBroadcastStream().listen((message) {
      snackbar.initSnackbar(jsonDecode(message)['data']['message']);
    });
  }

  void sendEmergencyChannel(emergencyData) {
    emergencyChannel.sink.add(jsonEncode(emergencyData));
  }

  void closeEmergencyChannel() {
    emergencyChannel.sink.close();
  }
}
