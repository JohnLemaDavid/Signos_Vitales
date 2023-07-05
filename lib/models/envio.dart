import 'package:firebase_database/firebase_database.dart';

class SendData {
  final Map<String, dynamic> data;

  SendData({required this.data});

  Future<void> send() async {
    final databaseRef = FirebaseDatabase.instance.ref().child('Usuario');
    ;

    final String nodeName = '${data['nombre'] + ' ' + data['apellido']}';

    DatabaseEvent snapshot = await databaseRef.child(nodeName).once();

    if (snapshot.snapshot.value != null) {
      print('Ya existe un nodo con ese nombre');
      return;
    }

    data['fecha_creacion'] = DateTime.now().toString();

    await databaseRef.child(nodeName).set(data);
    print('Datos enviados exitosamente a Firebase');
  }
}
