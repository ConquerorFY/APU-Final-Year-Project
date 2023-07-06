class AuthService {
  // Create Singleton instance
  AuthService._();
  static final AuthService _instance = AuthService._();
  factory AuthService() => _instance;

  String _authToken = "";

  void setAuthToken(String tokenVal) {
    _authToken = tokenVal;
  }

  String getAuthToken() {
    return _authToken;
  }

  void clearAuthToken() {
    _authToken = "";
  }
}
