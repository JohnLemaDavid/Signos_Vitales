import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:signos_vitales/screens/Datos_tabla_personal.dart';

import '../ui/information_card_decoration.dart';

class BasedeDatos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final _dbRef = FirebaseDatabase.instance.ref();
    initializeDateFormatting('es');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF916df1),
        flexibleSpace: SafeArea(
          child: Column(
            children: [
              SizedBox(height: screenSize.height / 60),
              Text(
                'Datos de lactantes',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "SF_UI_display",
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      body: Stack(alignment: AlignmentDirectional.topCenter, children: [
        FutureBuilder(
          future: _dbRef.child('Basededatos').once(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = (snapshot.data!.snapshot.value as Map?)
                  ?.cast<dynamic, dynamic>();
              if (data == null || data.isEmpty) {
                return Center(
                  child: Text('No hay datos en la base de datos.'),
                );
              }
              final nodeNames = data.keys.toList();
              final nodeNamesWithChildren = <MapEntry<String, String>>[];
              for (final nodeName in nodeNames) {
                final childNames =
                    (data[nodeName] as Map?)?.keys.toList() ?? [];
                for (final childName in childNames) {
                  nodeNamesWithChildren.add(MapEntry(nodeName, childName));
                }
              }
              nodeNamesWithChildren.sort((a, b) => b.value.compareTo(a.value));
              final orderedNodeNames = nodeNamesWithChildren
                  .map((entry) => entry.key)
                  .toSet()
                  .toList();

              print(orderedNodeNames);
              print('aqui');
              return Container(
                margin: EdgeInsets.only(top: screenSize.height / 116),
                child: ListView.builder(
                  itemCount: orderedNodeNames.length,
                  itemBuilder: (context, index) {
                    final nodeName = orderedNodeNames[index];

                    return FutureBuilder(
                      future: _dbRef.child('Basededatos/$nodeName').once(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final data = (snapshot.data! as DatabaseEvent)
                              .snapshot
                              .value as Map<dynamic, dynamic>;
                          final nodes = data.keys.toList();
                          nodes.sort((a, b) => b.compareTo(a));
                          print(nodes);
                          return Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.40),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(0, 2),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20.0),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff7746ff), // Abajo

                                  Color(0xff916df1), // Arriba
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: ExpansionTile(
                              title: Text(
                                nodeName,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              children: nodes.map((node) {
                                String fecha = node;
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

                                DateTime dateTime = DateTime(
                                    year, month, day, hour, minute, second);

                                String dayName =
                                    DateFormat('EEEE', 'es').format(dateTime);
                                String monthName =
                                    DateFormat('MMMM', 'es').format(dateTime);
                                String years =
                                    DateFormat('y', 'es').format(dateTime);
                                String time =
                                    DateFormat('h:mm a', 'es').format(dateTime);

                                String formattedDate =
                                    '$dayName, $day de $monthName de $years';

                                String formattedTime = '$time';
                                return ListTile(
                                  title: Text(
                                    '${formattedDate.substring(0, 1).toUpperCase() + formattedDate.substring(1)}' +
                                        '  ${formattedTime}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Datos_table_total(
                                                nombreNodo: nodeName,
                                                ruta: node,
                                              )),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          );
                        } else {
                          return SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 4.0,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('No se pudo acceder a la base de datos.'),
              );
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
        ),
      ]),
    );
  }
}
