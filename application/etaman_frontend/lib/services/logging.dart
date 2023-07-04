class EtamanLogger {
  // Private constructor to prevent external instantiation
  EtamanLogger._();
  // Singleton instance
  static final EtamanLogger _instance = EtamanLogger._();
  // Factory method to retrieve the instance
  factory EtamanLogger() => _instance;

  // Log information messages
  void info(message) {
    print("[Info] $message");
  }

  // Log warning messages
  void warning(message) {
    print("[Warning] $message");
  }

  // Log error messages
  void error(message) {
    print("[Error] $message");
  }
}
