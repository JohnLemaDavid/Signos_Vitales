import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:signos_vitales/screens/form_crear.dart';
import 'package:signos_vitales/ui/information_card_decoration.dart';
import 'package:signos_vitales/widgets/container_seleccionado.dart';
import 'package:signos_vitales/widgets/swiper_card.dart';
import 'package:signos_vitales/widgets/container_todos.dart';
import 'package:signos_vitales/widgets/widgets.dart';
import '../providers/mapa_seleccionado.dart';

class SignosScreenResponsive extends StatelessWidget {
  final databaseRef = FirebaseDatabase.instance.ref();
  Map<dynamic, dynamic> data = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: CustomPaint(
                painter: _HeaderCurvoPainter(context),
              )),
          SafeArea(
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/svgs/neurovertical.svg',
                  height: 40,
                ),
                SizedBox(height: 5),
                Text(
                  'DATOS',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "SF_UI_display",
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
          ),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double height = constraints.maxHeight;
              final double width = constraints.maxWidth;
              return Column(
                children: [
                  Consumer<PerfilSeleccionado>(
                    builder: (context, estado, child) {
                      print(estado.isNull());
                      print('estado del consumer');
                      if (estado.isNull()) {
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: height * 0.15),
                              height: height * 0.50,
                              width: width,
                              alignment: Alignment.center,
                              child: Perfiles(height: height * 0.6),
                            ),
                            EsperandoSeleccion(height: height * 0.53),
                          ],
                        );
                      } else {
                        return Column(children: [
                          ChildActual(
                            childData: estado.myMap as Map,
                            height: height * 0.55,
                          ),
                          SignosVitales(height: height * 0.42),
                        ]);
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  PreferredSize Encabezado() {
    return PreferredSize(
      preferredSize: Size.fromHeight(40),
      child: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svgs/logointento3.svg',
              height: 16,
            ),
            SizedBox(width: 10),
            Text(
              'DATOS',
              style: TextStyle(
                  fontFamily: "SF_UI_display",
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ],
        ),
        centerTitle: true,
      ),
    );
  }

  FutureBuilder<DatabaseEvent> Perfiles({required double height}) {
    return FutureBuilder(
      future: databaseRef.child('Usuario').once(),
      builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
        if (snapshot.hasData) {
          List<Widget> elements = [];
          final data =
              (snapshot.data!.snapshot.value as Map?)?.cast<dynamic, dynamic>();
          if (data != null) {
            List<MapEntry<dynamic, dynamic>> sortedEntries = data.entries
                .toList()
              ..sort((e1, e2) => e2.value['fecha_creacion']
                  .compareTo(e1.value['fecha_creacion']));
            sortedEntries.forEach((entry) {
              Map<dynamic, dynamic> childData = entry.value;
              print(childData);
              Widget element = ChildContainer(
                childData: childData,
                height: height,
              );
              elements.add(element);
            });
          } else {
            return Center(
              child: Container(
                child: Text('La base de datos está vacía.'),
              ),
            );
          }
          return SliderContainer(elements: elements, height: height * 0.92);
        } else {
          return Center(
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: CircularProgressIndicator(
                strokeWidth: 4.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
              ),
            ),
          );
        }
      },
    );
  }
}

class _crearnuevo extends StatelessWidget {
  const _crearnuevo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FormularioScreenCrear()),
        );
      },
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: (Colors.transparent),
          shadowColor: Colors.transparent),
      child: Text(
        'Crear Perfil',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}

class EsperandoSeleccion extends StatelessWidget {
  final height;

  const EsperandoSeleccion({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height * 0.6,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: InformationCard.myboxdecoration(Color(0xfff3f4f9)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Image(
                height: height / 5.3,
                image: AssetImage('assets/images/tabla.png'),
              ),
            ),
            Text(
              'SELECCIONA ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'un perfil ya creado para\nempezar o medir los signos\nvitales,o crea un nuevo perfil ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            Container(
              height: 30,
              child: _crearnuevo(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
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
            )
          ],
        ));
  }
}

class SignosVitales extends StatelessWidget {
  final height;

  const SignosVitales({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: _ElementosMedidos());
  }
}

class _ElementosMedidos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                      height: 200,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration:
                          InformationCard.myboxdecoration(Color(0xfff3f4f9)),
                      child: FrecuencyHeart()),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration:
                          InformationCard.myboxdecoration(Color(0xfff3f4f9)),
                      child: OxigenMedition()),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: InformationCard.myboxdecoration(Color(0xfff3f4f9)),
              height: double.infinity,
              child: Posicion(),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderCurvoPainter extends CustomPainter {
  late Size _screenSize;

  _HeaderCurvoPainter(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = new Paint();

    // Propiedades
    final Gradient gradiente = new LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF916df1), Color(0xFF7746ff)],
      stops: [
        0.0,
        0.9,
      ],
    );

    lapiz.shader = gradiente.createShader(
        Rect.fromLTWH(0.0, 0.0, _screenSize.width, _screenSize.height));
    lapiz.style = PaintingStyle.fill; // .fill .stroke
    lapiz.strokeWidth = 20;

    final path = new Path();

    // Dibujar con el path y el lapiz
    path.lineTo(0, _screenSize.height * 0.10);
    path.quadraticBezierTo(_screenSize.width * 0.5, _screenSize.height * 0.15,
        _screenSize.width, _screenSize.height * 0.10);
    path.lineTo(_screenSize.width, 0);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
