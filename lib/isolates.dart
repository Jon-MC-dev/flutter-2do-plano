import 'dart:async';
import 'dart:io';
import 'dart:isolate';

main() async {
  print('Comenzado cronometro....');
  await start();
  print('Preciona entrer para terminar');
  await stdin.first;
  stop();
  print('Cronometro terminado');
  exit(0);
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
  int segundos = 0;
  int minutos = 0;

  Timer.periodic(Duration(seconds: 1), (Timer timer) {
    segundos++;
    if (segundos == 60) {
      segundos = 0;
      minutos++;
    }
    String mensaje = '$minutos:$segundos';
    print(mensaje);
    sendPort.send(mensaje);
  });
}

manejoMensajes(dynamic data) {
  print('Tiempo transcurrido: $data');
}

stop() {
  if (isolate != null) {
    print('Terminnado cronometro');
    isolate?.kill(priority: Isolate.immediate);
    isolate = null;
  }
}
