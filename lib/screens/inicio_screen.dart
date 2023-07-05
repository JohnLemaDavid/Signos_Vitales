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

class InicioScreen extends StatelessWidget {
  final databaseRef = FirebaseDatabase.instance.ref();
  Map<dynamic, dynamic> data = {};
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            top: size.height / 2.3,
            child: Container(
                width: size.width,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                decoration: InformationCard.myboxdecoration(Color(0xfff3f4f9)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'BIENVENIDO ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Bienvenido a la aplicacion para el\nmonitoreo de signos vitales de tu bebe.\nCrea un perfil para empezar a medir su\nfrecuencia cardiaca,\noxigeno en la sangre y su posicion',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                )),
          ),
          SizedBox(
              width: size.width,
              height: size.height,
              child: CustomPaint(
                painter: _HeaderCurvoPainter(context),
              )),
          Positioned(
            top: 0,
            left: size.width / 6.5,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: SvgPicture.asset(
                      'assets/svgs/neurovertical.svg',
                      height: 60,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: size.width / 1.6,
                    child: Image(
                      image: AssetImage('assets/images/ini.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            top: size.height / 1.28,
            bottom: size.height / 12,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: size.width / 4),
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
            ),
          )
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
    path.lineTo(0, _screenSize.height * 0.50);
    path.quadraticBezierTo(_screenSize.width * 0.5, _screenSize.height * 0.57,
        _screenSize.width, _screenSize.height * 0.50);
    path.lineTo(_screenSize.width, 0);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _crearnuevo extends StatelessWidget {
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
        style: TextStyle(fontSize: 30, color: Colors.white),
      ),
    );
  }
}
