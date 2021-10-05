import 'package:flutter/material.dart';
import 'package:location_tracking_flutter/track_location.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Initialise firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Location Tracking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TrackLocation(),
    );
  }
}
