import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:signos_vitales/firebase.dart';
import 'package:signos_vitales/providers/mapa_seleccionado.dart';

import 'models/lista_completa.dart';

import 'models/lista_de_dato.dart';
import 'providers/datos_real_provider.dart';
import 'providers/ui_provider.dart';
import 'screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UiProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RealtimeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PerfilSeleccionado(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetTablesdate(),
        ),
        ChangeNotifierProvider(
          create: (_) => PerfilSeleccionado(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Gilroy'),
        title: 'Signos Vitales',
        initialRoute: 'home',
        routes: {
          'home': (_) => HomeScreen(),
        },
      ),
    );
  }
}
