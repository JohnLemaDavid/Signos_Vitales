import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:signos_vitales/models/datos_tiemporeal.dart';

class RealtimeProvider with ChangeNotifier {
  final _database = FirebaseDatabase.instance.ref();
  DatosRealTime _datos = DatosRealTime(
    bpm: "0",
    posicion: "0",
    oxigenacion: "0",
    bateria: "0",
    timestamp: "0",
  );

  DatosRealTime get datos => _datos;
  List<DatosRealTime> _datosList = [];

  RealtimeProvider() {
    _initRealtimeDatabaseListener();
    // _tableData();
  }

  void _initRealtimeDatabaseListener() {
    final DatabaseReference dbRef = _database.child('DatoTiempoReal');
    dbRef.onChildAdded.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      Map<dynamic, dynamic> data = dataSnapshot.value as Map;
      _datos = DatosRealTime.fromRTDB(data);
      notifyListeners();
    });
  }

  // void _tableData() {
  //   final DatabaseReference dbRef = _database.child('DatoTiempoReal');

  //   // Obtener los últimos 15 elementos
  //   dbRef.limitToLast(15).onValue.listen((event) {
  //     List<DatosRealTime> datosList = [];
  //     Map<dynamic, dynamic> dataMap =
  //         event.snapshot.value as Map<dynamic, dynamic>;

  //     // Si dataMap es nulo, establecer los valores en cero
  //     if (dataMap == null) {
  //       _datosList = List.generate(
  //           15,
  //           (_) => DatosRealTime(
  //               bpm: 0, posicion: 0, oxigenacion: 0, bateria: 0, timestamp: 0));
  //       notifyListeners();
  //       return;
  //     }

  //     // Convertir los datos en una lista de objetos DatosRealTime
  //     dataMap.forEach((key, value) {
  //       DatosRealTime datos = DatosRealTime.fromRTDB(value);
  //       datosList.add(datos);
  //     });

  //     // Ordenar la lista por fecha (timestamp) descendente
  //     datosList.sort((a, b) => b.timestamp.compareTo(a.timestamp));

  //     // Actualizar los datos y notificar a los listeners
  //     _datosList = datosList;
  //     notifyListeners();
  //   });
  // }

  // List<DatosRealTime> get datosList => _datosList;
}
