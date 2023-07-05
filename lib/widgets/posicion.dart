import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../providers/datos_real_provider.dart';

class Posicion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'POSICION',
            style: TextStyle(fontSize: 30),
          ),
          Consumer<RealtimeProvider>(
            builder: (context, provider, child) {
              if (provider.datos.posicion == "1") {
                return SvgPicture.asset(
                  'assets/svgs/bebefrente.svg',
                  height: 100,
                );
              }
              if (provider.datos.posicion == "2") {
                return SvgPicture.asset(
                  'assets/svgs/bebelado.svg',
                  height: 100,
                );
              }
              if (provider.datos.posicion == "3") {
                return SvgPicture.asset(
                  'assets/svgs/bebeespalda.svg',
                  height: 100,
                );
              } else
                return SvgPicture.asset(
                  'assets/svgs/bebeespalda.svg',
                  height: 100,
                );
            },
          ),
        ],
      ),
    );
  }
}
