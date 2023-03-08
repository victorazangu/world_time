import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  late String location; //location name for the UI
  late String time; //time in that location
  late String flag; //url to an asset flag icon
  late bool isDayTime;
  late String url;
//  late String country;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      final response = await http
          .get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      //create  datetime onbject
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
      // Future<void> getFlag() async {
      //   final response =
      //       await http.get(Uri.parse('https://countryflagsapi.com/png/$country'));
      //   Map data = jsonDecode(response.body);
      //   flag = data.toString();
      // }
    } catch (e) {
      print("caught error: {$e}");
      time = "could not get the time";
    }
  }
}
