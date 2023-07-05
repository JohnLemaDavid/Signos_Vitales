import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:signos_vitales/models/eliminar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:signos_vitales/screens/screens.dart';

import '../providers/mapa_seleccionado.dart';

class ChildContainer extends StatelessWidget {
  final Map<dynamic, dynamic> childData;
  final double height;

  ChildContainer({Key? key, required this.childData, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      margin: EdgeInsets.only(left: 25, right: 32, bottom: height * 0.02),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.40),
            spreadRadius: 1,
            blurRadius: 6,
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
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Image(
              image: AssetImage(
                childData['sexo'] == 'hombre'
                    ? 'assets/images/baby-boy.png'
                    : 'assets/images/baby-girl.png',
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            '${childData['nombre']} ${childData['apellido']}',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(height: 5),
          Container(
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white, width: 0.3),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Edad:',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                '${childData['edad']} meses',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white, width: 0.3),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Alimentado:',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                childData['alimentado'] ? 'Sí' : 'No',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white, width: 0.3),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Vestimenta:',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                childData['prenda'],
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white, width: 0.3),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lugar de descanso:',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                childData['descanso'],
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 0.3),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Observaciones:',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          childData['observaciones'],
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        alignment: Alignment.center,
                        child: _Empezar(childData: childData),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 22,
                              alignment: Alignment.center,
                              child: _EditarPerfil(childData: childData)),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 22,
                            alignment: Alignment.center,
                            child: _eliminar(childData: childData),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _eliminar extends StatelessWidget {
  const _eliminar({
    Key? key,
    required this.childData,
  }) : super(key: key);

  final Map childData;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // Comprobar si hay conexión a internet
        ConnectivityResult connectivityResult =
            await Connectivity().checkConnectivity();
        if (connectivityResult == ConnectivityResult.none) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Problema de conexión'),
                content:
                    Text('Revisa tu conexión a Internet e intenta nuevamente.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Aceptar'),
                  ),
                ],
              );
            },
          );
          return;
        }

        // Comprobar si hay conexión con Firebase
        try {
          await Firebase.initializeApp();
          await FirebaseDatabase.instance.ref().child('test').once();
        } on FirebaseException catch (e) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Problema con el servidor'),
                content: Text(e.message ?? 'Error al conectar con Firebase'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Aceptar'),
                  ),
                ],
              );
            },
          );
          return;
        }

        final eliminarData = EliminarData(data: childData);

        bool? result = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Center(
                child: Text(
                  '¿Estás seguro de eliminar los datos?\nRecuerde que se eliminara todos lo datos y mediciones anteriores?',
                  textAlign: TextAlign.center,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text('Aceptar'),
                ),
              ],
            );
          },
        );

        if (result != null && result) {
          await eliminarData.eliminar();

          childData.forEach((key, value) {
            print('$key: $value');
          });

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return FutureBuilder(
                future: Future.delayed(Duration(seconds: 5), () => true),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return AlertDialog(
                      title: Text('Guardando datos...'),
                      content: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 4.0,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                        ),
                      ),
                    );
                  } else {
                    if (snapshot.hasError || !snapshot.data!) {
                      return AlertDialog(
                        title: Text('Error al guardar datos'),
                        content: Text(
                            'Revisa tu conexión a Internet e intenta nuevamente.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Aceptar'),
                          ),
                        ],
                      );
                    } else {
                      return Container(); // Puedes retornar un widget vacío
                    }
                  }
                },
              );
            },
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.delete_forever_outlined,
            size: 20,
          ),
          SizedBox(width: 5),
          Text(
            'Eliminar ',
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class _Empezar extends StatelessWidget {
  const _Empezar({
    Key? key,
    required this.childData,
  }) : super(key: key);

  final Map childData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [
              0.1,
              0.7,
              1.0
            ],
            colors: [
              Color(0xFF21BCBE),
              Color(0xFF5CE4D8),
              Color(0xFF9cf6ed),
            ]),
      ),
      height: 22,
      child: ElevatedButton(
        onPressed: () {
          DatabaseReference nodeRef =
              FirebaseDatabase.instance.ref().child('DatoTiempoReal');
          nodeRef.remove().then((_) {
            print("Nodo eliminado exitosamente");
          }).catchError((error) {
            print("Error al eliminar el nodo: $error");
          });

          Provider.of<PerfilSeleccionado>(context, listen: false)
              .setMyMap(childData);
        },
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: (Colors.transparent),
            shadowColor: Colors.transparent),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.play_circle_outline_outlined,
              color: Colors.white,
              size: 15,
            ),
            SizedBox(width: 5),
            Text(
              'EMPEZAR',
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class _EditarPerfil extends StatelessWidget {
  _EditarPerfil({
    Key? key,
    required this.childData,
  }) : super(key: key);

  final Map childData;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FormularioScreenEdit(
                    data: childData,
                  )),
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white, // color del texto negro
        elevation: 5,
        // sombreado
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.edit_calendar_outlined,
            size: 15,
          ),
          SizedBox(width: 5),
          Text(
            'Editar Perfil',
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
