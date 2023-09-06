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

  Map<String, String> splitDateTime(input) {
    // Parse input into a DateTime object
    DateTime dateTime = DateTime.parse(input);
    // Format the date and time as strings
    String date =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    String time =
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
    return {"date": date, "time": time};
  }
}
