import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/lista_de_dato.dart';
import '../ui/information_card_decoration.dart';

class Datos_table_total extends StatelessWidget {
  final databaseRef = FirebaseDatabase.instance.ref();
  final String ruta;
  final String nombreNodo;
  Datos_table_total({Key? key, required this.ruta, required this.nombreNodo})
      : super(key: key);
  String estadobpm = "";
  String estadooxi = "";
  int edadmeses = 0;
  var oxigenacionColor;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String fecha = ruta;
    List<String> parts = fecha.split('_');

    String fechaPart = parts[0];
    String horaPart = parts[1];

    List<String> fechaParts = fechaPart.split('-');

    int year = int.parse(fechaParts[0]);
    int month = int.parse(fechaParts[1]);
    int day = int.parse(fechaParts[2]);

    List<String> horaParts = horaPart.split('-');

    int hour = int.parse(horaParts[0]);
    int minute = int.parse(horaParts[1]);
    int second = int.parse(horaParts[2]);

    DateTime dateTime = DateTime(year, month, day, hour, minute, second);

    String dayName = DateFormat('EEEE', 'es').format(dateTime);
    String monthName = DateFormat('MMMM', 'es').format(dateTime);
    String years = DateFormat('y', 'es').format(dateTime);
    String time = DateFormat('h:mm a', 'es').format(dateTime);

    String formattedDate = '$dayName, $day de $monthName de $years';

    String formattedTime = '$time';
    String fechatotal =
        '${formattedDate.substring(0, 1).toUpperCase() + formattedDate.substring(1)}' +
            '  ${formattedTime}';
    return FutureBuilder(
        future:
            databaseRef.child('Usuario').child(nombreNodo).child('edad').once(),
        builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.hasData) {
            final edad = (snapshot.data!.snapshot.value);
            edadmeses = int.parse(edad.toString());
            print(edadmeses);
          } else {}

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Color(0xFF916df1),
              toolbarHeight: screenHeight / 11,
              flexibleSpace: SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: screenHeight / 60),
                    Text(
                      '${nombreNodo}',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "SF_UI_display",
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      fechatotal,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "SF_UI_display",
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            body: Container(
              child: Column(
                children: [
                  Container(
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Container(
                      decoration: InformationCard.myboxdecoration(Colors.white),
                      margin: EdgeInsets.all(4),
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: screenWidth / 4.5,
                            child: Text(
                              textAlign: TextAlign.center,
                              'Indice',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                          Container(
                            width: screenWidth / 4.5,
                            child: Text(
                              textAlign: TextAlign.center,
                              'Fecha',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                          Container(
                            width: screenWidth / 4.5,
                            child: Text(
                              'Frecuencia Cardiaca',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                          Container(
                            width: screenWidth / 4.5,
                            child: Text(
                              'Oxigeno en la sangre',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        width: screenWidth,
                        child: FutureBuilder(
                            future: databaseRef
                                .child('Basededatos')
                                .child(nombreNodo)
                                .child(ruta)
                                .once(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DatabaseEvent> snapshot) {
                              List<Map<dynamic, dynamic>> datos = [];
                              if (snapshot.hasData) {
                                final datosOrdenados =
                                    (snapshot.data!.snapshot.value as Map?)
                                        ?.cast<dynamic, dynamic>();

                                datosOrdenados?.forEach((key, value) {
                                  Map<dynamic, dynamic> datosNodo = {
                                    'bateria': int.parse(value['bateria']),
                                    'bpm': int.parse(value['bpm']),
                                    'oxigenacion':
                                        int.parse(value['oxigenacion']),
                                    'posicion': int.parse(value['posicion']),
                                    'timestamp': int.parse(value['timestamp'])
                                  };
                                  datos.add(datosNodo);
                                });

                                datos.sort(
                                    (a, b) => b['timestamp'] - a['timestamp']);

                                if (datosOrdenados != null) {
                                  return ListView.builder(
                                    itemCount: datos.length,
                                    itemBuilder: (context, index) {
                                      final date =
                                          DateTime.fromMillisecondsSinceEpoch(
                                              datos[index]['timestamp']);
                                      final bpm = datos[index]['bpm'];
                                      final oxigenacion =
                                          datos[index]['oxigenacion'];
                                      Color bpmColor = Colors.green;

                                      if (edadmeses > 0 && edadmeses <= 1) {
                                        estadobpm = bpm >= 70 && bpm <= 190
                                            ? 'Normal'
                                            : 'ALERTA';
                                        bpmColor = bpm >= 70 && bpm <= 190
                                            ? Colors.green
                                            : Colors.red;
                                      } else if (edadmeses > 1 &&
                                          edadmeses <= 11) {
                                        estadobpm = bpm >= 80 && bpm <= 160
                                            ? 'Normal'
                                            : 'ALERTA';
                                        bpmColor = bpm >= 80 && bpm <= 160
                                            ? Colors.green
                                            : Colors.red;
                                      } else if (edadmeses > 11 &&
                                          edadmeses <= 24) {
                                        estadobpm = bpm >= 80 && bpm <= 130
                                            ? 'Normal'
                                            : 'ALERTA';
                                        bpmColor = bpm >= 80 && bpm <= 130
                                            ? Colors.green
                                            : Colors.red;
                                      }

                                      if (oxigenacion >= 94) {
                                        oxigenacionColor = Colors.green;
                                        estadooxi = "Normal";
                                      } else if (oxigenacion >= 90) {
                                        oxigenacionColor = Colors.orange;
                                        estadooxi = "Hipoxia Leve";
                                      } else if (oxigenacion >= 85) {
                                        oxigenacionColor = Colors.orange;
                                        estadooxi = "Hipoxia Moderada";
                                      } else {
                                        oxigenacionColor = Colors.red;
                                        estadooxi = "Hipoxia Severa";
                                      }
                                      return Container(
                                        decoration:
                                            InformationCard.myboxdecoration(
                                                Color(0xffffffff)),
                                        margin: EdgeInsets.all(3),
                                        padding: EdgeInsets.all(5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: screenWidth / 4.5,
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                '${index + 1}',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: screenWidth / 4.5,
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                '${date.toString().substring(0, 10)}\n${date.toString().substring(11, 19)}',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            Container(
                                              width: screenWidth / 4.5,
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                '$bpm BPM\n$estadobpm',
                                                style: TextStyle(
                                                    color: bpmColor,
                                                    fontSize: 12),
                                              ),
                                            ),
                                            Container(
                                              width: screenWidth / 4.5,
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                '${oxigenacion.toStringAsFixed(2)}%\n$estadooxi',
                                                style: TextStyle(
                                                    color: oxigenacionColor,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Center(
                                    child: Container(
                                      child:
                                          Text('La base de datos está vacía.'),
                                    ),
                                  );
                                }
                              } else {
                                return Center(
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 4.0,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.deepPurple),
                                    ),
                                  ),
                                );
                              }
                            })),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
