import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:signos_vitales/models/modificar.dart';
import 'package:signos_vitales/screens/home_screen.dart';
import 'package:signos_vitales/ui/ui_TextForm.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class FormularioScreenEdit extends StatefulWidget {
  final Map<dynamic, dynamic> data;
  FormularioScreenEdit({required this.data});

  @override
  _FormularioScreenEditState createState() => _FormularioScreenEditState();
}

class _FormularioScreenEditState extends State<FormularioScreenEdit> {
  final databaseRef = FirebaseDatabase.instance.ref();
  final _formKey = GlobalKey<FormState>();
  Map<dynamic, dynamic> _data = {
    'nombre': '',
    'apellido': '',
    'sexo': '',
    'edad': '',
    'prenda': '',
    'descanso': '',
    'alimentado': '',
    'observaciones': '',
  };

  bool _hombreSeleccionado = true;
  bool _mujerSeleccionado = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    _data = widget.data;
    bool _recienAlimentado = widget.data['alimentado'];
    if (widget.data['sexo'] == 'hombre') {
      _hombreSeleccionado = true;
      _mujerSeleccionado = false;
    } else {
      _hombreSeleccionado = false;
      _mujerSeleccionado = true;
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Icon(Icons.arrow_back),
        backgroundColor: Color(0xFF7746ff),
      ),
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
                  'EDITAR DATOS',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "SF_UI_display",
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            width: screenSize.width * 0.90,
            margin: EdgeInsetsDirectional.only(
                top: screenSize.height * 0.13,
                bottom: screenSize.height * 0.04),
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 0.2,
                  blurRadius: 5,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF916df1), Color(0xFF7746ff)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        initialValue: widget.data['nombre'],
                        enabled: false,
                        style: TextStyle(color: Colors.white),
                        autocorrect: false,
                        enableSuggestions: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 5.0),
                          labelText: 'Nombre',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          filled: false,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.person_outline_sharp,
                            color: Colors.white,
                          ),
                          border: InputBorder.none,
                          errorStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '   Por favor ingrese su nombre';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _data['nombre'] = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF916df1), Color(0xFF7746ff)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        initialValue: widget.data['apellido'],
                        enabled: false,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 5.0),
                            labelText: 'Apellido',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            filled: false,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.person_outline_sharp,
                              color: Colors.white,
                            ),
                            errorStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                            border: InputBorder.none),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese su apellido';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _data['apellido'] = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Color(0xFF916df1), width: 1),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Sexo:',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _data['sexo'] = 'hombre';
                                    _hombreSeleccionado = true;
                                    _mujerSeleccionado = false;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                        _data['sexo'] == 'hombre'
                                            ? 'assets/images/baby-boy.png'
                                            : 'assets/images/baby-boy.png',
                                      ),
                                      height: _hombreSeleccionado ? 80.0 : 50.0,
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      'Niño',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _data['sexo'] = 'mujer';
                                    _hombreSeleccionado = false;
                                    _mujerSeleccionado = true;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                        _data['sexo'] == 'mujer'
                                            ? 'assets/images/baby-girl.png'
                                            : 'assets/images/baby-girl.png',
                                      ),
                                      height: _mujerSeleccionado ? 80.0 : 50.0,
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      'Niña',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Color(0xFF916df1), width: 1),
                      ),
                      child: TextFormField(
                        initialValue: widget.data['edad'].toString(),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 5.0),
                            labelText: 'Edad:',
                            labelStyle: TextStyle(
                              color: Color(0xFF916df1),
                            ),
                            filled: false,
                            fillColor: Color(0xFF916df1),
                            prefixIcon: SvgPicture.asset(
                              'assets/icons/edad.svg',
                              height: 2,
                            ),
                            border: InputBorder.none),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese su edad';
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _data['edad'] = value != '' ? int.parse(value) : 0;
                            print(_data['edad']);
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Color(0xFF916df1), width: 1),
                      ),
                      child: TextFormField(
                        initialValue: widget.data['prenda'],
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 5.0),
                            labelText: 'Prenda que usa:',
                            labelStyle: TextStyle(
                              color: Color(0xFF916df1),
                            ),
                            filled: false,
                            fillColor: Color(0xFF916df1),
                            prefixIcon: SvgPicture.asset(
                              'assets/icons/prenda.svg',
                              height: 2,
                            ),
                            border: InputBorder.none),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese su prenda que usa';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _data['prenda'] = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Color(0xFF916df1), width: 1),
                      ),
                      child: TextFormField(
                        initialValue: widget.data['descanso'],
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 5.0),
                            labelText: 'Lugar de descanso:',
                            labelStyle: TextStyle(
                              color: Color(0xFF916df1),
                            ),
                            filled: false,
                            fillColor: Color(0xFF916df1),
                            prefixIcon: SvgPicture.asset(
                              'assets/icons/descanso.svg',
                              height: 2,
                            ),
                            border: InputBorder.none),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese su lugar de descanso';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _data['descanso'] = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF916df1), Color(0xFF7746ff)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '   ¿Se encuentra recién alimentado?    ',
                            style:
                                TextStyle(fontSize: 13.0, color: Colors.white),
                          ),
                          Text(
                            'No',
                            style:
                                TextStyle(fontSize: 13.0, color: Colors.white),
                          ),
                          Switch(
                            value: _recienAlimentado,
                            onChanged: (value) {
                              setState(() {
                                _recienAlimentado = value;
                                _data['alimentado'] = value;
                              });
                            },
                            activeColor: Colors.white,
                          ),
                          Text(
                            'Si',
                            style:
                                TextStyle(fontSize: 13.0, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Color(0xFF916df1), width: 1),
                      ),
                      child: TextFormField(
                        initialValue: widget.data['observaciones'],
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 5.0),
                            labelText: 'Observaciones:',
                            labelStyle: TextStyle(
                              color: Color(0xFF916df1),
                            ),
                            filled: false,
                            fillColor: Color(0xFF916df1),
                            prefixIcon: Icon(
                              Icons.note_add,
                              color: Color(0xFF916df1),
                              size: 40,
                            ),
                            border: InputBorder.none),
                        maxLines: 5,
                        onChanged: (value) {
                          setState(() {
                            _data['observaciones'] = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF916df1), Color(0xFF7746ff)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _ConfirmarBoton(formKey: _formKey, data: _data)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConfirmarBoton extends StatelessWidget {
  const _ConfirmarBoton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required Map data,
  })  : _formKey = formKey,
        _data = data,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final Map _data;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();

          // Comprobar si hay conexión a internet
          ConnectivityResult connectivityResult =
              await Connectivity().checkConnectivity();
          if (connectivityResult == ConnectivityResult.none) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Problema de conexión'),
                  content: Text(
                      'Revisa tu conexión a Internet e intenta nuevamente.'),
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

          final changeData = ChangeData(data: _data);

          bool? result = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('¿Estás seguro de modificar los datos?'),
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
            await changeData.change();

            _data.forEach((key, value) {
              print('$key: $value');
            });

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return FutureBuilder(
                  future: Future.delayed(Duration(seconds: 5), () => true),
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return AlertDialog(
                        title: Text('Guardando datos..'),
                        content: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 4.0,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.deepPurple),
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
        }
      },
      child: Text('Guardar'),
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
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
    path.lineTo(0, _screenSize.height * 0.20);
    path.quadraticBezierTo(_screenSize.width * 0.5, _screenSize.height * 0.3,
        _screenSize.width, _screenSize.height * 0.20);
    path.lineTo(_screenSize.width, 0);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
