import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:prueva_background/isolates2.dart';

int numero_iteraciones = 0;
void main() async {
  start();

  runApp(MyApp());
}

Future<bool> getTrackRecursive() async {
  print('Haciendo algun proceso...');
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

Isolate? isolate;

start() async {
  ReceivePort receiverPort = ReceivePort();
  isolate = await Isolate.spawn(cronometro, receiverPort.sendPort);
  receiverPort.listen(manejoMensajes, onDone: () {
    print('Terminado');
  });
}

cronometro(SendPort sendPort) async {
  Timer.periodic(Duration(seconds: 3), (Timer timer) {
    getTrackRecursive().then((value) {
      numero_iteraciones++;
      sendPort.send(numero_iteraciones);
    });
  });
}

manejoMensajes(dynamic data) {
  print('numero_iteraciones: $data');
}
