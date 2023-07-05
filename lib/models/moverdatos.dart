import 'package:firebase_database/firebase_database.dart';

class MoveData {
  final String name;
  final now = DateTime.now();

  MoveData({required this.name});

  Future<void> move() async {
    DateTime now = DateTime.now();
    String formattedDate =
        "${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}-${now.second.toString().padLeft(2, '0')}";
    final DatabaseReference sourceRef =
        FirebaseDatabase.instance.ref().child('DatoTiempoReal');
    final DatabaseReference destinationRef = FirebaseDatabase.instance
        .ref()
        .child('Basededatos')
        .child(name)
        .child(formattedDate);

    DataSnapshot dataSnapshot = await sourceRef.get();
    Map<dynamic, dynamic>? data = dataSnapshot.value as Map<dynamic, dynamic>?;

    data?.forEach((key, value) async {
      await destinationRef.update({key: value});
    });

    await sourceRef.remove();

    print('Datos movidos exitosamente de DatoTiempoReal a $name');
  }
}
