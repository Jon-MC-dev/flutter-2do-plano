import 'package:flutter/material.dart';

int numero_iteraciones = 0;
void main() {
  getTrackRecursive();
  runApp(MyApp());
}

void getTrackRecursive() {
  Future.delayed(Duration(seconds: 5)).whenComplete(() {
    numero_iteraciones++;
    print('Numero de iteraciones: $numero_iteraciones');
    getTrackRecursive();
  });
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
