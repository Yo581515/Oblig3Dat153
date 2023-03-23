import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

/*DateTime getRealTime(Response response) {

  Map data = jsonDecode(response.body);

  //get propertirs from data
  String datetime = data['utc_datetime'];
  String offset = data['utc_offset'];

  print('datetime : ' + data['utc_datetime']);
  print('offset : ' + offset);

  //create a dateTime object
  DateTime now = DateTime.parse(datetime);
  print(now);
  if (offset.startsWith('+')) {
    now = now.add(Duration(hours: int.parse(offset.substring(1, 3))));
  } else {
    now = now.subtract(Duration(hours: int.parse(offset.substring(1, 3))));
  }
  return now;
}*/

class _LoadingState extends State<Loading> {
  String time = 'loading';

/*
  void getData() async {

    var url = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');
    Response response = await get(url);
    print(response.body);
    Map data = jsonDecode(response.body);
    print(data);
    print(data['title']);

   */
/* var response = await get(url);
    Map data = jsonDecode(response.body);
    print(data);
    print(data['title']);*/ /*

  }
*/

  void setupWorldTime() async {
    String country = 'Oslo';
    WorldTime instance = WorldTime(
        url: 'Europe/$country',
        location: country,
        flag: '$country' + 'flag.png');
    await instance.getTime();

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime
    });
/*
    print('the time in $country is ${instance.time} :D ');
*/
/*    setState(() {
      time = instance.time;
    });*/
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading'),
        centerTitle: true,
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
      /*body: Padding(
        padding: EdgeInsets.all(50),
        child: Text(
          time,
          style: TextStyle(fontSize: 23, color: Colors.black),
        ),
      ),*/
    );
  }
}
