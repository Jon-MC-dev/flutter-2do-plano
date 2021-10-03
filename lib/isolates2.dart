import 'dart:async';
import 'dart:io';
import 'dart:isolate';

class Isolates {
  static Isolate? isolate;

  static Future<bool> Function()? function;

  static start(funcion) async {
    Isolates.function = funcion;
    print('ReceivePort receiverPort = ReceivePort()');
    ReceivePort receiverPort = ReceivePort();
    isolate = await Isolate.spawn(cronometro, receiverPort.sendPort);
    receiverPort.listen(manejoMensajes, onDone: () {
      print('Terminado');
    });
  }

  static cronometro(SendPort sendPort) async {
    int numero_iteraciones = 0;

    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (Isolates.function != null) {
        Isolates.function!().then((value) {
          numero_iteraciones++;
          sendPort.send(numero_iteraciones);
        });
      } else {
        print('Es null ${Isolates.function}');
      }
    });
  }

  static manejoMensajes(dynamic data) {
    print('numero_iteraciones: $data');
  }
}
