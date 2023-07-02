import 'package:logging/logging.dart';

class EtamanLogger {
  final logger = Logger('etaman_frontend');

  // Private constructor to prevent external instantiation
  EtamanLogger._();

  // Singleton instance
  static final EtamanLogger _instance = EtamanLogger._();

  // Factory method to retrieve the instance
  factory EtamanLogger() => _instance;

  // Log information messages
  void info(message) {
    logger.info("[Info] $message");
  }

  // Log warning messages
  void warning(message) {
    logger.warning("[Warning] $message");
  }

  // Log error messages
  void error(message) {
    logger.severe("[Error] $message");
  }
}
