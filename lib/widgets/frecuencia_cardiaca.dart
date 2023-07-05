import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:signos_vitales/providers/datos_real_provider.dart';

class FrecuencyHeart extends StatelessWidget {
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
              image: AssetImage('assets/images/corazon.png'),
            ),
          ),
          Text(
            'Frecuencia\ncardíaca',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
          Consumer<RealtimeProvider>(
            builder: (context, provider, child) {
              return Text(
                '${provider.datos.bpm}',
                style: TextStyle(fontSize: 20),
              );
            },
          ),
        ],
      ),
    );
  }
}
