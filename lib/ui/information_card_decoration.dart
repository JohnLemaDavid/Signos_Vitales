import 'package:flutter/material.dart';

class InformationCard {
  static BoxDecoration myboxdecoration(Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          spreadRadius: 1,
          blurRadius: 2,
          offset: Offset(0, 2),
        ),
      ],
    );
  }
}
