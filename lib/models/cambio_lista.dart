import 'package:firebase_database/firebase_database.dart';
import 'package:signos_vitales/models/modificar.dart';

void listenToNodeChanges(Map<dynamic, dynamic> nodeData) {
  final databaseRef = FirebaseDatabase.instance.ref();
  databaseRef.child('Basededatos').onValue.listen((event) async {
    final changeData = ChangeData(data: nodeData);
    await changeData.change();
  });
}
