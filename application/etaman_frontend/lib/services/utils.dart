import 'package:intl/intl.dart';

class Utils {
  // Create Singleton instance
  Utils._();
  static final Utils _instance = Utils._();
  factory Utils() => _instance;

  String formatDateTime(input) {
    DateTime datetime = DateTime.parse(input);
    String formattedDateTime = DateFormat("yyyy-MM-dd HH:mm").format(datetime);
    return formattedDateTime;
  }
}
