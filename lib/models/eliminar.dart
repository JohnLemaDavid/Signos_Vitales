import 'package:firebase_database/firebase_database.dart';

class EliminarData {
  final Map<dynamic, dynamic> data;

  EliminarData({required this.data});

  Future<void> eliminar() async {
    final databaseRef = FirebaseDatabase.instance.ref().child('Usuario');
    final databaseRefdelete =
        FirebaseDatabase.instance.ref().child('Basededatos');

    final String nodeName = '${data['nombre'] + ' ' + data['apellido']}';

    DatabaseEvent snapshot = await databaseRef.child(nodeName).once();

    if (snapshot.snapshot.value != null) {
      final String nodeName = '${data['nombre'] + ' ' + data['apellido']}';
      await databaseRef.child(nodeName).remove();
      await databaseRefdelete.child(nodeName).remove();
      print('Nodo eliminado correctamente');
    }
    print('Error al borrar Usuario');
  }
}
