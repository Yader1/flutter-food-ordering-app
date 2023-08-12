import 'package:flutter/material.dart';
import 'package:flutter_tienda_comida/utils/colors.dart';

import '../utils/dimensiones.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimenciones.height20*5,
        width: Dimenciones.height20*5,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimenciones.height20*5/2),
          color: AppColors.mainColor
        ),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}