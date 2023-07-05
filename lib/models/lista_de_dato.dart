import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class GetTablesdate with ChangeNotifier {
  List<Map<dynamic, dynamic>> _datosTiempoRealList = [];

  final _db = FirebaseDatabase.instance.ref();

  static const TIEMPO_REAL_PATH = 'DatoTiempoReal';

  late StreamSubscription _datosTiempoRealStream;

  List<Map<dynamic, dynamic>> get datosTiempoRealList => _datosTiempoRealList;

  GetTablesdate() {
    _listenToDatoTiempoReal();
  }

  void _listenToDatoTiempoReal() {
    _datosTiempoRealStream = _db
        .child(TIEMPO_REAL_PATH)
        .orderByChild('fecha')
        .limitToLast(20)
        .onValue
        .listen((event) {
      final data = (event.snapshot.value as Map<dynamic, dynamic>?) ?? {};
      _datosTiempoRealList = data.entries
          .map((entry) {
            final value = entry.value as Map<dynamic, dynamic>;
            return {
              'bateria': int.parse(value['bateria']),
              'bpm': int.parse(value['bpm']),
              'oxigenacion': int.parse(value['oxigenacion']),
              'posicion': int.parse(value['posicion']),
              'timestamp': int.parse(value['timestamp'])
            };
          })
          .toList()
          .reversed
          .toList();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _datosTiempoRealStream.cancel();

    super.dispose();
  }
}
