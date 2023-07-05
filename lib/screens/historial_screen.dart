import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:signos_vitales/providers/mapa_seleccionado.dart';

import '../models/lista_de_dato.dart';
import '../ui/information_card_decoration.dart';

class HistorialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var perfilSeleccionado =
        Provider.of<PerfilSeleccionado>(context, listen: false);
    int edad = perfilSeleccionado.myMap!['edad'];
    int edadmeses = int.parse(edad.toString());
    String estadobpm = "";
    String estadooxi = "";
    var oxigenacionColor;
    print(edadmeses);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF916df1),
        toolbarHeight: screenHeight / 15,
        flexibleSpace: SafeArea(
          child: Column(
            children: [
              SizedBox(height: screenHeight / 60),
              Text(
                'Datos',
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
                color: Colors.transparent,
                child: Consumer<GetTablesdate>(
                  builder: (context, dataProvider, _) {
                    List<Map<dynamic, dynamic>> datosOrdenados =
                        List<Map<dynamic, dynamic>>.from(
                            dataProvider.datosTiempoRealList);
                    datosOrdenados
                        .sort((a, b) => b['timestamp'] - a['timestamp']);
                    return ListView.builder(
                      itemCount: datosOrdenados.length,
                      itemBuilder: (context, index) {
                        final date = DateTime.fromMillisecondsSinceEpoch(
                            datosOrdenados[index]['timestamp']);
                        final bpm = datosOrdenados[index]['bpm'];
                        final oxigenacion =
                            datosOrdenados[index]['oxigenacion'];
                        Color bpmColor = Colors.green;

                        if (edadmeses > 0 && edadmeses <= 1) {
                          estadobpm =
                              bpm >= 70 && bpm <= 190 ? 'Normal' : 'ALERTA';
                          bpmColor = bpm >= 70 && bpm <= 190
                              ? Colors.green
                              : Colors.red;
                        } else if (edadmeses > 1 && edadmeses <= 11) {
                          estadobpm =
                              bpm >= 80 && bpm <= 160 ? 'Normal' : 'ALERTA';
                          bpmColor = bpm >= 80 && bpm <= 160
                              ? Colors.green
                              : Colors.red;
                        } else if (edadmeses > 11 && edadmeses <= 24) {
                          estadobpm =
                              bpm >= 80 && bpm <= 130 ? 'Normal' : 'ALERTA';
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
                          decoration: InformationCard.myboxdecoration(
                              Color(0xffffffff)),
                          margin: EdgeInsets.all(3),
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  style:
                                      TextStyle(color: bpmColor, fontSize: 12),
                                ),
                              ),
                              Container(
                                width: screenWidth / 4.5,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  '${oxigenacion.toStringAsFixed(2)}%\n$estadooxi',
                                  style: TextStyle(
                                      color: oxigenacionColor, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
