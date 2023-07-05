import 'package:flutter/material.dart';

InputDecoration customInputDecoration(IconData icon, String labelText) {
  return InputDecoration(
    labelText: labelText,
    prefixIcon: Icon(icon),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: Color(0xff5b82f7),
        width: 2.0,
      ),
    ),
  );
}
