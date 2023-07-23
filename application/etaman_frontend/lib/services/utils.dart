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

  String capitalizeFirstLetter(input) {
    if (input == null || input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }
}
