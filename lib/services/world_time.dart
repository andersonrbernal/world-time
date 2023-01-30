import 'package:http/http.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class WorldTime {
  late String location; // location name for the UI
  late String time; // time in that location
  late String flag; // url to an asset flag icon
  late String url; // location url for api endpoint
  late bool isDayTime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Uri apiUri = Uri.parse('http://worldtimeapi.org/api/timezone/$url');
      Response response = await get(apiUri);
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset1 = data['utc_offset'].substring(1, 3);
      String offset2 = data['utc_offset'].substring(4, 6);

      DateTime now = DateTime.parse(datetime);
      now = now.add(
          Duration(hours: int.parse(offset1), minutes: int.parse(offset2)));

      isDayTime = now.hour > 6 && now.hour < 20;
      time = DateFormat.jm().format(now); // set the time property
    } catch (e) {
      time = 'could not get time data';
    }
  }
}
