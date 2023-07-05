import 'package:flutter/material.dart';

class PerfilSeleccionado with ChangeNotifier {
  Map<dynamic, dynamic>? _myMap;

  void setMyMap(Map<dynamic, dynamic>? myMap) {
    _myMap = myMap;
    notifyListeners();
  }

  bool isNull() {
    return _myMap == null;
  }

  Map<dynamic, dynamic>? get myMap => _myMap;
}
