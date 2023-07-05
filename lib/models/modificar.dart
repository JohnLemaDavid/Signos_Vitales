import 'package:firebase_database/firebase_database.dart';

class ChangeData {
  final Map<dynamic, dynamic> data;

  ChangeData({required this.data});

  Future<void> change() async {
    final databaseRef = FirebaseDatabase.instance.ref().child('Usuario');

    final String nodeName = '${data['nombre'] + ' ' + data['apellido']}';

    DatabaseEvent snapshot = await databaseRef.child(nodeName).once();

    if (snapshot.snapshot.value != null) {
      data['fecha_creacion'] = DateTime.now().toString();
      await databaseRef.child(nodeName).set(data);
      print('Dato Modificados Correctamente');
      return;
    }

    // Si el nodo no existe, enviar los datos
    await databaseRef.child(nodeName).set(data);
    print('Datos enviados exitosamente a Firebase');
  }
}
