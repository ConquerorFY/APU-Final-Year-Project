import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:etaman_frontend/services/logging.dart';

class WorldTime {
  String location = ''; // location name for UI
  String time = ''; // the time in that location
  String flag = ''; // url to an asset flag icon
  String url = ''; // location url for api endpoint
  bool isDaytime = false; // true or false if daytime or not

  EtamanLogger logger = EtamanLogger(); // logger

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      final uri = Uri.parse('http://worldtimeapi.org/api/timezone/$url');
      // make the request
      final response = await get(uri);
      Map data = jsonDecode(response.body);

      // get properties from json
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      logger.error("$e, could not get time!");
      // These 2 function calls is to call this function repeatedly every second until a response is given
      // To fix the "flutter: Connection closed before full header was received" error
      await Future.delayed(const Duration(seconds: 1));
      await getTime();
    }
  }
}
