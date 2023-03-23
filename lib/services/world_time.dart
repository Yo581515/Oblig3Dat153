import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint
  String time = ''; // the time in that location
  bool isDayTime = false; // true or false if daytime or not

  WorldTime({required this.url, required this.location, required this.flag});

  Future<void> getTime() async {
    try {
      // make the request;
      var uRL = Uri.parse('http://worldtimeapi.org/api/timezone/$url');
      print(uRL);
      Response response = await get(uRL);
      Map data = jsonDecode(response.body);

      String datetime = data['utc_datetime'];
      String offset = data['utc_offset'];

      //create a dateTime object
      DateTime now = DateTime.parse(datetime);
      if (offset.startsWith('+')) {
        now = now.add(Duration(hours: int.parse(offset.substring(1, 3))));
      } else {
        now = now.subtract(Duration(hours: int.parse(offset.substring(1, 3))));
      }
      time = DateFormat.jm().format(now);

      print(time);
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
    } catch (e) {
      print('server exception');
      time = 'could not get time data';
    }
  }
}