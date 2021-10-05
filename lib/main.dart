import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:background_location/background_location.dart';
import 'package:prueva_background/track_location.dart';

int numero_iteraciones = 0;
void main() async {
  runApp(MyApp());
}

Future<bool> getTrackRecursive() async {
  numero_iteraciones++;
  print('numero_iteraciones: $numero_iteraciones');
  return Future.value(true);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    BackgroundLocation.startLocationService(distanceFilter: 1);

    BackgroundLocation.getLocationUpdates((location) {
      print(location.latitude);
      print(location.longitude);
      getTrackRecursive();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$numero_iteraciones',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ));
  }
}
