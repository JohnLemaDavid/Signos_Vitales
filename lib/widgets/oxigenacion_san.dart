import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:signos_vitales/providers/datos_real_provider.dart';

class OxigenMedition extends StatelessWidget {
  const OxigenMedition({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Image(
              height: size.width / 7,
              image: AssetImage('assets/images/pulom.png'),
            ),
          ),
          Text(
            'Oxigenacion\nen sangre',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
          Consumer<RealtimeProvider>(
            builder: (context, provider, child) {
              return Text(
                '${provider.datos.oxigenacion}' + '%',
                style: TextStyle(fontSize: 20),
              );
            },
          ),
        ],
      ),
    );
  }
}
