import 'package:flutter/material.dart';
import 'package:flutter_tienda_comida/utils/dimensiones.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;

  BigText({Key? key, this.color = const Color(0xFF3322d2b), this.size=0, required this.text, this.overflow=TextOverflow.ellipsis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontSize: size == 0 ? Dimenciones.font20 : 0,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400
      ),
    );
  }
}