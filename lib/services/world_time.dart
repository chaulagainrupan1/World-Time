import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; // location name for the UI
  String time; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoints
  bool isDaytime; // true or false if daytime or not

  WorldTime({this.location, this.flag,this.url});

  Future<void> getTime() async{

    try {
      // make the request
      Response response = await get('https://worldtimeapi.org/api/timezone/$url');
      Map data = json.decode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['utc_datetime'];
      String offset_hour = data['utc_offset'].substring(1,3);
      String offset_minute = data['utc_offset'].substring(4,);

      // create a datetime object
      // converts the datetime string into DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset_hour), minutes: int.parse(offset_minute)));

      // set the time property
      isDaytime = (now.hour > 6 && now.hour < 20);
      time = DateFormat.jm().format(now);
    }
    catch (e){
      print(e);
      time = "couldnot obtain the time";
    }

  }


}