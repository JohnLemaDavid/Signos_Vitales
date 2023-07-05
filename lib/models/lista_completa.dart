import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class GetTablesdateTotal with ChangeNotifier {
  List<Map<dynamic, dynamic>> _datosTiempoRealList = [];

  final _db = FirebaseDatabase.instance.ref();
  final String nodeName;

  static const TIEMPO_REAL_PATH = 'Basededatos';

  late StreamSubscription _datosTiempoRealStream;

  List<Map<dynamic, dynamic>> get datosTiempoRealList => _datosTiempoRealList;

  GetTablesdateTotal(this.nodeName) {
    _listenToDatoTiempoReal();
  }

  void _listenToDatoTiempoReal() {
    _datosTiempoRealStream =
        _db.child(nodeName).orderByChild('fecha').onValue.listen((event) {
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
