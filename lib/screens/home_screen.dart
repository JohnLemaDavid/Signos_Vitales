import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signos_vitales/providers/mapa_seleccionado.dart';
import 'package:signos_vitales/providers/ui_provider.dart';
import 'package:signos_vitales/screens/screens.dart';
import 'package:signos_vitales/screens/signos_screenresponsive.dart';
import 'package:signos_vitales/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    return Scaffold(
      backgroundColor: Colors.white,
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigator(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Obtener el valor de provider UI
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;
    switch (currentIndex) {
      case 0:
        return FutureBuilder(
          future: FirebaseDatabase.instance.ref().child('Usuario').once(),
          builder:
              (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
            if (snapshot.hasData) {
              final data = (snapshot.data!.snapshot.value as Map?)
                  ?.cast<dynamic, dynamic>();
              print(data);
              if (data != null) {
                return SignosScreenResponsive();
              } else {
                return InicioScreen();
              }
            } else {
              return SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  strokeWidth: 4.0,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                ),
              );
            }
          },
        );
      case 1:
        return Consumer<PerfilSeleccionado>(
          builder: (context, estado, child) {
            if (estado.isNull()) {
              return BasedeDatos();
            } else {
              return HistorialScreen();
            }
          },
        );

      case 2:
        return CuentaConfigScreen();
      default:
        return SignosScreenResponsive();
    }
  }
}
