import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensiones.dart';
import '../widgets/big_text.dart';

class CommonTextButton extends StatelessWidget {
  final String text;
  const CommonTextButton({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Dimenciones.height20, bottom: Dimenciones.height20, left: Dimenciones.width20, right: Dimenciones.width20),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              blurRadius: 10.0,
              color: AppColors.mainColor.withOpacity(0.3)
            )
          ],
          borderRadius: BorderRadius.circular(Dimenciones.radius20),
          color: AppColors.mainColor
      ),
      child: Center(child: BigText(text: text, color: Colors.white)),
    );
  }
}
