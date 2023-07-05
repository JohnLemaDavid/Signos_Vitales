import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signos_vitales/providers/ui_provider.dart';

class CustomNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;
    return BottomNavigationBar(
        onTap: (int i) => uiProvider.selectedMenuOpt = i,
        selectedItemColor: const Color(0xff92cae5),
        iconSize: 21,
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.watch_later_outlined), label: 'Historial'),
        ]);
  }
}
